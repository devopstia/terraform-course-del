## How to push Terraform module into Terraform registry
- https://github.com/devopstia/terraform-aws-vpc-module
- https://registry.terraform.io/modules/devopstia/vpc-module/aws/latest

## Steps
- Create a repository in Github
- Add your module file and push to Github repository
- Create a tag and push to git repository
    - git tag -a <tag_name> -m "Your tag message"
    - git tag -a v1.0.0 -m "Initial release"
    - git push origin <tag_name>
    - git push origin v1.0.0
- Create a release in Github
- Login in Terraform registry https://registry.terraform.io/ using your github account
    - Go to sign in
    - Sign in with Github
    - Provide your github credentials
- Publish a module
    - Go Publish
    - Select a module to publish
    - Hit publish
- Publish a new version of the module or sync changes
    - Go to module
    - Manage module
    - Click on resync module
