local tags = import 'tags.libsonnet';
{
  new(vars, subnets)::
    {
      [vars.aws.eks.name]: {
        name: vars.aws.eks.name,
        role_arn: '${aws_iam_role.eks_service_role.arn}',
        version: vars.aws.eks.version,
        enabled_cluster_log_types: ['api', 'audit'],
        vpc_config: {
          subnet_ids: [
            '${aws_subnet.' + subnet_name + '.id}'
            for subnet_name in std.objectFields(subnets)
          ],
          endpoint_private_access: true,
          endpoint_public_access: vars.aws.eks.enable_endpoint_public_access,
          public_access_cidrs: ['0.0.0.0/0'],
        },
        tags: tags.common(name=vars.aws.eks.name, env=vars.env, owner=vars.project_name),
        depends_on: [
          'aws_iam_role_policy_attachment.attach_eks_cluster_policy',
        ],
      },
    },

}
