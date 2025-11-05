# n8n with OPC UA Plugin - Docker Setup

Complete Docker environment for running n8n with the **OPC UA plugin** (@fiqch/n8n-nodes-fiq-opcua) and a simulation OPC UA server for testing and experimentation.

## 🎯 What You Get

✅ **n8n** (Port 5678) with OPC UA plugin pre-installed  
✅ **OPC UA Simulation Server** (Port 4840) with 7 test variables  
✅ **Persistent Storage** - Data survives container restarts  
✅ **Example Workflow** - Ready-to-import workflow  
✅ **Best Practices** - Volumes, networks, health checks  

**Important**: The OPC UA plugin allows you to connect to **ANY** OPC UA server, not just the simulation one!

---

## 🚀 Quick Start

### Windows (PowerShell)
```powershell
.\scripts\setup.ps1    # Run once - creates .env config
.\scripts\start.ps1    # Starts everything + opens browser
```

### Windows (Command Prompt)
```batch
.\scripts\setup.bat    # Run once - creates .env config
.\scripts\start.bat    # Starts everything + opens browser
```

### Linux/Mac
```bash
make install           # Run once - setup
make up                # Start all services
```

**Browser opens automatically to**: http://localhost:5678

---

## 📖 Documentation

- **[Quick Start Guide](docs/QUICKSTART.md)** - Get running in 5 minutes
- **[Getting Started](docs/GETTING-STARTED.md)** - Detailed beginner walkthrough
- **[Project Summary](docs/SUMMARY.md)** - Complete overview
- **[Q&A](docs/ANSWERS.md)** - Common questions answered

---

## 🔧 First Workflow Setup

After services start:

### 1. Create n8n Account
- Open http://localhost:5678
- Enter email and password (first time only)

### 2. Add OPC UA Credential
- Go to **Settings** → **Credentials** → **Add Credential**
- Search for "OPC UA" and select it
- Configure:
  - **Endpoint URL**: `opc.tcp://opcua-server:4840/UA/SimulationServer`
  - **Security Mode**: `None`
  - **Security Policy**: `None`
- Click **Save**

**Important**: Use `opcua-server` (not `localhost`) as the hostname when connecting from within n8n.

### 3. Import Example Workflow
- **Workflows** → **Add workflow** → **Import from file**
- Select `example-workflow.json` from this folder
- Click **Execute Workflow** to test it

---

## 📊 Available OPC UA Test Variables

The simulation server provides these nodes for testing:

### Read-Only Sensors
| Node ID | Type | Description |
|---------|------|-------------|
| `ns=1;s=Simulation.Temperature` | Double | Oscillating temperature 15-25°C |
| `ns=1;s=Simulation.Pressure` | Double | Random pressure 101-103 kPa |
| `ns=1;s=Simulation.Counter` | UInt32 | Incrementing counter 0-999 |
| `ns=1;s=Simulation.MachineState` | String | Machine state (Idle/Running/Stopped/Error) |

### Read/Write Controls
| Node ID | Type | Description |
|---------|------|-------------|
| `ns=1;s=Simulation.PumpStatus` | Boolean | Pump on/off control |
| `ns=1;s=Simulation.TemperatureSetpoint` | Double | Target temperature |
| `ns=1;s=Simulation.ProductionCount` | UInt32 | Items produced counter |

---

## 🛠️ Common Commands

### Windows PowerShell
```powershell
.\scripts\start.ps1              # Start all services
.\scripts\stop.ps1               # Stop all services
.\scripts\logs.ps1               # View all logs
.\scripts\logs.ps1 n8n           # View n8n logs only
.\scripts\logs.ps1 opcua         # View OPC UA server logs only
docker-compose ps                # Check container status
docker-compose restart           # Restart services
```

### Linux/Mac
```bash
make up                          # Start services
make down                        # Stop services
make logs                        # View all logs
make logs-n8n                    # View n8n logs
make logs-opcua                  # View OPC UA logs
make ps                          # Check status
make restart                     # Restart services
make help                        # Show all commands
```

---

## ⚙️ Configuration

### Environment Variables

Edit `.env` file (created by `setup` script) to customize:

```env
# Basic settings
N8N_HOST=localhost
N8N_PROTOCOL=http
TIMEZONE=Europe/London

# Enable authentication (recommended for production)
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your-secure-password
```

### Custom Configuration

For advanced customization:
1. Copy `docker-compose.override.yml.example` to `docker-compose.override.yml`
2. Modify as needed (ports, volumes, additional services)
3. Restart: `.\scripts\start.ps1` or `make restart`

---

## 📋 Prerequisites

- **Docker Desktop** (Windows/Mac) or Docker Engine (Linux)
- **Docker Compose** v2.0 or higher
- **2GB RAM** available
- **Ports** 5678 and 4840 available

Check Docker installation:
```bash
docker --version
docker-compose --version
docker info
```

---

## 🎯 Example Workflows

### Example 1: Read Temperature
```
Schedule Trigger (every 5 seconds)
  ↓
OPC UA Read Node
  - Node ID: ns=1;s=Simulation.Temperature
  ↓
View Output
```

### Example 2: Control Pump
```
Manual Trigger
  ↓
OPC UA Write Node
  - Node ID: ns=1;s=Simulation.PumpStatus
  - Value: true
  - Data Type: Boolean
```

