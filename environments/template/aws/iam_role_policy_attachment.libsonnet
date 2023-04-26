local tags = import"tags.libsonnet";
{
  new(vars)::{
                     attach_eks_cluster_policy: {
                       role: '${aws_iam_role.eks_service_role.name}',
                       policy_arn: 'arn:aws:iam::aws:policy/AmazonEKSClusterPolicy',
                     },
                     attach_eks_workernode_policy: {
                       role: '${aws_iam_role.eks_node_role.name}',
                       policy_arn: 'arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy',
                     },

                     attach_eks_cni_policy: {
                       role: '${aws_iam_role.eks_node_role.name}',
                       policy_arn: 'arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy',
                     },
                     attach_eks_ec2_container_registry_read_only_policy: {
                       role: '${aws_iam_role.eks_node_role.name}',
                       policy_arn: 'arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly',
                     },
                     // optional
                     attach_eks_ssm_managed_instance_core_policy: {
                       role: '${aws_iam_role.eks_node_role.name}',
                       policy_arn: 'arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore',
                     },
                   }
}