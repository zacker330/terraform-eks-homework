local eip = import 'eip.libsonnet';
local eks_cluster = import 'eks_cluster.libsonnet';
local eks_node_group = import 'eks_node_group.libsonnet';
local iam_role = import 'iam_role.libsonnet';
local iam_role_policy_attachment = import 'iam_role_policy_attachment.libsonnet';
local internet_gateway = import 'internet_gateway.libsonnet';
local nat_gateway = import 'nat_gateway.libsonnet';
local route_table = import 'route_table.libsonnet';
local route_table_association = import 'route_table_association.libsonnet';
local subnet = import 'subnet.libsonnet';
local tags = import 'tags.libsonnet';
local vpc = import 'vpc.libsonnet';
local cloudwatch_log_group = import "cloudwatch_log_group.libsonnet";
local default_vars = {
  env: error 'env value is required',
};

{
  new(vars=default_vars, secrets):: {
    local it = self,
    local nat_eip_name = vars.aws.eks.name + '_nat',
    local aws_nat_gateway_name = vars.aws.eks.name + '_nat_gateway',

    terraform: {
      required_providers: {
        postgresql: {
          //doc https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs
          source: 'cyrilgdn/postgresql',
          version: '1.19.0',
        },
        aws: {
          source: 'hashicorp/aws',
          version: '4.64.0',
        },
      },
      backend: vars.terraform.backend,
    },
    provider: {
      postgresql: {
        host: '127.0.0.1',
        port: 5432,
        database: 'postgres',
        username: secrets.postgresql.auth.username,
        password: secrets.postgresql.auth.password,
        sslmode: 'disable',
        connect_timeout: 15,
      },
      aws: vars.terraform.provider.aws,
    },
    resource: {
      aws_vpc: vpc.new(vars),
      aws_internet_gateway: internet_gateway.new(vars),
      _subnets:: subnet.new(vars),
      aws_subnet: it.resource._subnets,
      aws_eip: eip.newNat(vars, it.resource._subnets),
      aws_nat_gateway: nat_gateway.new(vars, it.resource._subnets),
      aws_route_table: route_table.new(vars, it.resource.aws_nat_gateway),
      aws_route_table_association: route_table_association.new(vars, std.objectFields(it.resource.aws_subnet), std.objectFields(it.resource.aws_nat_gateway)),
      aws_iam_role: iam_role.newEksRoles(vars),
      aws_iam_role_policy_attachment: iam_role_policy_attachment.new(vars),
      aws_eks_cluster: eks_cluster.new(vars, it.resource._subnets),
      aws_eks_node_group: eks_node_group.new(vars, it.resource._subnets),
      aws_cloudwatch_log_group: cloudwatch_log_group.newEksLog(vars),
    },  // end of resource,
    output: {
      eks_endpoint: {
        value: '${aws_eks_cluster.' + vars.aws.eks.name + '.endpoint}',
      },
      'kubeconfig-certificate-authority-data': {
        value: '${aws_eks_cluster.' + vars.aws.eks.name + '.certificate_authority[0].data}',
        sensitive: true,
      },
    },  // end of output node
  },
}
