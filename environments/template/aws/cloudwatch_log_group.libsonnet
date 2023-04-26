local tags = import"tags.libsonnet";
local group_name(eks_name) = "/aws/eks/" + eks_name + "/cluster";
{
  newEksLog(vars,retention_in_days = 1)::{
    [vars.aws.eks.name]: {
      name: group_name(vars.aws.eks.name),
      retention_in_days: retention_in_days,
      tags: tags.common(name=group_name(vars.aws.eks.name),env= vars.env, owner=vars.project_name),
    }
  }
}