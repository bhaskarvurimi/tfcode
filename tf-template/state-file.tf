terraform {
  backend "s3" {
    encrypt = true
    bucket = "rz-terraform-state"
    region = "ap-south-1"
    key = "sg/sg-test"
  }
}
