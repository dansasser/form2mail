# Optional: Activate a virtual environment if needed
.\venv\Scripts\Activate.ps1

# Path to requirements.txt
$requirementsFile = "requirements.txt"

# Check if requirements.txt exists
if (-Not (Test-Path $requirementsFile)) {
    Write-Host "requirements.txt not found in the current directory." -ForegroundColor Red
    exit 1
}

# Read each line in requirements.txt
Get-Content $requirementsFile | ForEach-Object {
    $requirement = $_.Trim()

    # Skip empty lines and comments
    if (-not $requirement -or $requirement.StartsWith("#")) {
        return
    }

    # Extract package name (handles version specs like 'package==1.0.0')
    $packageName = $requirement -replace '[<>=!].*', ''

    # Check if the package is already installed
    $packageCheck = pip show $packageName 2>&1

    if ($packageCheck -match "WARNING: Package(s) not found:") {
        Write-Host "$packageName is not installed. Installing..." -ForegroundColor Yellow
        pip install $requirement
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$packageName installed successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to install $packageName. Please check for errors." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "$packageName is already installed." -ForegroundColor Green
    }
}

Write-Host "All dependencies are satisfied. The app is now ready for deployment." -ForegroundColor Cyan
