## Github Repositories used for this course
- [HashiCorp Certified: Terraform Associate on Azure](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure)
- [Terraform Cloud Demo](https://github.com/stacksimplify/terraform-cloud-azure-demo1)
- [Terraform Module Published to Public Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsitepublic)
- [Terraform Module Published to Terraform Cloud Private Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsiteprivate)
- [Terraform Sentinel Policies](https://github.com/stacksimplify/terraform-sentinel-policies-azure)
- [Course PPT Presentation](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-azure/tree/master/course-presentation)
- **Important Note:** Please go to these repositories and FORK these repositories and make use of them during the course.


## Each of my courses come with
- Amazing Hands-on Step By Step Learning Experiences
- Real Implementation Experience
- Friendly Support in the Q&A section
- 30 Day "No Questions Asked" Money Back Guarantee!

## My Other Courses
- [Udemy Enroll](https://stacksimplify.com/azure-aks/courses/stacksimplify-best-selling-courses-on-udemy/)

## Stack Simplify Udemy Profile
- [Udemy Profile](https://www.udemy.com/user/kalyan-reddy-9/)

## AWS EKS - Elastic Kubernetes Service - Masterclass
[![Image](https://stacksimplify.com/course-images/AWS-EKS-Kubernetes-Masterclass-DevOps-Microservices-course.png "AWS EKS Kubernetes - Masterclass")](https://www.udemy.com/course/aws-eks-kubernetes-masterclass-devops-microservices/?referralCode=257C9AD5B5AF8D12D1E1)

## Azure Kubernetes Service with Azure DevOps and Terraform 
[![Image](https://stacksimplify.com/course-images/azure-kubernetes-service-with-azure-devops-and-terraform.png "Azure Kubernetes Service with Azure DevOps and Terraform")](https://www.udemy.com/course/azure-kubernetes-service-with-azure-devops-and-terraform/?referralCode=2499BF7F5FAAA506ED42)

## HashiCorp Certified: Terraform Associate - 50 Practical Demos
[![Image](https://stacksimplify.com/course-images/hashicorp-certified-terraform-associate-highest-rated.png "HashiCorp Certified: Terraform Associate - 50 Practical Demos")](https://links.stacksimplify.com/hashicorp-certified-terraform-associate)

## Terraform on AWS with SRE & IaC DevOps | Real-World 20 Demos
[![Image](https://stacksimplify.com/course-images/terraform-on-aws-best-seller.png "Terraform on AWS with SRE & IaC DevOps | Real-World 20 Demos")](https://links.stacksimplify.com/terraform-on-aws-with-sre-and-iacdevops)

## Additional References
- [Certification Curriculum](https://www.hashicorp.com/certification/terraform-associate)
- [Certification Preparation](https://learn.hashicorp.com/collections/terraform/certification)
- [Study Guide](https://learn.hashicorp.com/tutorials/terraform/associate-study?in=terraform/certification)
- [Exam Review Guide](https://learn.hashicorp.com/tutorials/terraform/associate-review?in=terraform/certification)
- [Sample Questions](https://learn.hashicorp.com/tutorials/terraform/associate-questions?in=terraform/certification)



- `required_version` focuses on underlying Terraform CLI installed on your desktop
- If the running version of Terraform on your local desktop doesn't match the constraints specified in your terraform block, Terraform will produce an error and exit without taking any further actions.
- By changing the versions try `terraform init` and observe whats happening
```t
# Play with Terraform CLI Version (We installed 1.0.0 version)
  required_version = "~> 0.14.3" - Will fail
  required_version = "~> 0.14"   - Will fail  
  required_version = "= 0.14.4"  - Will fail
  required_version = ">= 0.13"   - will pass
  required_version = "= 1.0.0"   - will pass
  required_version = "1.0.0"     - will pass 
  required_version = ">= 1.0.0"   - will pass   
 
# Terraform Block
terraform {
  required_version = ">= 1.0.0"
}

# To view my Terraform CLI Version installed on my desktop
terraform version

# Initialize Terraform
terraform init
```




az account list --output table


