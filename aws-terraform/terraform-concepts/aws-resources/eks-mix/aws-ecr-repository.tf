# module "jenkins-repo-2624" {
#   source               = "./modules/ecr-repository"
#   ecr_respository_name = "2624-jenkins-repo"
#   common_tags = {
#     AssetName    = "operations"
#     ControlledBy = "terraform"
#   }
# }

# module "del-build-repo-2624" {
#   source               = "./modules/ecr-repository"
#   ecr_respository_name = "2624-del-build-repo"
#   common_tags = {
#     AssetName    = "operations"
#     ControlledBy = "terraform"
#   }
# }
