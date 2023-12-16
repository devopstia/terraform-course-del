# List of Terraform versions and corresponding binary names
$terraformVersions = @("0.12.30", "0.13.0", "0.14.0", "1.0.0", "1.2.6", "1.0.0")
$terraformBinNames = @("tf12", "tf13", "tf14", "tf1", "tf126", "terraform")

# Create a directory to store the Terraform binaries
$installDir = "C:\Terraform" # make sure you add this to path
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

# Loop through the versions and install each one with the corresponding binary name
for ($i = 0; $i -lt $terraformVersions.Length; $i++) {
    $version = $terraformVersions[$i]
    $binaryName = $terraformBinNames[$i]

    Write-Host ("Installing Terraform version $version as $binaryName...")

    $url = "https://releases.hashicorp.com/terraform/$version/terraform_${version}_windows_amd64.zip"
    $zipFile = Join-Path $installDir "terraform.zip"
    $extractDir = Join-Path $installDir $version

    # Download Terraform binary
    Invoke-WebRequest -Uri $url -OutFile $zipFile

    # Extract the downloaded zip file
    Expand-Archive -Path $zipFile -DestinationPath $extractDir -Force

    # Rename the Terraform binary to the desired name
    Rename-Item -Path (Join-Path $extractDir "terraform.exe") -NewName "$binaryName.exe"

    # Move the renamed binary to a directory in the system's PATH
    Move-Item -Path (Join-Path $extractDir "$binaryName.exe") -Destination (Join-Path $installDir "$binaryName.exe") -Force

    # Remove the downloaded zip file and the extracted directory
    Remove-Item -Path $zipFile -Force
    Remove-Item -Path $extractDir -Recurse -Force

    Write-Host ("Installed Terraform version $version as $binaryName.")
}

# Add the Terraform installation directory to the system's PATH
$envPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
if ($envPath -notlike "*$installDir*") {
    [System.Environment]::SetEnvironmentVariable("PATH", "$envPath;$installDir", [System.EnvironmentVariableTarget]::Machine)
}

# Verify the installed versions
Write-Host "Installed Terraform versions:"
tf12 version
tf13 version
tf14 version
tf1 version
tf126 version
terraform version
