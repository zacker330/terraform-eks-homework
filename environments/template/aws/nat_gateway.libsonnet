local tags = import"tags.libsonnet";
{
  new(vars, subnets)::{
   [subnet_name]: {
     allocation_id: '${aws_eip.' + subnet_name + '_nat' + '.id}',
     subnet_id: '${aws_subnet.' + subnet_name + '.id}',
     tags: tags.common(name=vars.project_name + '_nat_gateway', env=vars.env, owner=vars.project_name),
     depends_on: ['aws_internet_gateway.' + vars.aws.eks.internet_gateway_name],
   }
   for subnet_name in std.objectFields(subnets)
   if std.startsWith(subnet_name, 'public_')
 }
}