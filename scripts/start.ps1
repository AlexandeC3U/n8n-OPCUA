# n8n OPC UA Docker Setup - Start Script
# PowerShell script for easy startup on Windows

Write-Host "=================================================" -ForegroundColor Cyan
Write-Host "  n8n with OPC UA Plugin - Docker Setup" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
Write-Host "Checking Docker status..." -ForegroundColor Yellow
try {
    $dockerCheck = docker info 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Docker is not running!" -ForegroundColor Red
        Write-Host "Please start Docker Desktop and try again." -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Docker is not installed or not running!" -ForegroundColor Red
    Write-Host "Please install Docker Desktop and try again." -ForegroundColor Red
    exit 1
}

Write-Host ""

# Check if docker-compose exists
Write-Host "Checking Docker Compose..." -ForegroundColor Yellow
$composeVersion = docker-compose --version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Docker Compose is available" -ForegroundColor Green
} else {
    Write-Host "ERROR: Docker Compose is not available!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Install OPC UA server dependencies
Write-Host "Installing OPC UA server dependencies..." -ForegroundColor Yellow
Push-Location opcua-server
if (Test-Path "package.json") {
    npm install --silent
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Dependencies installed" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Failed to install dependencies" -ForegroundColor Yellow
        Write-Host "The container will install them on first run." -ForegroundColor Yellow
    }
} else {
    Write-Host "WARNING: package.json not found" -ForegroundColor Yellow
}
Pop-Location

Write-Host ""

# Start services
Write-Host "Starting Docker containers..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Containers started successfully!" -ForegroundColor Green
} else {
    Write-Host "ERROR: Failed to start containers" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Waiting for services to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Check container status
Write-Host ""
Write-Host "Container Status:" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "=================================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Access your services:" -ForegroundColor White
Write-Host "  • n8n UI:          http://localhost:5678" -ForegroundColor Cyan
Write-Host "  • OPC UA Server:   opc.tcp://localhost:4840/UA/SimulationServer" -ForegroundColor Cyan
Write-Host ""
Write-Host "OPC UA Connection Details for n8n:" -ForegroundColor White
Write-Host "  • Endpoint URL:    opc.tcp://opcua-server:4840/UA/SimulationServer" -ForegroundColor Yellow
Write-Host "  • Security Mode:   None" -ForegroundColor Yellow
Write-Host "  • Security Policy: None" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor White
Write-Host "  1. Open http://localhost:5678 in your browser" -ForegroundColor White
Write-Host "  2. Set up your n8n account" -ForegroundColor White
Write-Host "  3. Add OPC UA credential (see QUICKSTART.md)" -ForegroundColor White
Write-Host "  4. Import example-workflow.json or create your own!" -ForegroundColor White
Write-Host ""
Write-Host "Useful Commands:" -ForegroundColor White
Write-Host "  • View logs:       docker-compose logs -f" -ForegroundColor Gray
Write-Host "  • Stop services:   docker-compose down" -ForegroundColor Gray
Write-Host "  • Restart:         docker-compose restart" -ForegroundColor Gray
Write-Host ""
Write-Host "Opening n8n in your browser..." -ForegroundColor Yellow
Start-Sleep -Seconds 2
Start-Process "http://localhost:5678"

Write-Host ""
Write-Host "Press any key to view live logs (Ctrl+C to exit logs)..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

docker-compose logs -f

