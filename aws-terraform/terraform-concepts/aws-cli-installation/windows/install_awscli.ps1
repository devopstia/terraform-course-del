# Check if AWS CLI is already installed
if (-Not (Test-Path "C:\Program Files\Amazon\AWSCLI\aws.exe")) {
    # Download the AWS CLI installer
    Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
    
    # Install AWS CLI
    Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList "/i AWSCLIV2.msi /qn" -NoNewWindow

    # Remove the installer
    Remove-Item -Path "AWSCLIV2.msi" -Force
}

# Verify the AWS CLI installation
$awsCliVersion = aws --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "AWS CLI installation completed."
    Write-Host "Installed AWS CLI version: $awsCliVersion"
} else {
    Write-Host "Failed to install AWS CLI."
}


