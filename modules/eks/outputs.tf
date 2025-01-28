output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "node_group_name" {
  value = aws_eks_node_group.nodes.node_group_name
}

output "node_group_arn" {
  value = aws_eks_node_group.nodes.arn
}