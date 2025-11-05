@echo off
REM n8n OPC UA Docker Setup - Start Script (Batch)
REM Windows batch file for users who prefer cmd over PowerShell

echo =================================================
echo   n8n with OPC UA Plugin - Docker Setup
echo =================================================
echo.

REM Check if Docker is running
echo Checking Docker status...
docker info >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)
echo [OK] Docker is running
echo.

REM Install OPC UA server dependencies
echo Installing OPC UA server dependencies...
cd opcua-server
if exist package.json (
    call npm install --silent
    if errorlevel 1 (
        echo WARNING: Failed to install dependencies
        echo The container will install them on first run.
    ) else (
        echo [OK] Dependencies installed
    )
) else (
    echo WARNING: package.json not found
)
cd ..
echo.

REM Start services
echo Starting Docker containers...
docker-compose up -d
if errorlevel 1 (
    echo ERROR: Failed to start containers
    pause
    exit /b 1
)
echo [OK] Containers started successfully!
echo.

echo Waiting for services to initialize...
timeout /t 10 /nobreak >nul
echo.

REM Check container status
echo Container Status:
docker-compose ps
echo.

echo =================================================
echo   Setup Complete!
echo =================================================
echo.
echo Access your services:
echo   * n8n UI:          http://localhost:5678
echo   * OPC UA Server:   opc.tcp://localhost:4840/UA/SimulationServer
echo.
echo OPC UA Connection Details for n8n:
echo   * Endpoint URL:    opc.tcp://opcua-server:4840/UA/SimulationServer
echo   * Security Mode:   None
echo   * Security Policy: None
echo.
echo Next Steps:
echo   1. Open http://localhost:5678 in your browser
echo   2. Set up your n8n account
echo   3. Add OPC UA credential (see QUICKSTART.md)
echo   4. Import example-workflow.json or create your own!
echo.
echo Useful Commands:
echo   * View logs:       docker-compose logs -f
echo   * Stop services:   docker-compose down
echo   * Restart:         docker-compose restart
echo.

REM Open browser
echo Opening n8n in your browser...
start http://localhost:5678

echo.
echo Press any key to view live logs (Ctrl+C to exit logs)...
pause >nul

docker-compose logs -f

