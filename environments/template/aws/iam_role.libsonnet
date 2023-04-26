local tags = import 'tags.libsonnet';
{
  newEksRoles(vars):: {
    eks_service_role: {
      name: 'eks_service_role',
      assume_role_policy: std.toString({
        Version: '2012-10-17',
        Statement: [
          {
            Effect: 'Allow',
            Principal: {
              Service: 'eks.amazonaws.com',
            },
            Action: 'sts:AssumeRole',
          },
        ],
      }),
    },
    eks_node_role: {
      name: 'eks_node_role',
      assume_role_policy: std.toString({
        Version: '2012-10-17',
        Statement: [
          {
            Effect: 'Allow',
            Principal: {
              Service: 'ec2.amazonaws.com',
            },
            Action: 'sts:AssumeRole',
          },
        ],
      }),
    },
  },
}
