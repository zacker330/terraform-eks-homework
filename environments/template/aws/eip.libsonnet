local tags = import"tags.libsonnet";
{
  newNat(vars,subnets)::{
    [subnet_name + '_nat']: {
      vpc: true,
      tags: tags.common(name=subnet_name + '_nat',env= vars.env, owner=vars.project_name),
    }
    for subnet_name in std.objectFields(subnets)
    if std.startsWith(subnet_name, 'public_')
  }

}