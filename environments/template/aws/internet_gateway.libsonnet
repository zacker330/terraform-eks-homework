local tags = import"tags.libsonnet";
{
  new(vars)::{
       [vars.aws.eks.internet_gateway_name]: {
         vpc_id: '${aws_vpc.' + vars.aws.vpc.name + '.id}',
          tags: tags.common(name=vars.aws.vpc.name, env=vars.env, owner=vars.project_name),
       },
     }
}