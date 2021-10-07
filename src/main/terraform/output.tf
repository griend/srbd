output "kubeconfig" {
  value = linode_lke_cluster.griend-cluster.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.griend-cluster.api_endpoints
}

output "status" {
  value = linode_lke_cluster.griend-cluster.status
}

output "id" {
  value = linode_lke_cluster.griend-cluster.id
}

output "pool" {
  value = linode_lke_cluster.griend-cluster.pool
}

resource "local_file" "kubeconfig" {
  depends_on   = [linode_lke_cluster.griend-cluster]
  filename     = "kube-config"
  content      = base64decode(linode_lke_cluster.griend-cluster.kubeconfig)
}
