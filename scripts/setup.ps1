# n8n OPC UA Docker Setup - Initial Setup Script
# Run this script once to prepare your environment

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  n8n OPC UA Setup - Initial Configuration" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# Check if .env exists
if (-not (Test-Path ".env")) {
    Write-Host "Creating .env file from env.example..." -ForegroundColor Yellow
    Copy-Item "env.example" ".env"
    Write-Host "✓ .env file created" -ForegroundColor Green
    Write-Host ""
    Write-Host "Please edit .env file to customize your settings:" -ForegroundColor White
    Write-Host "  - Change TIMEZONE to your timezone" -ForegroundColor Gray
    Write-Host "  - Set N8N_BASIC_AUTH_ACTIVE=true for authentication" -ForegroundColor Gray
    Write-Host "  - Update credentials if needed" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host ".env file already exists" -ForegroundColor Green
    Write-Host ""
}

# Check if Node.js/npm is available for OPC UA server
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
        
        # Install OPC UA server dependencies
        Write-Host ""
        Write-Host "Installing OPC UA server dependencies..." -ForegroundColor Yellow
        Push-Location opcua-server
        npm install
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ OPC UA server dependencies installed" -ForegroundColor Green
        } else {
            Write-Host "WARNING: Failed to install dependencies" -ForegroundColor Yellow
            Write-Host "Dependencies will be installed when the container starts." -ForegroundColor Yellow
        }
        Pop-Location
    }
} catch {
    Write-Host "⚠ Node.js is not installed (optional)" -ForegroundColor Yellow
    Write-Host "The OPC UA server will install dependencies in the container." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=================================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "  1. Review and edit .env file if needed" -ForegroundColor Gray
Write-Host "  2. Run .\start.ps1 to start the services" -ForegroundColor Gray
Write-Host "  3. Follow QUICKSTART.md for your first workflow" -ForegroundColor Gray
Write-Host ""
Write-Host "Quick Commands:" -ForegroundColor White
Write-Host "  Start:  .\start.ps1" -ForegroundColor Cyan
Write-Host "  Stop:   .\stop.ps1" -ForegroundColor Cyan
Write-Host "  Logs:   .\logs.ps1" -ForegroundColor Cyan
Write-Host ""
Write-Host "Documentation:" -ForegroundColor White
Write-Host "  Quick Start:     QUICKSTART.md" -ForegroundColor Gray
Write-Host "  Full Guide:      README.md" -ForegroundColor Gray
Write-Host "  Example:         example-workflow.json" -ForegroundColor Gray
Write-Host ""

