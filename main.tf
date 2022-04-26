module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.2"

  # EKS CLUSTER
  cluster_version           = "1.21"
  vpc_id                    = "vpc-0ccfd4c43b995bcad"                                      # Enter VPC ID
  private_subnet_ids        = ["subnet-00d406ec7c35b55f7", "subnet-0730694ec26fbb28e", "subnet-0cbaefef60a89f6c5"]     # Enter Private Subnet IDs

  # EKS MANAGED NODE GROUPS
  managed_node_groups = {
    mg_m5 = {
      node_group_name = "managed-ondemand"
      instance_types  = ["m5.large"]
      subnet_ids      = ["subnet-00d406ec7c35b55f7", "subnet-0730694ec26fbb28e", "subnet-0cbaefef60a89f6c5"]
    }
  }
}

module "eks_blueprints_kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.0.2"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  # EKS Addons
  enable_amazon_eks_vpc_cni            = true
  enable_amazon_eks_coredns            = true
  enable_amazon_eks_kube_proxy         = true
  enable_amazon_eks_aws_ebs_csi_driver = true

  #K8s Add-ons
  enable_argocd                       = true
  enable_aws_for_fluentbit            = true
  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_metrics_server               = false
  enable_prometheus                   = false
  enable_karpenter                    = true
}
