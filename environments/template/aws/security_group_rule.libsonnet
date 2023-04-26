{
  newEksClusterSg(vars):: {
    aws_security_group: {
      [vars.aws.eks.eks_security_group_name]: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        description: 'Cluster communication with worker nodes',
      },
      [vars.aws.eks.node_security_group_name]: {
        vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
        description: 'Security group for all nodes in the cluster',
        egress: [
          {
            description: '',
            ipv6_cidr_blocks: [],
            prefix_list_ids: [],
            'self': null,
            security_groups: [],
            from_port: 0,
            to_port: 0,
            protocol: '-1',
            cidr_blocks: ['0.0.0.0/0'],
          },
        ],
      },
    },
    aws_security_group_rule: {
      [vars.aws.eks.eks_security_group_name + '_inbound']: {
        description: 'Allow worker nodes to communicate with the cluster API Server',
        from_port: 443,
        protocol: 'tcp',
        security_group_id: '${aws_security_group.' + vars.aws.eks.eks_security_group_name + '.id}',
        source_security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        to_port: 443,
        type: 'ingress',
      },
      [vars.aws.eks.eks_security_group_name + '_outbound']: {
        description: 'Allow cluster API Server to communicate with the worker nodes',
        from_port: 1024,
        protocol: 'tcp',
        security_group_id: '${aws_security_group.' + vars.aws.eks.eks_security_group_name + '.id}',
        source_security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        to_port: 65535,
        type: 'egress',
      },
      [vars.aws.eks.node_security_group_name + '_nodes_internal']: {
        description: 'Allow nodes to communicate with each other',
        from_port: 0,
        protocol: '-1',
        security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        source_security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        to_port: 65535,
        type: 'ingress',
      },
      [vars.aws.eks.node_security_group_name + '_nodes_cluster_inbound']: {
        description: 'Allow worker Kubelets and pods to receive communication from the cluster control plane',
        from_port: 1025,
        protocol: 'tcp',
        security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        source_security_group_id: '${aws_security_group.' + vars.aws.eks.eks_security_group_name + '.id}',
        to_port: 65535,
        type: 'ingress',
      },
      [vars.aws.eks.node_security_group_name + '_nodes_cluster_outbound']: {
        description: 'Allow worker Kubelets and pods to receive communication from the cluster control plane',
        from_port: 1025,
        protocol: 'tcp',
        security_group_id: '${aws_security_group.' + vars.aws.eks.node_security_group_name + '.id}',
        source_security_group_id: '${aws_security_group.' + vars.aws.eks.eks_security_group_name + '.id}',
        to_port: 65535,
        type: 'egress',
      },

    },

  },
}
