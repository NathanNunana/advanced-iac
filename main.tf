# module "vpc" {
#   source = "./modules/network/vpc"
# }

# module "vpc_sg" {
#   source     = "./modules/network/sg"
#   vpc_id     = module.vpc.vpc_id
#   sg_name    = "vpc_sg"
#   sg_ingress = var.vpc_sg_ingress
# }

# module "jenkins_sg" {
#   source     = "./modules/network/sg"
#   vpc_id     = module.vpc.vpc_id
#   sg_name    = "jenkins_sg"
#   sg_ingress = var.jenkins_sg_ingress
# }

# module "jenkins" {
#   source        = "./modules/infra/jenkins"
#   ami           = var.ami
#   instance_type = var.instance_type
#   public_subnet = module.vpc.subnet["public"].id
#   vpc_sg_id     = [module.vpc_sg.sg_id]
#   sg            = [module.jenkins_sg.sg_id]
# }

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"

#   cluster_name    = var.eks_cluster_name
#   cluster_version = "1.31"

#   cluster_endpoint_public_access = true

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = [module.vpc.subnet["private"].id, module.vpc.subnet["public"].id]

#   eks_managed_node_groups = {
#     eks_nodes = {
#       instance_type = "t3.medium"

#       min_size     = 2
#       max_size     = 10
#       desired_size = 2
#     }
#   }
#   enable_cluster_creator_admin_permissions = true

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }


module "icon" {
  source        = "./modules/infra/ec2"
  instance-type = var.proj-subnet
  subnet        = var.proj-subnet
  vpc-sg-id     = var.proj-vpc-sg-id
  tags = {
    Environment = "dev"
    Terraform   = "true"
    Name        = "icon"
  }
}
