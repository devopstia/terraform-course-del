
# https://docs.aws.amazon.com/eks/latest/userguide/pod-security-policy.html

# Get your account number
data "aws_caller_identity" "current" {
}

locals {
  default_psp = <<PSP
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: eks.privileged
  annotations:
    kubernetes.io/description: 'privileged allows full unrestricted access to pod features, as if the PodSecurityPolicy controller was not enabled.'
    seccomp.security.alpha.kubernetes.io/allowedProfileNames:  docker/default
    seccomp.security.alpha.kubernetes.io/defaultProfileName: docker/default
  labels:
    kubernetes.io/cluster-service: "true"
    eks.amazonaws.com/component: pod-security-policy
spec:
  privileged: true
  allowPrivilegeEscalation: true
  allowedCapabilities:
  - '*'
  volumes:
  - '*'
  hostNetwork: true
  hostPorts:
  - min: 0
    max: 65535
  hostIPC: true
  hostPID: true
  runAsUser:
    rule: 'RunAsAny'
  seLinux:
    rule: 'RunAsAny'
  supplementalGroups:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'RunAsAny'
  readOnlyRootFilesystem: false
PSP
}

# Generate Node Auth File
resource "local_file" "default-psp" {
  content  = local.default_psp
  filename = "default-psp.yaml"
}

resource "null_resource" "default-psp-apply-apply" {
  depends_on = [local_file.default-psp]
  provisioner "local-exec" {
    command = "kubectl apply -f default-psp.yaml"
  }
}

