local tags = import 'tags.libsonnet';
{
  new(vars, subnet_name_list, nat_gateway_name_list)::
    {
      ['nat_' + subnet_name_list[subnet_index] + '_' + subnet_index]: {
        subnet_id: '${aws_subnet.' + subnet_name_list[subnet_index] + '.id}',
        route_table_id: '${aws_route_table.' + nat_gateway_name_list[subnet_index % std.length(nat_gateway_name_list)] + '.id}',
      }
      for subnet_index in std.range(0, std.length(subnet_name_list) - 1)
      if std.startsWith(subnet_name_list[subnet_index], 'private_')
    } +
    {
      ['igw_' + subnet_name]: {
        subnet_id: '${aws_subnet.' + subnet_name + '.id}',
        route_table_id: '${aws_route_table.' + vars.aws.eks.internet_gateway_name + '_igw_route_table' + '.id}',
      }
      for subnet_name in subnet_name_list
      if std.startsWith(subnet_name, 'public_')
    },
}
