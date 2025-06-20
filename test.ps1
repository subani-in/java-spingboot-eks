
# # Root folder
# $root = "java-springboot-eks"
# New-Item -ItemType Directory -Path $root

# # Common function to create folders and files
# function New-MicroserviceStructure($serviceName, $packagePath) {
#     $base = "$root\$serviceName\src\main"
    
#     # Directories
#     $javaPath = "$base\java\$packagePath\controller"
#     $resourcePath = "$base\resources"
#     New-Item -ItemType Directory -Path $javaPath -Force | Out-Null
#     New-Item -ItemType Directory -Path $resourcePath -Force | Out-Null

#     # Files
#     New-Item -ItemType File -Path "$javaPath\$($serviceName.Substring(0, $serviceName.IndexOf('-')) )Controller.java" | Out-Null
#     New-Item -ItemType File -Path "$base\java\$packagePath\$($serviceName.Substring(0, $serviceName.IndexOf('-')) )ServiceApplication.java" | Out-Null
#     New-Item -ItemType File -Path "$resourcePath\application.properties" | Out-Null
#     New-Item -ItemType File -Path "$root\$serviceName\pom.xml" | Out-Null
#     New-Item -ItemType File -Path "$root\$serviceName\Dockerfile" | Out-Null
# }

# # Create product-service and user-service structures
# New-MicroserviceStructure "product-service" "com\example\product"
# New-MicroserviceStructure "user-service" "com\example\user"

# # Create shared k8s and README.md
# New-Item -ItemType Directory -Path "$root\k8s" | Out-Null
# # New-Item -ItemType File -Path "$root\README.md" | Out-Null

# Write-Host "✅ Project structure created at $root"



# PowerShell Script: Install Apache Maven on Windows
# Requires: Run as Administrator

# -------------------------------
# Configuration
# -------------------------------
$MavenVersion = "4.0.0-rc-3"
$MavenUrl = "https://dlcdn.apache.org/maven/maven-4/$MavenVersion/binaries/apache-maven-$MavenVersion-bin.zip" 
#$MavenUrl = "https://downloads.apache.org/maven/maven-3/$MavenVersion/binaries/apache-maven-$MavenVersion-bin.zip"
$DownloadPath = "$env:USERPROFILE\Downloads\apache-maven.zip"
$InstallBase = "C:\Tools"
$MavenInstallPath = "$InstallBase\apache-maven-$MavenVersion"

# -------------------------------
# Create Install Directory
# -------------------------------
if (!(Test-Path -Path $InstallBase)) {
    New-Item -ItemType Directory -Path $InstallBase -Force
}

# -------------------------------
# Download Maven
# -------------------------------
Write-Output "Downloading Apache Maven $MavenVersion..."
Invoke-WebRequest -Uri $MavenUrl -OutFile $DownloadPath

# -------------------------------
# Extract Maven
# -------------------------------
Write-Output "Extracting Maven to $InstallBase..."
Expand-Archive -Path $DownloadPath -DestinationPath $InstallBase -Force

# -------------------------------
# Set Environment Variables
# -------------------------------
Write-Output "Setting environment variables..."

[System.Environment]::SetEnvironmentVariable("MAVEN_HOME", $MavenInstallPath, "Machine")

# Add Maven bin to system PATH if not already added
$existingPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$mavenBinPath = "$MavenInstallPath\bin"

if ($existingPath -notlike "*$mavenBinPath*") {
    $newPath = "$existingPath;$mavenBinPath"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
}

# -------------------------------
# Done
# -------------------------------
Write-Output "Apache Maven $MavenVersion installed successfully!"
Write-Output "Restart your PowerShell or system to reflect the changes."
