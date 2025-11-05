# n8n OPC UA Docker Setup - View Logs
# PowerShell script to view container logs

param(
    [string]$Service = ""
)

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  Container Logs" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

if ($Service -eq "") {
    Write-Host "Viewing logs from all services..." -ForegroundColor Yellow
    Write-Host "Press Ctrl+C to exit" -ForegroundColor Gray
    Write-Host ""
    docker-compose logs -f
} elseif ($Service -eq "n8n") {
    Write-Host "Viewing n8n logs..." -ForegroundColor Yellow
    Write-Host "Press Ctrl+C to exit" -ForegroundColor Gray
    Write-Host ""
    docker-compose logs -f n8n
} elseif ($Service -eq "opcua" -or $Service -eq "opcua-server") {
    Write-Host "Viewing OPC UA server logs..." -ForegroundColor Yellow
    Write-Host "Press Ctrl+C to exit" -ForegroundColor Gray
    Write-Host ""
    docker-compose logs -f opcua-server
} else {
    Write-Host "ERROR: Unknown service: $Service" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor White
    Write-Host "  .\logs.ps1              # View all logs" -ForegroundColor Gray
    Write-Host "  .\logs.ps1 n8n          # View n8n logs only" -ForegroundColor Gray
    Write-Host "  .\logs.ps1 opcua        # View OPC UA logs only" -ForegroundColor Gray
    exit 1
}

