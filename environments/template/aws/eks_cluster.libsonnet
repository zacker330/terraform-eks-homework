local tags = import 'tags.libsonnet';
{
  new(vars, subnets)::
    {
      [vars.aws.eks.name]: {
        name: vars.aws.eks.name,
        role_arn: '${aws_iam_role.eks_service_role.arn}',
        version: vars.aws.eks.version,
        enabled_cluster_log_types: if vars.aws.eks.enabled_cluster_log then ['api', 'audit'] else [],
        vpc_config: {
          subnet_ids: [
            '${aws_subnet.' + subnet_name + '.id}'
            for subnet_name in std.objectFields(subnets)
          ],
          security_group_ids:[
            "${aws_security_group."+ vars.aws.eks.eks_security_group_name  +".id}",
            "${aws_security_group."+ vars.aws.eks.node_security_group_name  +".id}",
          ],
          endpoint_private_access: true,
          endpoint_public_access: vars.aws.eks.enable_endpoint_public_access,
          public_access_cidrs: ['0.0.0.0/0'],
        },
        tags: tags.common(name=vars.aws.eks.name, env=vars.env, owner=vars.project_name),
        depends_on: [
          'aws_iam_role_policy_attachment.attach_eks_cluster_policy',
          "aws_cloudwatch_log_group." + vars.aws.eks.name,
        ],
      },
    },

}
