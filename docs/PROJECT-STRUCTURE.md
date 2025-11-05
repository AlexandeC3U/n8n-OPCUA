# Project Structure

This document describes the structure and purpose of each file in this project.

## 📁 Project Layout

```
n8n-OPCUA/
├── 📄 docker-compose.yml              # Main Docker Compose configuration
├── 📄 Dockerfile                      # Custom n8n image with OPC UA plugin
├── 📄 .dockerignore                   # Docker build ignore patterns
├── 📄 .gitignore                      # Git ignore patterns
│
├── 📄 env.example                     # Environment variables template
├── 📄 .env                            # Your environment config (created from env.example)
│
├── 📄 README.md                       # Main documentation
├── 📄 QUICKSTART.md                   # 5-minute quick start guide
├── 📄 PROJECT-STRUCTURE.md            # This file
│
├── 📄 example-workflow.json           # Sample n8n workflow to import
│
├── 📂 opcua-server/                   # OPC UA simulation server
│   ├── 📄 package.json                # Node.js dependencies
│   ├── 📄 server.js                   # OPC UA server implementation
│   └── 📂 node_modules/               # Dependencies (generated)
│
├── 🚀 Windows PowerShell Scripts:
├── 📄 setup.ps1                       # Initial setup script
├── 📄 start.ps1                       # Start all services
├── 📄 stop.ps1                        # Stop all services
├── 📄 logs.ps1                        # View container logs
│
├── 🚀 Windows Batch Scripts:
├── 📄 start.bat                       # Start services (cmd alternative)
│
├── 🔧 Linux/Mac:
├── 📄 Makefile                        # Make commands for Unix systems
│
└── 📄 docker-compose.override.yml.example  # Customization template
```

## 📄 File Descriptions

### Core Docker Files

#### `docker-compose.yml`
Main orchestration file defining two services:
- **n8n**: Workflow automation platform with OPC UA plugin
- **opcua-server**: Simulation OPC UA server for testing

Includes:
- Volume definitions for data persistence
- Network configuration
- Health checks
- Environment variables
- Restart policies

#### `Dockerfile`
Custom n8n image that:
- Extends official n8n image
- Installs @fiqch/n8n-nodes-fiq-opcua plugin
- Sets up proper permissions
- Configures health checks

#### `.dockerignore`
Excludes unnecessary files from Docker build context:
- Documentation files
- Scripts
- Development files
- OS-specific files

### Configuration Files

#### `env.example`
Template for environment variables:
- n8n configuration (host, protocol, webhooks)
- Timezone settings
- Authentication settings
- Database configuration options

Copy to `.env` and customize for your setup.

#### `docker-compose.override.yml.example`
Template for local customizations:
- Custom ports
- Development settings
- Additional services (PostgreSQL, Redis)
- Volume mounts

Copy to `docker-compose.override.yml` to use.

### Documentation

#### `README.md`
Comprehensive documentation including:
- Prerequisites and installation
- Configuration options
- Available OPC UA test nodes
- Troubleshooting guide
- Production considerations
- Example workflows

#### `QUICKSTART.md`
Step-by-step guide to get running in 5 minutes:
- Quick setup instructions
- Creating first workflow
- Testing reads and writes
- Common use cases

#### `PROJECT-STRUCTURE.md`
This file - explains project organization.

### OPC UA Server

#### `opcua-server/server.js`
Node.js OPC UA server with:
- 7 simulated nodes (temperature, pressure, counters, etc.)
- Read-only and read/write variables
- Dynamic value simulation
- Detailed logging

#### `opcua-server/package.json`
Dependencies for OPC UA server:
- node-opcua library
- Node.js engine requirements

### Helper Scripts

#### Windows PowerShell Scripts

**`setup.ps1`**
- Initial environment setup
- Creates .env from template
- Installs OPC UA server dependencies
- Validates prerequisites

**`start.ps1`**
- Checks Docker status
- Installs dependencies
- Starts all services
- Opens browser to n8n
- Shows logs

**`stop.ps1`**
- Gracefully stops all services
- Preserves data volumes

**`logs.ps1`**
- View container logs
- Supports filtering by service
- Usage: `.\logs.ps1` or `.\logs.ps1 n8n`

#### Windows Batch Script

**`start.bat`**
- Alternative to start.ps1 for cmd.exe users
- Same functionality as PowerShell version

