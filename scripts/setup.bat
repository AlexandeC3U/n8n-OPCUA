@echo off
REM n8n OPC UA Docker Setup - Initial Setup Script
REM Run this script once to prepare your environment

echo =================================================
echo   n8n OPC UA Setup - Initial Configuration
echo =================================================
echo.

REM Check if .env exists
if not exist .env (
    echo Creating .env file from env.example...
    copy env.example .env
    echo [OK] .env file created
    echo.
    echo Please edit .env file to customize your settings:
    echo   - Change TIMEZONE to your timezone
    echo   - Set N8N_BASIC_AUTH_ACTIVE=true for authentication
    echo   - Update credentials if needed
    echo.
) else (
    echo .env file already exists
    echo.
)

REM Check if Node.js/npm is available for OPC UA server
echo Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Node.js is not installed (optional)
    echo The OPC UA server will install dependencies in the container.
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [OK] Node.js is installed: %NODE_VERSION%
    
    REM Install OPC UA server dependencies
    echo.
    echo Installing OPC UA server dependencies...
    cd opcua-server
    call npm install
    if errorlevel 1 (
        echo WARNING: Failed to install dependencies
        echo Dependencies will be installed when the container starts.
    ) else (
        echo [OK] OPC UA server dependencies installed
    )
    cd ..
)

echo.
echo =================================================
echo   Setup Complete!
echo =================================================
echo.
echo Next steps:
echo   1. Review and edit .env file if needed
echo   2. Run start.bat to start the services
echo   3. Follow QUICKSTART.md for your first workflow
echo.
echo Quick Commands:
echo   Start:  start.bat  (or start.ps1 in PowerShell)
echo   Stop:   stop.ps1
echo   Logs:   logs.ps1
echo.
echo Documentation:
echo   Quick Start:     QUICKSTART.md
echo   Full Guide:      README.md
echo   Example:         example-workflow.json
echo.
pause

