Please update 
tf-template/state-file.tf file to your specific bucket names.

To execute you need to set following env variables:
export AWS_DEFAULT_REGION="us-east-2"
export AWS_SECRET_ACCESS_KEY="xxxx"
export AWS_ACCESS_KEY_ID="xxx"

then go to tf-template and run 
terraform init
terraform plan
terraform apply

you can create as many as security group and rules using different tf-template/main.tf 

I have also attached a shell script that run the entire flow.