#### Unix/Linux/Mac

**`Makefile`**
Commands for Unix-based systems:
- `make help` - Show available commands
- `make up` - Start services
- `make down` - Stop services
- `make logs` - View logs
- `make backup` - Backup n8n data
- `make restore` - Restore from backup
- `make clean` - Remove everything

### Example Files

#### `example-workflow.json`
Sample n8n workflow demonstrating:
- Scheduled trigger (every 10 seconds)
- Reading OPC UA tags
- Conditional logic based on values
- Writing to OPC UA tags

Import this into n8n to get started quickly.

## 🔄 Typical Workflow

### First Time Setup

1. Run `setup.ps1` (or `make install` on Unix)
2. Edit `.env` if needed
3. Run `start.ps1` (or `make up`)
4. Follow QUICKSTART.md

### Daily Development

1. Start: `.\start.ps1` or `make up`
2. Work in n8n at http://localhost:5678
3. Check logs: `.\logs.ps1` or `make logs`
4. Stop: `.\stop.ps1` or `make down`

### Customization

1. Copy `docker-compose.override.yml.example` to `docker-compose.override.yml`
2. Add your customizations
3. Restart: `.\start.ps1` or `make restart`

## 📊 Data Persistence

### Docker Volumes

**`n8n_opcua_data`**
Stores:
- Workflows
- Credentials
- Execution history
- Settings
- SQLite database (by default)

Location (Windows): `\\wsl$\docker-desktop-data\data\docker\volumes\n8n_opcua_data`

### Backup

```powershell
# PowerShell
docker run --rm -v n8n_opcua_data:/data -v ${PWD}/backups:/backup alpine tar czf /backup/n8n-backup.tar.gz -C /data .
```

```bash
# Unix/Linux/Mac
make backup
```

### Restore

```powershell
# PowerShell
docker run --rm -v n8n_opcua_data:/data -v ${PWD}/backups:/backup alpine tar xzf /backup/n8n-backup.tar.gz -C /data
```

```bash
# Unix/Linux/Mac
make restore BACKUP_FILE=./backups/n8n-backup-20241105-120000.tar.gz
```

## 🌐 Network Architecture

```
┌─────────────────────────────────────────┐
│  Host Machine (Windows)                 │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Docker Network: n8n-opcua-net  │   │
│  │                                  │   │
│  │  ┌──────────┐    ┌────────────┐ │   │
│  │  │   n8n    │◄──►│ OPC UA     │ │   │
│  │  │  :5678   │    │ Server     │ │   │
│  │  │          │    │ :4840      │ │   │
│  │  └────┬─────┘    └─────┬──────┘ │   │
│  │       │                 │        │   │
│  └───────┼─────────────────┼────────┘   │
│          │                 │            │
│    Port  │           Port  │            │
│    5678  │           4840  │            │
└──────────┼─────────────────┼────────────┘
           │                 │
      Browser          OPC UA Client
      Access           (if needed)
```

## 🔐 Security Considerations

### Development Setup (Default)
- No authentication on OPC UA server
- Basic auth disabled on n8n
- HTTP protocol
- Suitable for local development only

### Production Setup
See README.md for:
- Enabling n8n authentication
- Using HTTPS/SSL
- Securing OPC UA connections
- Using proper database (PostgreSQL)
- Backup strategies

## 📝 License

This setup is provided as-is for development and testing purposes.

## 🆘 Getting Help

1. Check README.md for detailed documentation
2. Review QUICKSTART.md for common tasks
3. Check container logs: `.\logs.ps1` or `make logs`
4. Verify services: `docker-compose ps`
5. Check n8n docs: https://docs.n8n.io/
6. Check OPC UA plugin: https://factoryiq.io/modules

## 🚀 Quick Reference

| Task | Windows | Unix/Linux/Mac |
|------|---------|----------------|
| Setup | `.\setup.ps1` | `make install` |
| Start | `.\start.ps1` | `make up` |
| Stop | `.\stop.ps1` | `make down` |
| Logs | `.\logs.ps1` | `make logs` |
| Restart | `docker-compose restart` | `make restart` |
| Status | `docker-compose ps` | `make ps` |
| Clean | `docker-compose down -v` | `make clean` |

---

**Happy automating with n8n and OPC UA! 🎉**

