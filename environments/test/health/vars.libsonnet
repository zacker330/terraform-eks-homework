local secrets = import "secrets.libsonnet";
{
  local it = self,
  env: 'test',
  project_name: 'health',
  terraform:{
      backend:{pg: {
        conn_str: 'postgres://'+secrets.postgresql.auth.username+':'+secrets.postgresql.auth.password+'@127.0.0.1:5432/terraform_bankend?sslmode=disable',
      }},
      provider:{
        aws:{
          region: it.aws.region,
        }
      }
  },
  aws: {
    region: 'ap-southeast-2',
    vpc: {
      name: it.project_name + '_' + it.env + '_main',
      cidr: '10.101.0.0/16',
      availability_zones: [it.aws.region + 'b', it.aws.region + 'c'],
      private_subnets: ['10.101.3.0/24', '10.101.4.0/24'],
      public_subnets: ['10.101.0.0/24', '10.101.1.0/24'],
    },
    eks:{
      version: 1.25,
      name: it.project_name + '_' + it.env + '_main',
      ami: {
        release_version: '1.25.7-20230411',
        ami_type: 'AL2_x86_64',  // AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
      },
      enable_endpoint_public_access: true,
      enabled_cluster_log: true,
      internet_gateway_name: it.project_name + '_' + it.env + '_main',
      public_node_group: {
        name: it.aws.eks.name + '_public_node_group',
        disk_size: 10,
        scaling_config: {
          desired_size: 0,
          max_size: 2,
          min_size: 0,
        },
      },
      private_node_group: {
        name: it.aws.eks.name + '_private_app_node_group',
        disk_size: 10,
        scaling_config: {
          desired_size: 1,
          max_size: 2,
          min_size: 0,
        },
      },
    },


    //    https://aws.amazon.com/ec2/instance-types/#Compute_Optimized
    public_subnet_instance_types: ['t2.small', 't2.medium'],
    private_subnet_instance_types: ['t2.small', 't2.medium'],
    all_subnet_cidr_block: self.public_subnet_cidr_block + self.private_subnet_cidr_block,
  },
}
