local tags = import 'tags.libsonnet';
{
  new(vars, nat_gateways)::
    {
      [vars.aws.eks.internet_gateway_name + '_igw_route_table']: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        route: [
          {
            cidr_block: '0.0.0.0/0',
            carrier_gateway_id: '',
            destination_prefix_list_id: '',
            egress_only_gateway_id: '',
            instance_id: '',
            ipv6_cidr_block: null,
            local_gateway_id: '',
            nat_gateway_id: '',
            gateway_id: '${aws_internet_gateway.' + vars.aws.eks.internet_gateway_name + '.id}',
            network_interface_id: null,
            transit_gateway_id: '',
            vpc_endpoint_id: '',
            vpc_peering_connection_id: '',
            core_network_arn: '',
          },
        ],
        tags: {
          Name: vars.aws.eks.internet_gateway_name + '_igw_route_table',
          env: vars.env,
          owner: vars.project_name,
        },
      },
    } +
    {
      [nat_gateway]: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        route: [
          {
            cidr_block: '0.0.0.0/0',
            carrier_gateway_id: '',
            destination_prefix_list_id: '',
            egress_only_gateway_id: '',
            instance_id: '',
            ipv6_cidr_block: null,
            local_gateway_id: '',
            nat_gateway_id: '${aws_nat_gateway.' + nat_gateway + '.id}',
            gateway_id: '',
            network_interface_id: null,
            transit_gateway_id: '',
            vpc_endpoint_id: '',
            vpc_peering_connection_id: '',
            core_network_arn: '',
          },
        ],
        tags: {
          Name: nat_gateway,
          env: vars.env,
          owner: vars.project_name,
        },
      }
      for nat_gateway in std.objectFields(nat_gateways)
    },

}
