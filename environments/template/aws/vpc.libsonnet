local tags = import "tags.libsonnet";
{
  new(vars)::{
      [vars.aws.vpc.name]: {
          cidr_block: vars.aws.vpc.cidr,
          tags: tags.common(name=vars.aws.vpc.name, env=vars.env, owner=vars.project_name),
      },
  }
}