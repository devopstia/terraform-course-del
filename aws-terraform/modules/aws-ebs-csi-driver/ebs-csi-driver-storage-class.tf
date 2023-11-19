resource "kubernetes_storage_class" "aws-gp2-storage-class" {
  metadata {
    name = "ebs-gp3-storage-class-create-by-terraform"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "false"
    }
  }
  allow_volume_expansion = "true"
  volume_binding_mode    = "WaitForFirstConsumer"
  reclaim_policy         = "Delete"
  storage_provisioner    = "ebs.csi.aws.com"
  parameters = {
    type      = "gp3"
    fsType    = "ext4"
    encrypted = "true"
  }
}
