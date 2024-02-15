## Pod Disruption Budget
[Pod Disruption Budget in kubernetes](https://www.youtube.com/watch?v=vqDDwPpe2Po)

**Pod Disruption Budget**  ==>> a budget of voluntary disruption
We use it to make sure that the application is not impacted by any Voluntary Disrution.

An Application Owner can create a PodDisruptionBudget object (PDB) for each application. A PDB limits the number pods of a replicated application that are down simultaneously from voluntary disruptions. For example, a quorum-based application would like to ensure that the number of replicas running is never brought below the number needed for a quorum. A web front end might want to ensure that the number of replicas serving load never falls below a certain percentage of the total.

## Pod Disruption Budget Type
### Voluntary Disrution (perform by admin/owner)
- Draining a node (repair/maintennce/upgrade)
- Remove pods from the node to do something
- Delete an object accindentally (pod, deploy, sts, ds)
- Node package upgrade

## Where can we use Pod Disruption Budget in K8S?
- In deployment
- ReplicationController
- Replicaset
- StatefulSet

### Inoluntary Disrution (unavoidable)
- A hadware failure
- Amin deletes VM by mistake
- Cloud provider/hhypervisor failre
- Node beig out of resourced

### minAvailable
2 pods should alow be available
```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 2 
  selector:
    matchLabels:
      run: nginx
```

### minAvailable
- all pods should always be available
- we cannot even upgrade the cluster because eviction pod is not allow
```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 0
  selector:
    matchLabels:
      run: nginx

apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 100%
  selector:
    matchLabels:
      run: nginx
```

### minAvailable
2 pods should alow be always available
```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 2 
  selector:
    matchLabels:
      run: nginx
```

70% of pods should alow be always available
```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 75% 
  selector:
    matchLabels:
      run: nginx
```

### maxUnAvailable
Only 2 pod should alow to be unavailable
```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  maxUnAvailable: 1
  selector:
    matchLabels:
      run: nginx
```

### Drain command with pdb set 
```
kubectl drain [node name] \
    --delete-emptydir-adta \
    --ingnore-daemonsets
```


```yaml
apiVersion: policy/v1beta1
kind: PodDisruptionBudget
metadata:
  name: pdbdemo
spec:
  minAvailable: 2 # 2 pods should alow be available
  selector:
    matchLabels:
      run: nginx
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    run: nginx
  name: nginx-deploy
spec:
  replicas: 4
  selector:
    matchLabels:
      run: nginx
  template:
    metadata:
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        name: nginx

```
## kubectl get all
```
NAME                                READY   STATUS    RESTARTS   AGE
pod/nginx-deploy-598b589c46-4p4gj   1/1     Running   0          5s
pod/nginx-deploy-598b589c46-5jdz9   1/1     Running   0          5s
pod/nginx-deploy-598b589c46-nzbpg   1/1     Running   0          5s
pod/nginx-deploy-598b589c46-x7xmf   1/1     Running   0          5s
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   20d
NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deploy   4/4     4            4           5s
NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deploy-598b589c46   4         4         4       5s
```
## kubectl get pdb
kubectl describe pdb
```
NAME      MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
pdbdemo   2               N/A               2                     13s
```
## kubectl get nodes 
```
NAME          STATUS   ROLES                  AGE   VERSION
kube-master   Ready    control-plane,master   20d   v1.20.1
kube-node-1   Ready    <none>                 20d   v1.20.1
```
## kubectl drain kube-node-1 --ignore-daemonsets
```
node/kube-node-1 cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-flannel-ds-amd64-xqr7d, kube-system/kube-proxy-p9snx
evicting pod default/nginx-deploy-598b589c46-5jdz9
evicting pod default/nginx-deploy-598b589c46-x7xmf
evicting pod default/nginx-deploy-598b589c46-4p4gj
evicting pod default/nginx-deploy-598b589c46-nzbpg
error when evicting pods/"nginx-deploy-598b589c46-x7xmf" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
error when evicting pods/"nginx-deploy-598b589c46-4p4gj" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
evicting pod default/nginx-deploy-598b589c46-x7xmf
error when evicting pods/"nginx-deploy-598b589c46-x7xmf" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
evicting pod default/nginx-deploy-598b589c46-4p4gj
error when evicting pods/"nginx-deploy-598b589c46-4p4gj" -n "default" (will retry after 5s): Cannot evict pod as it would violate the pod's disruption budget.
```
## kubectl get nodes
```
NAME          STATUS                     ROLES                  AGE   VERSION
kube-master   Ready                      control-plane,master   20d   v1.20.1
kube-node-1   Ready,SchedulingDisabled   <none>                 20d   v1.20.1
```
## kubectl get po
```
NAME                                READY   STATUS    RESTARTS   AGE
pod/nginx-deploy-598b589c46-4p4gj   1/1     Running   0          82s
pod/nginx-deploy-598b589c46-84lc6   0/1     Pending   0          24s
pod/nginx-deploy-598b589c46-gw9jm   0/1     Pending   0          24s
pod/nginx-deploy-598b589c46-x7xmf   1/1     Running   0          82s
```
## kubectl uncordon kube-node-1
```
node/kube-node-1 uncordoned
```
## kubectl get nodes
```
NAME          STATUS   ROLES                  AGE   VERSION
kube-master   Ready    control-plane,master   20d   v1.20.1
kube-node-1   Ready    <none>                 20d   v1.20.1
```
## kubectl get pods 
```
NAME                            READY   STATUS    RESTARTS   AGE
nginx-deploy-598b589c46-4p4gj   1/1     Running   0          2m25s
nginx-deploy-598b589c46-84lc6   1/1     Running   0          87s
nginx-deploy-598b589c46-gw9jm   1/1     Running   0          87s
nginx-deploy-598b589c46-x7xmf   1/1     Running   0          2m25s
```
