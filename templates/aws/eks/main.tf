module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.30.1"

  cluster_name    = var.cluster_name
  cluster_version = var.kube_version

  cluster_endpoint_public_access        = true
  enable_cluster_creator_admin_permissions = false

  cluster_addons = {
    coredns = {
      configuration_values = jsonencode({
        computeType = "Fargate"
        # Ensure that we fully utilize the minimum amount of resources that are supplied by
        # Fargate https://docs.aws.amazon.com/eks/latest/userguide/fargate-pod-configuration.html
        # Fargate adds 256 MB to each pod's memory reservation for the required Kubernetes
        # components (kubelet, kube-proxy, and containerd). Fargate rounds up to the following
        # compute configuration that most closely matches the sum of vCPU and memory requests in
        # order to ensure pods always have the resources that they need to run.
        resources = {
          limits = {
            cpu = "0.25"
            # We are targeting the smallest Task size of 512Mb, so we subtract 256Mb from the
            # request/limit to ensure we can fit within that task
            memory = "256M"
          }
          requests = {
            cpu = "0.25"
            # We are targeting the smallest Task size of 512Mb, so we subtract 256Mb from the
            # request/limit to ensure we can fit within that task
            memory = "256M"
          }
        }
        tolerations = [
          {
            key      = "eks.amazonaws.com/compute-type"
            operator = "Equal"
            value    = "fargate"
            effect   = "NoSchedule"
          }
        ]
      })
    }
    kube-proxy = {}
    vpc-cni    = {}
  }

  access_entries = {
    sso_admin = {
      kubernetes_groups = []
      principal_arn     = var.sso_admin_role_arn

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.environment
  })

  vpc_id     = var.vpc
  subnet_ids = var.subnets

  create_cluster_security_group = false
  create_node_security_group    = false


  fargate_profiles = {
    karpenter = {
      selectors = [
        { namespace = "karpenter" }
      ]
    }
    kube-system = {
      selectors = [
        { namespace = "kube-system", labels = { "eks.amazonaws.com/component" = "coredns" } }
      ]
    }
  }

}

