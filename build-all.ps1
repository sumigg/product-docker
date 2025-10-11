# build-all.ps1

# Exit on error
$ErrorActionPreference = "Stop"

# Get the script's directory
$ScriptDir = $PSScriptRoot

# Define services
$coreServices = @(
    "product-api",
    "product-util"
)

$microservices = @(
    "product-service",
    "recommendation-servise", # Typo in directory name
    "review-service",
    "product-composite-service",
    "product-eureka-server",
    "gateway",
    "auth-server",
    "product-config-server"
)

# Function to build a service
function Build-Service {
    param (
        [string]$serviceName
    )

    Write-Host "--- Building $serviceName ---"
    $servicePath = Join-Path (Get-Item $ScriptDir).Parent.FullName $serviceName

    if (-not (Test-Path $servicePath)) {
        Write-Error "Directory not found: $servicePath"
        exit 1
    }

    Push-Location $servicePath

    try {
        if (Test-Path "mvnw.cmd") {
            & .\mvnw.cmd clean install -DskipTests
        }
        elseif (Test-Path "mvnw") {
            & .\mvnw clean install -DskipTests
        }
        else {
            Write-Error "No Maven wrapper found for $serviceName"
            exit 1
        }
        Write-Host "Successfully built $serviceName"
    }
    catch {
        Write-Error "Failed to build $serviceName"
        # It's a terminating error because of $ErrorActionPreference = "Stop", so script will exit.
    }
    finally {
        Pop-Location
    }
}

# Build core services
Write-Host "Building core dependencies..."
foreach ($service in $coreServices) {
    Build-Service -serviceName $service
}

# Build microservices
Write-Host "Building microservices..."
foreach ($service in $microservices) {
    Build-Service -serviceName $service
}

Write-Host "All projects built successfully!"
