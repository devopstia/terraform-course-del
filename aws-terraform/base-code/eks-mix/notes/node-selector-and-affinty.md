
# Taint, toleration, node selector and node affinity

**Terraform block in the node group**
```t
  labels = {
    deployment_nodegroup = "special"
  }

   labels = {
    nodegroup = "blue_green"
  }

kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label nodes node-1 deployment_nodegroup=special
kubectl label nodes node-1 nodegroup=blue_green
```


```t
  # Only pod that can tolerate the taint will be deploy on this nodes or node group
  taint {
    key    = "team"
    value  = "devops"
    effect = "NO_SCHEDULE"
  }

   taint {
    key    = "team"
    value  = "devops"
    effect = "NO_EXECUTE"
  }

kubectl taint nodes <node name> key=value1:NoSchedule
kubectl taint nodes node01 team=devops:NoSchedule
kubectl taint nodes node01 team=devops:NoExecute
```

```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: myapp-pod 
  labels: 
    app: myapp   
    tier: front-end     
spec:
  containers: 
    - name: myapp 
      image: httpd
      ports:
        - containerPort: 80 
  tolerations:
   - key: "team"
     operator: "Equal"
     value: "devops"
     effect: NoSchedule 
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      # this is for a node that is label special
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: deployment_nodegroup
                  operator: In
                  values: 
                  - special
      # this is for a node that is label special or blue_green       
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: deployment_nodegroup
                  operator: In
                  values: 
                  - special
                  - blue_green
      # this will match a node with the label not set to special or blue_green        
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution: 
            nodeSelectorTerms:
              - matchExpressions:
                - key: deployment_nodegroup
                  operator: NotIn
                  values: 
                  - special
                  - blue_green
      # this will match a node with the label not set to special       
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution: 
            nodeSelectorTerms:
              - matchExpressions:
                - key: deployment_nodegroup
                  operator: NotIn
                  values: 
                  - special
      # The pod will be placed on the node if the label deployment_nodegroup exist. We do no care about the value here 
      # this do not compare the value      
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: deployment_nodegroup
                  operator: Exists
                  
      containers:
      - name: nginx-server
        image: nginx
      # This will place a pod on the node label special
      nodeSelector:
        deployment_nodegroup: special
      # This will place a pod on the node with toleration NoSchedule
      tolerations:
      - key: "team"
        operator: "Equal"
        value: "devops"
        effect: NoSchedule
```

NB: 
- Taint and tolerance do not tell the pod to be placed on the particular node or tell the scheduler to schedule the pod on the particular node. It only tells the node to accept pods with tolerance.
- If your requirement is to restrict a pod to certain nodes, this will be achieved through node affinity.
- Taints and tolerations, node affinity and pod affinity, anti-affinity are use to instruct the Kubernetes scheduler to place pods on nodes that fulfill their special needs.


## We have 3 types of toleration effect:
- **NoSchedule:** this means that no pod will be able to schedule on node1 unless it has a matching toleration or instructs Kubernetes scheduler not to schedule any new pods to the node unless the pod tolerates the taint.
- **NoExecute:** the pod will be evicted or removed or killed from the node (if it is already running on the node), and will not be scheduled onto the node (if it is not yet running on the node). Or instructs Kubernetes scheduler to evict pods already running on the node that don’t tolerate the taint.
- **PreferNoSchedule:**  Kubernetes will try to not schedule the pod onto the node; however, there is no guarantee

## 1- Taint
### Taint a node
```
kubectl taint nodes <node name> key=value:taint-effect
kubectl taint nodes node01 key=blue:NoSchedule
```

### To remove the taint on the node
```
kubectl taint nodes <node name> key:effect-
kubectl taint nodes node01 key:NoSchedule-
```

### Command to check the taint on kubernetes master
- A taint is set by default on kubernetes master so that the scheduler can not schedule pod on the master node
```
kubectl describe node <master node name> | grep -i taint
kubectl describe node controlplane | grep -i taint
Or
kubectl describe node $(hostname) | grep -i taint
```

### Removed taint on kubernetes master node
```
kubectl taint nodes <master note name> key=value:effect-
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule-
OR
kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule-

# Add it back as it was. We do not have a key here
kubectl taint nodes $(hostname) node-role.kubernetes.io/master:NoSchedule
kubectl taint nodes controlplane node-role.kubernetes.io/master:NoSchedule
```

### Add taint on kubernetes master node if it was removed
```
kubectl taint nodes <master note name> key=blue:NoSchedule
kubectl taint nodes controlplane key=blue:NoSchedule
OR
kubectl taint nodes $(hostname) key=blue:NoSchedule

# To remove the taint
kubectl taint nodes $(hostname) key=blue:NoSchedule-
```

### To do a pause, you need to put a taint on the node.
```
kubectl taint nodes <node name> key=value1:NoSchedule
```

