### How to export the cluster .kube/config file?

1- Login in AWS using the CLI first with your secret and access key

2- Run the below command to export the .kube/config file in your home directory

aws eks update-kubeconfig --name [cluster_name] --region [region]

Example: aws eks update-kubeconfig --name my-eks-cluster --region us-east-1