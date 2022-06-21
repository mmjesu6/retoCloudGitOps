// this file is always included in terraform runs
// you can also use include .tfvars in commandline, export TF_VAR_image_id=ami-abc123 etc
// -var-file="testing.tfvars"


image_id ="ami-0063343029bd9616b"
vpc_id = "vpc-01f8e0ace904bdd9e"
security_group_id= "sg-0916b96e36c8b90a4"
tag_user= "mmjesu6@mapfre.com"
availability_zone_names = [
  "us-east-1a",
  "us-west-1c",
]