### Example 3: Automated Control
```
Schedule Trigger (every 10 seconds)
  ↓
OPC UA Read (Temperature)
  ↓
IF Node (temp > 22°C)
  ├─ True → OPC UA Write (Pump ON)
  └─ False → OPC UA Write (Pump OFF)
```

---

## 🔒 Production Considerations

### 1. Enable Authentication
```env
# In .env file
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=strong-password-here
```

### 2. Use PostgreSQL Database
Instead of SQLite, use PostgreSQL for production:
- Copy `docker-compose.override.yml.example` to `docker-compose.override.yml`
- Uncomment PostgreSQL section
- Update connection settings in `.env`

### 3. Setup HTTPS
- Use reverse proxy (nginx, Traefik, Caddy)
- Configure SSL certificates (Let's Encrypt)
- Update `N8N_PROTOCOL=https` in `.env`

### 4. Backup Your Data
```bash
# Windows PowerShell
docker run --rm -v n8n_opcua_data:/data -v ${PWD}/backups:/backup alpine tar czf /backup/n8n-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss').tar.gz -C /data .

# Linux/Mac
make backup
```

### 5. Secure OPC UA Connections
- Use proper security modes (Sign, SignAndEncrypt)
- Configure certificates
- Use authentication
- Restrict network access

---

## 🆘 Troubleshooting

### Services won't start
```bash
# Check if Docker is running
docker info

# Check if ports are available
netstat -an | findstr "5678 4840"   # Windows
lsof -i :5678 -i :4840              # Linux/Mac

# View logs for errors
.\scripts\logs.ps1                  # Windows
make logs                           # Linux/Mac
```

### Can't connect to OPC UA server in n8n
- ✅ Verify endpoint: `opc.tcp://opcua-server:4840/UA/SimulationServer`
- ✅ Use `opcua-server` hostname (NOT `localhost`) 
- ✅ Check logs: `.\scripts\logs.ps1 opcua` or `make logs-opcua`
- ✅ Restart OPC UA server: `docker-compose restart opcua-server`

### n8n won't load
```bash
# Check container status
docker-compose ps

# Check n8n logs
.\scripts\logs.ps1 n8n              # Windows
make logs-n8n                       # Linux/Mac

# Restart n8n
docker-compose restart n8n
```

### Port conflicts
If ports 5678 or 4840 are in use, edit `docker-compose.yml`:
```yaml
services:
  n8n:
    ports:
      - "5679:5678"  # Change host port to 5679
```

### Reset everything
```bash
# Stop and remove all data (WARNING: deletes workflows!)
docker-compose down -v

# Start fresh
.\scripts\start.ps1                 # Windows
make up                             # Linux/Mac
```

---

## 📁 Project Structure

```
n8n-OPCUA/
├── README.md                       ⭐ This file
├── docker-compose.yml              Docker orchestration
├── Dockerfile                      n8n + OPC UA plugin
├── env.example                     Configuration template
├── example-workflow.json           Sample workflow
├── Makefile                        Linux/Mac commands
│
├── scripts/                        All helper scripts
│   ├── setup.ps1, setup.bat        Initial setup
│   ├── start.ps1, start.bat        Start services
│   ├── stop.ps1                    Stop services
│   └── logs.ps1                    View logs
│
├── docs/                           Additional documentation
│   ├── QUICKSTART.md               5-minute guide
│   ├── GETTING-STARTED.md          Detailed walkthrough
│   ├── SUMMARY.md                  Project overview
│   └── ANSWERS.md                  Q&A
│
└── opcua-server/                   OPC UA simulation server
    ├── server.js                   Server implementation
    └── package.json                Dependencies
```

---

## 🔗 Resources

- **[n8n Documentation](https://docs.n8n.io/)** - Official n8n docs
- **[OPC UA Plugin](https://factoryiq.io/modules)** - @fiqch/n8n-nodes-fiq-opcua
- **[Node-OPCUA](https://node-opcua.github.io/)** - OPC UA library
- **[Docker Compose](https://docs.docker.com/compose/)** - Docker docs

---

## 📝 Connecting to Your Real OPC UA Servers

The simulation server is just for practice. To connect to your real OPC UA servers:

1. **Add new credential** in n8n with your server's endpoint
2. **Configure security** (mode, policy, certificates) as needed
3. **Use your node IDs** instead of the simulation ones
4. **Test connection** with a simple Read node first

Example for Siemens PLC:
```
Endpoint: opc.tcp://192.168.1.100:4840
Node ID: ns=3;s="DB1"."Temperature"
```

---

## ⚠️ Important Notes

- **Default setup is NOT secure** - Intended for local development only
- **OPC UA server has no authentication** - For testing purposes
- **Use authentication in production** - Enable n8n basic auth or SSO
- **Backup regularly** - Workflows and credentials are valuable
- **Test before production** - Always validate in dev environment first

---

## 🎉 You're Ready!

Everything is configured and ready to use:

1. Run `.\scripts\setup.ps1` (or `setup.bat`)
2. Run `.\scripts\start.ps1` (or `start.bat`)  
3. Open http://localhost:5678
4. Add OPC UA credential
5. Start building workflows!

**Need help?** Check the [docs/](docs/) folder for detailed guides.

**Questions?** See [docs/ANSWERS.md](docs/ANSWERS.md) for common questions.

---

**Happy Automating! 🚀**
