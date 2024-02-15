
## Allow readonly for some kubernetes resources but not all resources
```sh
resource "kubernetes_cluster_role_v1" "eksreadonly_clusterrole" {
  metadata {
    name = "eksreadonly-clusterrole"
  }
  rule {
    api_groups = [""] # These come under core APIs
    resources = [
      "nodes",
      "namespaces",
      "pods",
      "events",
      "services",
      "configmaps",
      "serviceaccounts",
      "persistentvolumeclaim",
      "persistentvolumes",
      "secrets"
    ]
    verbs = ["get", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources = [
      "deployments",
      "daemonsets",
      "statefulsets",
      "replicasets"
    ]
    verbs = ["get", "list"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }
}
```

```yaml

## kubectl get ClusterRole eksreadonly-clusterrole -oyaml
```yaml
kind: ClusterRole
metadata:
  creationTimestamp: 2022-09-08T01:19:49Z
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:rules: {}
    manager: HashiCorp
    operation: Update
    time: 2022-09-08T01:19:49Z
  name: eksreadonly-clusterrole
  resourceVersion: "7747"
  uid: 62212dbe-e147-479c-88df-2d42eb22d526
rules:
- apiGroups:
  - ""
  resources:
  - nodes
  - namespaces
  - pods
  - events
  - services
  - configmaps
  - serviceaccounts
  - persistentvolumeclaim
  - persistentvolumes
  - secrets
  verbs:
  - get
  - list
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
- apiGroups:
  - batch
  resources:
  - jobs
  verbs:
  - get
  - list
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
- apiGroups:
  - ""
  resources:
  - nodes
  - namespaces
  - pods
  - events
  - services
  - configmaps
  - serviceaccounts
  - persistentvolumeclaim
  - persistentvolumes
  - secrets
  verbs:
  - get
  - list
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
- apiGroups:
  - batch
  resources:
  - jobs
  verbs:
  - get
  - list
```
OR

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
  - apiGroups: [""]
    resources: ["nodes", "namespaces", "pods", "events", "services", "configmaps", "serviceaccounts", "persistentvolumeclaim", "persistentvolumes", "secrets"]
    verbs: ["get", "list"]
  - apiGroups: ["apps"]
    resources: ["deployments" ,"daemonsets" ,"statefulsets" ,"replicasets"]
    verbs: ["get", "list"]
  - apiGroups: ["batch"]
    resources: ["jobs"]
    verbs: ["get", "list"]
```


## Allow readonly for all kubernetes resources
```yaml
resource "kubernetes_cluster_role_v1" "eksreadonly_clusterrole" {
  metadata {
    name = "eksreadonly-clusterrole"
  }
  rule {
    api_groups = [""] # These come under core APIs
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
}
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
  - apiGroups: [""]
    resources: ["*"]
    verbs: ["get", "list"]
  - apiGroups: ["apps"]
    resources: ["*"]
    verbs: ["get", "list"]
  - apiGroups: ["batch"]
    resources: ["*"]
    verbs: ["get", "list"]
```
 