### To unpause the node in question, you need to remove the taint previously set.
```
kubectl taint nodes <node name> key:NoSchedule-
```
### Drain a node. If you don't want to touch daemonsets you will need this option --ignore-daemonsets.
- **Note:** This will migrate all kubernetes workload from the node. The pods present on the node will be rescheduled to other worker nodes.
```
kubectl drain <node name> --ignore-daemonsets
kubectl drain node01 --ignore-daemonsets
```

### To undo the kubectl drain, you'll need to use the command kubectl uncordon.
```
kubectl uncordon <node name>
kubectl uncordon node01
```

## 2- Toleration
### To add a toleration to a pod, use the same value that you use to create a taint on the node. Those values must be in double quotes.
```
kubectl taint nodes node1 app=blue:NoSchedule
```

```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: myapp-pod 
  labels: 
    app: myapp   
    tier: front-end     
spec:
  containers: 
    - name: myapp 
      image: httpd
      ports:
        - containerPort: 80 
  tolerations:
   - key: "app"
     operator: "Equal"
     value: "blue"
     effect: NoSchedule 
```

### Ceate a deployment with toleration
```
kubectl taint nodes node01 color=blue:NoSchedule
```
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      containers:
      - name: web-app
        image: nginx
      tolerations:
      - key: "color"
        operator: "Equal"
        value: "blue"
        effect: NoSchedule 
```
## 3- Node selector
This is used to set a pod so that it can only run on a particular node in the cluster. Or the node that has a lot of resources maybe and cannot run out of memory in the cluster.

### Create a pods only on node01 using the deployment definition file (we will use node name here)
- This will create the pods only on node01
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      containers:
      - name: web-app
        image: nginx
      nodeName: node01   
```
### Create a pods only on Large node using the deployment definition file (we will use node selector)
We will first label the Node and use node selector to place the pod on the right node because by default any pod can end up on any node.

### Label the node first
```
kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label nodes node-1 size=Large
```

### Create a node definition file with the label
```yaml
# Deployment manifest
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deploy
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      containers:
      - name: web-app
        image: nginx
      nodeSelector:
        size: Large

# pod manifest
apiVersion: v1
kind: Pod 
metadata:
  name: myapp-pod 
  labels: 
    app: myapp   
    tier: front-end     
spec:
  containers: 
    - name: myapp 
      image: httpd
      ports:
        - containerPort: 80 
  nodeSelector:
    size: Large
          
```
### Create a deployment on any available node that do not have a taint set up
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      containers:
      - name: web-app
        image: nginx   
```

## 4- Node affinity
Node selector is limited when we want to place a pod on the node base on condition. For instance, if we want to place a pod on a large or medium node, or on a node that is not small, we must use node `Affinity or AntiAffinity` to achieve this because we can have condition with node selector.

### Node affinity operators:
kubernetes has a lot of node affinity operators
- In 
- NotIn
- Exists
- DoesNotExist
- Gt
- Lt 

### Node affinity types:
- **Available:**
  - `requiredDuringSchedulingIgnoredDuringExecution`: `requiredDuringScheduling` the pod must be label before the scheduler can place the pod on the node. If the node is not label, the pod will not be scheduled. `IgnoredDuringExecution`: if someone remove the label when the pod was already scheduled on the node, changes will be ignored and the pod will continued to run on the node
  - `preferredDuringSchedulingIgnoredDuringExecution` : `preferredDuringScheduling` if the node is node label here, the scheduler will ignore the pod affinity rule and place the pod on another node. `IgnoredDuringExecution`: if someone remove the label when the pod was already scheduled on the node, changes will be ignored and the pod will continued to run on the node
- **Planed:** This is for future use.
  - `requiredDuringSchedulingRequiredDuringExecution`: `requiredDuringScheduling` and `RequiredDuringExecution`: this will just evict pod that do not meet any affinity rule. If the label is removed from the node, the pod will be terminated and remove from the node

### Examples of Node affinity
- Label the node first.
- This will place the pod `In` the Large node.
- This will place the pod `In` the Large node `OR` Medium node. The `In` operator makes sure that the pod will be placed in the list specified below `value`. In this case, we have 1 value
```
kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label nodes node-1 size=Large
```
```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - Large      
```

- Label the node first.
- This will place the pod `In` the Large node `OR` Medium node. The `In` operator makes sure that the pod will be placed in the list specified below `value`. In this case, we have 2 values.
```
kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label nodes node-1 size=Medium
```
```yaml
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - Large
            - Medium      
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: size
                  operator: In
                  values:
                  - Large
                  - Medium 
