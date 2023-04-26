local tags = import 'tags.libsonnet';
{


  new(vars, subnets)::
    {
      [vars.aws.eks.private_node_group.name]: {
        cluster_name: vars.aws.eks.name,
        node_group_name: vars.aws.eks.private_node_group.name,
        node_role_arn: '${aws_iam_role.eks_node_role.arn}',
        release_version: vars.aws.eks.ami.release_version,
        ami_type: vars.aws.eks.ami.ami_type,
        disk_size: vars.aws.eks.private_node_group.disk_size,
        scaling_config: vars.aws.eks.private_node_group.scaling_config {
          assert self.max_size >= self.min_size : 'value of max_size > value of min_size in scaling_config',
        },
        update_config: {
          max_unavailable: 1,
        },
        subnet_ids: [
          '${aws_subnet.' + subnet_name + '.id}'
          for subnet_name in std.objectFields(subnets)
          if std.startsWith(subnet_name, 'private_app_')
        ],
        instance_types: vars.aws.private_app_subnet_instance_types,
        depends_on: [
          'aws_eks_cluster.' + vars.aws.eks.name,
          'aws_iam_role_policy_attachment.attach_eks_workernode_policy',
          'aws_iam_role_policy_attachment.attach_eks_cni_policy',
          'aws_iam_role_policy_attachment.attach_eks_ec2_container_registry_read_only_policy',
          'aws_iam_role_policy_attachment.attach_eks_ssm_managed_instance_core_policy',
        ],
        lifecycle:{
          ignore_changes: ["scaling_config[0].desired_size"]
        },
        labels: {
          env: vars.env,
          owner: vars.project_name,
        },
      },
      [vars.aws.eks.db_node_group.name]: {
        cluster_name: vars.aws.eks.name,
        node_group_name: vars.aws.eks.db_node_group.name,
        node_role_arn: '${aws_iam_role.eks_node_role.arn}',
        release_version: vars.aws.eks.ami.release_version,
        ami_type: vars.aws.eks.ami.ami_type,
        disk_size: vars.aws.eks.db_node_group.disk_size,
        scaling_config: vars.aws.eks.db_node_group.scaling_config {
          assert self.max_size >= self.min_size : 'value of max_size > value of min_size in scaling_config',
        },
        update_config: {
          max_unavailable: 1,
        },
        subnet_ids: [
          '${aws_subnet.' + subnet_name + '.id}'
          for subnet_name in std.objectFields(subnets)
          if std.startsWith(subnet_name, 'private_db_')
        ],
        instance_types: vars.aws.private_app_subnet_instance_types,
        depends_on: [
          'aws_eks_cluster.' + vars.aws.eks.name,
          'aws_iam_role_policy_attachment.attach_eks_workernode_policy',
          'aws_iam_role_policy_attachment.attach_eks_cni_policy',
          'aws_iam_role_policy_attachment.attach_eks_ec2_container_registry_read_only_policy',
          'aws_iam_role_policy_attachment.attach_eks_ssm_managed_instance_core_policy',
        ],
        labels: {
          env: vars.env,
        },
      },
      [vars.aws.eks.public_node_group.name]: {
        cluster_name: vars.aws.eks.name,
        node_group_name: vars.aws.eks.public_node_group.name,
        node_role_arn: '${aws_iam_role.eks_node_role.arn}',
        release_version: vars.aws.eks.ami.release_version,
        ami_type: vars.aws.eks.ami.ami_type,
        disk_size: vars.aws.eks.public_node_group.disk_size,
        scaling_config: vars.aws.eks.public_node_group.scaling_config {
          assert self.max_size >= self.min_size : 'value of max_size > value of min_size in scaling_config',
        },
        update_config: {
          max_unavailable: 1,
        },
        subnet_ids: [
          '${aws_subnet.' + subnet_name + '.id}'
          for subnet_name in std.objectFields(subnets)
          if std.startsWith(subnet_name, 'public')
        ],
        instance_types: vars.aws.public_subnet_instance_types,
        depends_on: [
          'aws_eks_cluster.' + vars.aws.eks.name,
          'aws_iam_role_policy_attachment.attach_eks_workernode_policy',
          'aws_iam_role_policy_attachment.attach_eks_cni_policy',
          'aws_iam_role_policy_attachment.attach_eks_ec2_container_registry_read_only_policy',
          'aws_iam_role_policy_attachment.attach_eks_ssm_managed_instance_core_policy',
        ],
        labels: {
          env: vars.env,
          Name: vars.aws.eks.public_node_group.name,
        },
      },
    },

}
