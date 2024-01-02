## Storage account and state lock
- Azure lock the state file with storage account and storage account container while AWS use s3 and dynamoDB
- Storage account container only accept numbers and lowercase letters (this make things difficult to give the proper name the storage account) while s3 accept all even special characters
- Azure allow us to destroy a storage account without emptying it while AWS will no allow us to do that
- When we run terraform apply in azure, the state will became `leased` which means it lock and `available` when the apply is done while it is a little difficult to see this directly in AWS

## Resource group
- AWS do not have a resource group while Azure has it. This allow us to group resources

## Vnet Vs VPC
- AWS come with default VPC while Azure don't

## Resource naming
- Azure allow on 3 to 24 characters while AWS allow more that 24

## SG
- A security group can be attach to a subnet or a VM in Azure while we only attach in to a VM in AWS

## NAT
- We can create a NAT at the loadbalancer level with a specify SSH port to access VM behind the loadbalancer while it is not passible in AWS