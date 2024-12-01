module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "v20.9.0"

  cluster_name = var.cluster_name

  create_iam_role = true

  enable_irsa                     = true
  irsa_oidc_provider_arn          = var.oidc_provider_arn
  irsa_namespace_service_accounts = ["karpenter:karpenter"]

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart      = "karpenter"
  version    = "0.35.1"
  wait       = false

  values = [
    <<-EOT
    settings:
      clusterName: ${var.cluster_name}
      clusterEndpoint: ${data.aws_eks_cluster.default.endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
    serviceAccount:
      annotations:
        eks.amazonaws.com/role-arn: ${module.karpenter.iam_role_arn}
    tolerations:
      - key: 'eks.amazonaws.com/compute-type'
        operator: Equal
        value: fargate
        effect: "NoSchedule"
    EOT
  ]
}

# Data NodePool
resource "kubectl_manifest" "karpenter_node_pool_data" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: data
    spec:
      template:
        spec:
          nodeClassRef:
            name: data
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["c", "m", "r", "t"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["4", "8", "16", "32"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["spot"]
            - key: "topology.kubernetes.io/zone"
              operator: In
              values: ["us-east-1a"] # Restrict to Availability Zone 1
          taints:
            - key: "workload-type"
              value: "data"
              effect: "NoSchedule"
      limits:
        cpu: 1000
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class_data
  ]
}

# Infra NodePool
resource "kubectl_manifest" "karpenter_node_pool_infra" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: infra
    spec:
      template:
        spec:
          nodeClassRef:
            name: infra
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["c", "m", "r", "t"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["4", "8", "16", "32"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["spot"]
          taints:
            - key: "workload-type"
              value: "infra"
              effect: "NoSchedule"
      limits:
        cpu: 1000
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class_infra
  ]
}

# App NodePool
resource "kubectl_manifest" "karpenter_node_pool_apps" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: apps
    spec:
      template:
        spec:
          nodeClassRef:
            name: apps
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["c", "m", "r", "t"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["4", "8", "16", "32"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["spot"]
          taints:
            - key: "workload-type"
              value: "app"
              effect: "NoSchedule"
      limits:
        cpu: 1000
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class_apps
  ]
}

# Data NodeClass
resource "kubectl_manifest" "karpenter_node_class_data" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: data
    spec:
      amiFamily: AL2
      role: ${module.karpenter.node_iam_role_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      tags:
        karpenter.sh/discovery: ${var.environment}
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

# Infra NodeClass
resource "kubectl_manifest" "karpenter_node_class_infra" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: infra
    spec:
      amiFamily: AL2
      role: ${module.karpenter.node_iam_role_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      tags:
        karpenter.sh/discovery: ${var.environment}
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

# App NodeClass
resource "kubectl_manifest" "karpenter_node_class_apps" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: apps
    spec:
      amiFamily: AL2
      role: ${module.karpenter.node_iam_role_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.environment}
      tags:
        karpenter.sh/discovery: ${var.environment}
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}
