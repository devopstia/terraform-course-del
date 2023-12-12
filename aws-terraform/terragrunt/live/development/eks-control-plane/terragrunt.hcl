# terraform {
#   source = "../../../../modules//eks-control-plane/"
# }

# # Include all settings from the root terragrunt.hcl file
# include {
#   path = find_in_parent_folders()
# }

# dependencies {
#   paths = [
#     "${get_terragrunt_dir()}/../vpc-02", 
#     ]
# }

# inputs = {
  
# }