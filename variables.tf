# Define AWS as our provider
provider "aws" {
  region = "ap-south-1"
}


resource "aws_key_pair" "deployer" {
  key_name   = "citymall"
  public_key = "KEEP YOUR PUBLIC KEY HERE!"
}

variable "ami" {
 description = "AMI for application servers"
 default = "ami-0d758c1134823146a"
}
