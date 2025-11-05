# n8n OPC UA Docker Setup - Stop Script
# PowerShell script to stop services

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  Stopping n8n and OPC UA services" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# Stop containers
Write-Host "Stopping Docker containers..." -ForegroundColor Yellow
docker-compose down

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Services stopped successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your data has been preserved in Docker volumes." -ForegroundColor White
    Write-Host "Run .\start.ps1 to start the services again." -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "ERROR: Failed to stop services" -ForegroundColor Red
    exit 1
}

Write-Host ""