```

## Example:
- Apply a label color=blue to node node01
- Create a new deployment named `blue` with the nginx image and 6 replicas and set the node affinity to the deployment to set the pods on node01 only using the label set on the node.
NB: other pod in the cluster can still be schedule on node01 (no taint and toleration)

### 1- Set label on node01
```
kubectl label nodes node01 color=blue
# To check
kubectl get node node01 --show-labels
```

### 2- Create a deployment definition file

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color
                  operator: In
                  values:
                  - blue
      containers:
      - name: nginx-server
        image: nginx
```

## Scenario using taint, toleration and node affinity
**Scenario 1:**
We have a dev node in the cluster and developers want to create their pods only the dev node; however, developers do not want any other pod to be placed on the dev node. How can you achieve that in Kubernetes?

**Solution:**
- **Use taint and toleration:** if we taint the dev node and add the toleration on the developers pods tolerate the dev node, other pods in the cluster will node be place on dev node; however, there is no guarantee that the scheduler will not schedule those pods in other nodes in the cluster `(this is not what we desired)`.
- **Use node affinity:** we will first label the node and use node selector to place the pod on the right node (dev) base on the node label; however, there is no guarantee the scheduler will not scheduler other pod in the cluster on the dev node because the node is not tainted  `(this is not what we desired)`.
- **Use taint, toleration and node affinity:** we taint the dev pod first  so that other pods in the cluster will node tolerate it then will add a toleration in the developers deployment manifest to to tolerate the dev node and use pod affinity to place the pods on the dev node. `(this is not what we desired)`.

### 1- Label the node
```
kubectl label nodes node01 color=blue
# To check
kubectl get node node01 --show-labels
```

### 2- Taint the node
```
kubectl taint nodes <node name> key=value:taint-effect
kubectl taint nodes node01 env=test:NoSchedule
```
### 3- Create a deployment with node Affinity
```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: blue
  replicas: 6
  template:
    metadata:
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color
                  operator: In
                  values:
                  - blue
      containers:
      - name: nginx-server
        image: nginx
      tolerations:
      - key: "env"
        operator: "Equal"
        value: "test"
        effect: NoSchedule
```

### Check the deployment
```
kubectl get po -o wide |grep my-deployment
```

### 4- Create the Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-nginxapp-nodeport-service
  labels: 
    app: frontend-nginxapp
    tier: frontend     
spec:
  type: NodePort 
  selector:
    app: blue
  ports: 
    - name: nginx
      port: 80
      targetPort: 80
      nodePort: 31234
```

## Scenario using taint, toleration and node affinity
**Scenario 2:**
Let's say we have 2 nodes in the cluster for testing env. One is large and another one is medium. As developers we want to place our pod only on those 2 nodes `(large or medium)` and we do not want any other pods to be placed on dev nodes and we do not also want our pod to be placed on other nodes in the cluster. How can you achieve this?

### 1- Label the nodes
```
kubectl label nodes <node-name> <label-key>=<label-value>
kubectl label nodes node01 size=Large
kubectl label nodes node02 size=Medium
```
### 2- Taint the nodes
```
kubectl taint nodes <node name> key=value:taint-effect
kubectl taint nodes node01 env=dev1:NoSchedule
kubectl taint nodes node02 env=dev2:NoSchedule
OR 
kubectl taint nodes node01 env=prod1:NoSchedule
kubectl taint nodes node02 env=prod1:NoSchedule
```

### 3- Taint the Create a deployment with node Affinity and add toleration to pods to tolerate the nodes01 and node02
```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  selector:
    matchLabels:
      app: development-env
  replicas: 6
  template:
    metadata:
      labels:
        app: development-env # Allow the deployment to discover pods
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - size: size
                  operator: In
                  values:
                  - Large
                  - Medium
      containers:
      - name: nginx-server
        image: nginx
      tolerations:
      - key: "env"
        operator: "Equal"
        value: "dev1"
        effect: NoSchedule
      - key: "env"
        operator: "Equal"
        value: "dev2"
        effect: NoSchedule
```

### 4- Create the Service
```yaml
apiVersion: v1
kind: Dev-service
metadata:
  name: frontend-nginxapp-nodeport-service
  labels: 
    app: frontend-nginxapp
    tier: frontend     
spec:
  type: NodePort 
  selector:
    app: development-env # allow the service to discover the deployment
  ports: 
    - name: nginx
      port: 80
      targetPort: 80
      nodePort: 31234
```

### References of Node affinity
- **Node-affinity:** https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
- **Assigning Pods to Nodes:** https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
- **Advanced Scheduling and Node Affinity:** https://docs.openshift.com/container-platform/3.6/admin_guide/scheduling/node_affinity.html
- **Implement Node and Pod Affinity/Anti-Affinity in Kubernetes: A Practical Example:** https://thenewstack.io/implement-node-and-pod-affinity-anti-affinity-in-kubernetes-a-practical-example/
- **Assigning Pods to Nodes Github:** http://pwittrock.github.io/docs/concepts/configuration/assign-pod-node/