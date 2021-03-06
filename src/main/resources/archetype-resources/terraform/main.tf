#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
module "security" {
  source = "./modules/global/security"
}

module "ami" {
  source = "./modules/global/ami"
}

module "iam" {
  source = "./modules/global/iam"
}

module "user_data" {
  source = "./modules/global/user_data"
}

module "key_pair" {
  source = "./modules/global/key_pair"
}

module "dev" {
  source = "./environments/dev"
  centos7_ami_id = "${symbol_dollar}{module.ami.centos7_ami_id}"
  vpc_security_group_ids = ["${symbol_dollar}{module.security.security_group_${configurationManagementName}_id}"]
  instance_profile_name = "${symbol_dollar}{module.iam.instance_profile_name}"
  user_data = "${symbol_dollar}{module.user_data.user_data}"
}

module "prod" {
  source = "./environments/prod"
  centos7_ami_id = "${symbol_dollar}{module.ami.centos7_ami_id}"
  vpc_security_group_ids = ["${symbol_dollar}{module.security.security_group_${configurationManagementName}_id}"]
  instance_profile_name = "${symbol_dollar}{module.iam.instance_profile_name}"
  user_data = "${symbol_dollar}{module.user_data.user_data}"
}
