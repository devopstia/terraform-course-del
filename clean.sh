#!/bin/bash

# Get the root directory of the repository
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$REPO_ROOT" ]; then
    echo "Not a git repository or unable to determine repository root."
    exit 1
fi

# Delete terraform directories and files
find "/home/tia/code" -type d -name '.terraform' -exec rm -rf {} \;
find "/home/tia/code" -type f -name '.terraform.lock.hcl' -exec rm -f {} \;
# find "/home/tia/code" -type f -name 'terraform.tfstate' -exec rm -f {} \;
# find "/home/tia/code" -type f -name 'terraform.tfstate.backup' -exec rm -f {} \;

# Delete terragrunt directories and files
find "/home/tia/code" -type d -name '.terragrunt' -exec rm -rf {} \;
find "/home/tia/code" -type d -name '.terragrunt-cache' -exec rm -rf {} \;

echo "Cleanup complete."