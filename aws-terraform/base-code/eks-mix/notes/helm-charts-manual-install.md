## Install Metrics Server
- https://github.com/kubernetes-sigs/metrics-server/releases/tag/metrics-server-helm-chart-3.8.3
```s
# Verify if Metrics Server already Installed
kubectl -n kube-system get deployment/metrics-server

# Install Metrics Server
kubectl create ns metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/metrics-server-helm-chart-3.8.3/components.yaml 

kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/download/metrics-server-helm-chart-3.8.3/components.yaml 
```

## Vertical Pod Autoscaler (VPA)
```sh
# Clone Repo
git clone https://github.com/kubernetes/autoscaler.git

# Navigate to VPA
cd autoscaler/vertical-pod-autoscaler/

# https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler/hack
# Install new version of VPA
./hack/vpa-up.sh

# https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler/hack
# Uninstall VPA (if we are using old one)
./hack/vpa-down.sh

# Verify VPA Pods
kubectl get pods -n kube-system

#OR
https://github.com/cowboysysop/charts/tree/master/charts/vertical-pod-autoscaler

$ helm repo add cowboysysop https://cowboysysop.github.io/charts/
$ helm install my-release cowboysysop/vertical-pod-autoscaler
```

