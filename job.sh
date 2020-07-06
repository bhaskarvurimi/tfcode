#!/bin/bash

DEPLOYMENT_NAME=$2

################################################################
## HELP: deployment help in details
################################################################
HELP()
{
  echo "Example Usage: ./terraform-sg.sh [OPTIONS] <unique name for deployment>"
  echo "Syntax: ./job.sh [-h|n|u|d] arg2"
  echo "options:"
  echo "-h     Print this Help."
  echo "-n     Create a new security group with ingress and egress rules"
  echo "-u     Update the already created security group or rules"
  echo "-d     Delete the security groups"
  echo
  echo "arguments:"
  echo "arg2  unique name for deployment"
}

################################################################
## SG-MODULE: add a block to define SG module
################################################################
SG-MODULE()
{
  FILE_NAME="main.tf"
  # write a terraform file
  cat <<EOM >$FILE_NAME
provider "aws" {
}

module "${DEPLOYMENT_NAME}" {
  source = "../modules/sg"
  name = "${DEPLOYMENT_NAME}"
  vpc_id = "${VPC_ID}"
  revoke_rules_on_delete = false
  tags = "${TAGS}"
}

EOM
  # writing tf file is done
  # add security group rules
  for count in 1 .. $No_OF_RULES
  do
    FROM_PORT=$(eval echo "\${RULE${count}_FROM_PORT}")
    TO_PORT=$(eval echo "\${RULE${count}_TO_PORT}")
    CIRD_BLOCKS=$(eval echo "\${RULE${count}_CIRD_BLOCKS}")
    EGRESS_FLAG=false
    tee -a $FILE_NAME << EOM
module "rule-${count}" {
  source = "../modules/sg-rules"
  sg_id = module.sg_module.security_group_id
  ingress_from_port = "${FROM_PORT}"
  ingress_to_port = "${TO_PORT}
  ingress_cidr_blocks = ${CIDR_BLOCKS}
  create_egress_rule = ${EGRESS_FLAG}
}

EOM
  done
}

################################################################
## STATE-FILE: create a statefile to maintain state on s3 
################################################################
STATE-FILE()
{
  FILE_NAME="state-file.tf"
  KEY="sg/${DEPLOYMENT_NAME}"
  REGION="${AWS_REGION}"
  BUCKET_NAME="${AWS_BUCKETNAME}"
  # write a state file
  cat <<EOM >$FILE_NAME
terraform {
  backend "s3" {
    encrypt = true
    bucket = "${BUCKET_NAME}"
    region = "${REGION}"
    key = "${KEY}"
  }
}
EOM
  # writting state file is done
}

################################################################
## NEW: deploy security groups and apply ingress, egress rules
################################################################
NEW()
{
  echo "deploying new sg and rules"
  mkdir terraform-scripts
  cd terraform-scripts
  STATE-FILE
  SG-MODULE
  terraform init
  terraform apply -auto-approve
  cd -
}

################################################################
## DELETE: delete the existing security group and rules
################################################################
DELETE()
{
  FILE_NAME="main.tf"
  mkdir terraform-scripts
  cd terraform-scripts
  echo "create empty resource file to perform import"
  cat <<EOM >$FILE_NAME
provider aws {}
EOM
  STATE-FILE
  terraform init
  terraform show -no-color >> $FILE_NAME
  sed -i '/owner_id/d' $FILE_NAME
  sed -i '/arn:aws/d' $FILE_NAME
  set -i "/id\s\+=/d" $FILE_NAME
  terraform destroy -auto-approve
  cd -
  echo "done with destroying the infra for $DEPLOYMENT_NAME"
}

################################################################
## UPDATE: update the security group rules
################################################################
UPDATE()
{
  NEW()
}
################################################################
## Script Options
################################################################
while [ -n "$1" ]; do 
  case $1 in
    -h) # display Help
      HELP
      exit;;
    -n) # new terraform deployment, creates a new path on s3
      NEW
      exit;;
    -u) # updated the existing terraform state
      UPDATE
      exit;;
    -d) # delete the terraform deployments
      DELETE
      exit;;
    *) # incorrect option
      echo "Error: Invalid option"
      exit;;
   esac
done

