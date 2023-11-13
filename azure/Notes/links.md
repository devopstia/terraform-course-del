
### Course GitHub Repository Links
- [Course Main Repository](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure)

- [Terraform Cloud Demo](https://github.com/stacksimplify/terraform-cloud-azure-demo1)

- [Terraform Public Module Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsitepublic)

- [Terraform Private Module Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsiteprivate)

- [Terraform Sentinel Policies](https://github.com/stacksimplify/terraform-sentinel-policies-azure)

- [Course Presentation](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure/tree/main/course-presentation)


### Free account
[Build in the cloud with an Azure free account](https://azure.microsoft.com/en-us/free/)


[Contact Azure Sales](https://azure.microsoft.com/en-au/overview/sales-number/)

### Azure CLI installation on windows
[How to install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

1. Check the version
```
az --version
```
2. Help
```
az
```
3. Login through Azure cli
```
az login
```


### Azure Storage Account (Disk, Files, Blobs, Tables, Queues- Tiers Hot & Cold)
- Disk for VM or block storage
- Blobs for unstructure data or abject storage in AWS
- table for NoSQL
- Queues for decouple and scale components or for messaging system

### Storage Tiers
- hot tier for frequent access
- cool for infrequent access
- archive for backup


### Storage replication options:
Azure Storage Replication Explained: LRS, ZRS, GRS, RA-GRS [HERE](https://cloud.netapp.com/blog/azure-anf-blg-azure-storage-replication-explained-lrs-zrs-grs-ra-grs)

- Locally-Redundant Storage (LRS)
- Zone-Redundant Storage (ZRS)
- Geo-Redundant storage (GRS)
- Read-Access Geo-Redundant (RA-GRS)
- Object Replication for Block Blob Storage
- Azure Storage Replication Q&A

By default, Azure Storage replicates data three times within a primary region. Additionally, Azure offers the following options you can configure for replication within the primary region:
- **Locally redundant storage (LRS)** —synchronously replicates data to three disks within a data center in the primary region. Offers a moderate level of availability at a lower cost.
- **Zone-redundant storage (ZRS)** —synchronously replicates data among three Azure availability zones in the primary region. Provides a higher level of resilience at higher cost.
- **Storage:Geo-Redundant storage (GRS)** —stores another three copies of data in a paired Azure region
- **Read-Access Geo-Redundant** (RA-GRS) —same as GRS, but allows data to be read from both Azure regions
- **Object Replication for Block Blob Storage** —a special type of replication used only for block blobs, replicating them between a source and target storage account.