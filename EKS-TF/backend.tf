terraform {
  backend "s3" {
    bucket = "super-mario-eks-terraform" 
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
