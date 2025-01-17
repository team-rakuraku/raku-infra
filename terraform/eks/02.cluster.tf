
resource "aws_eks_cluster" "raku_cluster" {
  name     = "raku-cluster"
  role_arn =  aws_iam_role.raku_cluster_iam_role.arn 
  version = "1.31"
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  vpc_config {
    security_group_ids = [data.aws_security_group.cluster_sg.id]         
    subnet_ids         = [data.aws_subnet.raku_pvt01_2c.id, data.aws_subnet.raku_pvt02_2a.id]
    endpoint_private_access = true # 동일 vpc 내 private ip간 통신허용
    endpoint_public_access = true #  원래는 외부 접근 차단해야하는데 일단 허용 해놓음 -> 나중에 특정 IP대역만 허용하기 
   }
  }


  # EKS Node Group (일단 1개로 진행후 나중에 확장)

resource "aws_eks_node_group" "raku_node_group" {
  cluster_name    = aws_eks_cluster.raku_cluster.name
  node_group_name = "raku-node-group"
  node_role_arn   = aws_iam_role.raku_node_iam_role.arn
  subnet_ids      = [data.aws_subnet.raku_pvt01_2c.id, data.aws_subnet.raku_pvt02_2a.id]
  instance_types = ["t3.small"] 
  capacity_type  = "ON_DEMAND"
  remote_access {
#    source_security_group_ids = [data.aws_security_group.my_sg_web.id]
    ec2_ssh_key               = "raku-key"
  }
  labels = {
    "role" = "raku_node_iam_role"
  }
  scaling_config {
    desired_size = 10
    min_size     = 10
    max_size     = 20
    }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
