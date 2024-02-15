## EKS Storage -  Storage Classes, Persistent Volume Claims
- https://kubernetes.io/docs/concepts/storage/storage-classes/#mount-options

Each StorageClass contains the fields `provisioner`, `parameters`, and `reclaimPolicy`, which are used when a PersistentVolume belonging to the class needs to be dynamically provisioned.

## Reclaim Policy
- PersistentVolumes that are dynamically created by a StorageClass will have the reclaim policy specified in the `reclaimPolicy` field of the class, which can be either `Delete` or `Retain`. If no reclaimPolicy is specified when a StorageClass object is created, it will default to `Delete`.
- The reclaim policy is responsible for what happens to the data in persistent volume when the kubernetes persistent volume claim has been deleted.

**Retain:**
If this policy is enabled, the PV will continue to exist even after the PVC is deleted. When the claim is deleted, the volume remains. but it won’t be available to another claim until the previous claimant’s data remains on the volume. With the “Retain” policy, if a user deletes a PersistentVolumeClaim the corresponding PersistentVolume is not be deleted. Instead, it is moved to the Released phase, where all of its data can be manually recovered.

**Delete:**
The persistent volume is deleted when the claim is deleted. For dynamically provisioned PersistentVolumes, the default reclaim policy is “Delete”. This reclaim policy deletes the PersistentVolume  object from the Kubernetes API and associated storage capacity in the external infrastructure (e.g., AWS EBS, Google Persistent Disk, etc.). AWS EBS, GCE PD, Azure Disk, and Cinder volumes support this delete reclaim policy.

## Allow Volume Expansion
PersistentVolumes can be configured to be expandable. This feature when set to true, allows the users to resize the volume by editing the corresponding PVC object.

## Mount Options or volumeBindingMode
- `WaitForFirstConsumer` mode will delay the volume binding and provisioning of a PersistentVolume until a Pod using the PersistentVolumeClaim is created.

- `Immediate` mode indicates that volume binding and dynamic provisioning occurs once the PersistentVolumeClaim is created. PersistentVolumes will be bound or provisioned without knowledge of the Pod's scheduling requirements. This may result in `unschedulable` Pods.

- with `Immediate`, when the storage is created, it will be mounted autimatically in any AZ that we do not know. The issue is that when the pod that is going to consume that consume that storage can be created in another AZ and this is going to create a problem. This is why `WaitForFirstConsumer` is good because it will wait will delay the volume binding and provisioning of a PersistentVolume until a Pod using the PersistentVolumeClaim is created so that the volume and the pod should be in the same region. This means once the pod is created, PersistentVolumes is created in the same region and the bind happen.

- You want your StorageClass and pod in the same `topology` or AZ to avoid issues

## Step-04: Connect to MySQL Database

Connect to MYSQL Database
```
Usage:
  kubectl run NAME --image=image [--env="key=value"] [--port=port] [--replicas=replicas] [--dry-run=bool] [--overrides=inline-json] [--command] -- [COMMAND] [args...] [options]
```
```
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11
```

Verify usermgmt schema got created which we provided in ConfigMap
```
mysql> show schemas;
```

## References
- **EBS CSI Driver:** https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- **EBS CSI Driver Dynamic Provisioning:**  https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes/dynamic-provisioning
- **EBS CSI Driver - Other Examples like Resizing, Snapshot etc:** https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes
