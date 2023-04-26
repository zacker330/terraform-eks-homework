local tags = import 'tags.libsonnet';
{
  new(vars)::
    {
      ['public_' + vars.aws.eks.name + '_' + i]: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        availability_zone: vars.aws.vpc.availability_zones[i % std.length(vars.aws.vpc.public_subnets)],
        cidr_block: vars.aws.vpc.public_subnets[i],
        map_public_ip_on_launch: true,
        tags: tags.common(name=vars.project_name + '_public_' + i,env= vars.env, owner=vars.project_name)+{
          immutable_metadata: '{ "purpose": "external_' + vars.aws.vpc.name + '", "target": null }',
          Network: 'public',
          'kubernetes.io/role/elb': 1,
          ['kubernetes.io/cluster/' + vars.aws.eks.name]: 'owned',
        },
      }
      for i in std.range(0, std.length(vars.aws.vpc.public_subnets) - 1)
    }
    +
    {
      ['private_' + vars.aws.eks.name + '_' + i]: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        availability_zone: vars.aws.vpc.availability_zones[i % std.length(vars.aws.vpc.private_subnets)],
        cidr_block: vars.aws.vpc.private_subnets[i],
        tags: tags.common(name=vars.project_name + '_private_' + i,env= vars.env, owner=vars.project_name)+{
          immutable_metadata: '{ "purpose": "' + vars.aws.vpc.name + '", "target": null }',
          Network: 'private',
          'kubernetes.io/role/internal-elb': 1,
          ['kubernetes.io/cluster/' + vars.aws.eks.name]: 'owned',
        },
      }
      for i in std.range(0, std.length(vars.aws.vpc.private_subnets) - 1)
    }
}
