resource "linode_lke_cluster" "lke_cluster" {
    label       = "learnk8s"
    k8s_version = "1.21"
    region      = "eu-central"

    pool {
        type  = "g6-standard-1"
        count = 2
    }
}
