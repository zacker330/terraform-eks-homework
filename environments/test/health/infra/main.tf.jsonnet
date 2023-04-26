local secrets = import '../secrets.libsonnet';
local vars = import '../vars.libsonnet';
local main_template = import "../../../template/aws/main.libsonnet";
main_template.new(vars,secrets)
