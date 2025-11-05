# 📖 n8n OPC UA Project - Documentation Index

Welcome to your complete n8n + OPC UA Docker setup! This project gives you everything you need to start working with OPC UA in n8n.

## 🚀 Quick Navigation

### For First-Time Users

**Start here** → [GETTING-STARTED.md](GETTING-STARTED.md)
- Complete walkthrough in 3 simple steps
- Takes less than 5 minutes
- Includes example workflows

### Documentation by Purpose

#### 📘 I want to get running quickly
- **[GETTING-STARTED.md](GETTING-STARTED.md)** - Fastest way to get started (3 steps)
- **[QUICKSTART.md](QUICKSTART.md)** - 5-minute quick start guide with examples

#### 📗 I want comprehensive information
- **[README.md](README.md)** - Complete documentation with all details
- **[PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md)** - Understand the file organization

#### 📙 I want to understand how to use it
- **[example-workflow.json](example-workflow.json)** - Import this workflow into n8n
- View OPC UA server code: [opcua-server/server.js](opcua-server/server.js)

## 🎯 What This Project Provides

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  🌐 n8n Workflow Automation                     │
│     http://localhost:5678                       │
│     + OPC UA Plugin Pre-installed              │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  🏭 OPC UA Simulation Server                    │
│     opc.tcp://opcua-server:4840                │
│     + 7 Test Variables (sensors, controls)     │
│                                                 │
└─────────────────────────────────────────────────┘
```

## 📋 Project Files Overview

### Essential Files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Main Docker configuration |
| `Dockerfile` | Custom n8n image with OPC UA plugin |
| `env.example` | Environment configuration template |
| `.env` | Your environment settings (created on setup) |

### Documentation Files

| File | Best For |
|------|----------|
| **GETTING-STARTED.md** | Complete beginners - fastest path |
| **QUICKSTART.md** | Quick reference - 5 minute guide |
| **README.md** | Detailed reference - everything explained |
| **PROJECT-STRUCTURE.md** | Understanding file organization |
| **INDEX.md** | This file - navigation hub |

### Helper Scripts

#### Windows PowerShell
| Script | Purpose |
|--------|---------|
| `setup.ps1` | Initial setup (run once) |
| `start.ps1` | Start all services |
| `stop.ps1` | Stop all services |
| `logs.ps1` | View container logs |

#### Windows Batch (cmd)
| Script | Purpose |
|--------|---------|
| `setup.bat` | Initial setup (run once) |
| `start.bat` | Start all services |

#### Unix/Linux/Mac
| Command | Purpose |
|---------|---------|
| `make install` | Initial setup |
| `make up` | Start all services |
| `make down` | Stop all services |
| `make logs` | View container logs |
| `make help` | Show all commands |

### Example Files

| File | Purpose |
|------|---------|
| `example-workflow.json` | Sample n8n workflow to import |
| `opcua-server/server.js` | OPC UA server implementation |
| `docker-compose.override.yml.example` | Customization template |

## 🎓 Learning Path

### Path 1: Super Quick (5 minutes)
1. Run `setup.ps1` (or `setup.bat`)
2. Run `start.ps1` (or `start.bat`)
3. Open http://localhost:5678
4. Follow the on-screen prompts
5. Import `example-workflow.json`

### Path 2: Guided (15 minutes)
1. Read [GETTING-STARTED.md](GETTING-STARTED.md)
2. Follow the 3-step process
3. Try the experiments
4. Explore n8n interface

### Path 3: Comprehensive (30 minutes)
1. Read [GETTING-STARTED.md](GETTING-STARTED.md)
2. Read [QUICKSTART.md](QUICKSTART.md)
3. Skim [README.md](README.md)
4. Experiment with workflows
5. Try custom node IDs

### Path 4: Deep Dive (1 hour+)
1. Read all documentation
2. Study [opcua-server/server.js](opcua-server/server.js)
3. Read [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md)
4. Customize with override files
5. Create complex workflows

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│  Windows Host                                   │
│                                                 │
│  ┌───────────────────────────────────────────┐ │
│  │  Docker Network: n8n-opcua-network        │ │
│  │                                           │ │
│  │  ┌─────────────┐      ┌────────────────┐ │ │
│  │  │    n8n      │◄────►│  OPC UA        │ │ │
│  │  │             │      │  Server        │ │ │
│  │  │  Port: 5678 │      │  Port: 4840    │ │ │
│  │  │             │      │                │ │ │
│  │  │  + Plugin   │      │  + 7 Test Vars│ │ │
│  │  └──────┬──────┘      └────────┬───────┘ │ │
│  │         │                      │         │ │
│  └─────────┼──────────────────────┼─────────┘ │
│            │                      │           │
│       ┌────▼────┐            ┌───▼────┐      │
│       │ Volume  │            │ Local  │      │
│       │ n8n_data│            │ Files  │      │
│       └─────────┘            └────────┘      │
│                                               │
│  Browser → http://localhost:5678              │
└───────────────────────────────────────────────┘
```

## 🎯 Common Use Cases

### Use Case 1: Read Sensor Data
**Goal**: Monitor industrial sensors
- **Start with**: QUICKSTART.md
- **Example**: Temperature monitoring workflow
- **Node IDs**: `ns=1;s=Simulation.Temperature`

### Use Case 2: Control Equipment
**Goal**: Write values to control systems
- **Start with**: GETTING-STARTED.md → Experiment 2
- **Example**: Pump control
- **Node IDs**: `ns=1;s=Simulation.PumpStatus`

### Use Case 3: Automated Monitoring
**Goal**: Conditional logic and alerts
- **Start with**: example-workflow.json
- **Example**: Temperature-based pump control
- **Learn**: IF nodes, scheduling

### Use Case 4: Data Logging
**Goal**: Store OPC UA data
- **Start with**: README.md production section
- **Example**: Database integration
- **Learn**: Database nodes, scheduling

## 🔧 Customization Options

### Basic Customization
- Edit `.env` file for configuration
- Change ports in `docker-compose.yml`
- Adjust polling intervals in workflows

### Advanced Customization
- Copy `docker-compose.override.yml.example` to `docker-compose.override.yml`
- Add PostgreSQL for production
- Add Redis for queue mode
- Mount custom nodes
- Add additional services

## 📊 Available OPC UA Test Nodes

Your simulation server includes:

### Sensors (Read-Only)
| Node ID | Type | Description |
|---------|------|-------------|
| `ns=1;s=Simulation.Temperature` | Double | Oscillating 15-25°C |
| `ns=1;s=Simulation.Pressure` | Double | Random 101-103 kPa |
| `ns=1;s=Simulation.Counter` | UInt32 | Incrementing 0-999 |
| `ns=1;s=Simulation.MachineState` | String | Rotating states |

### Controls (Read/Write)
| Node ID | Type | Description |
|---------|------|-------------|
| `ns=1;s=Simulation.PumpStatus` | Boolean | Pump on/off |
| `ns=1;s=Simulation.TemperatureSetpoint` | Double | Target temperature |
| `ns=1;s=Simulation.ProductionCount` | UInt32 | Items produced |

## 🆘 Getting Help

### Quick Troubleshooting

**Problem**: Docker won't start
- **Solution**: Start Docker Desktop
- **Check**: `docker info` in terminal

**Problem**: Can't access n8n
- **Solution**: Check if running: `docker-compose ps`
- **Check logs**: `.\logs.ps1` or `docker-compose logs -f`

**Problem**: OPC UA connection fails
- **Solution**: Verify endpoint: `opc.tcp://opcua-server:4840/UA/SimulationServer`
- **Check logs**: `.\logs.ps1 opcua`

### Documentation Resources

- **Project Docs**: See files listed above
- **n8n Official**: https://docs.n8n.io/
- **OPC UA Plugin**: https://factoryiq.io/modules
- **Docker**: https://docs.docker.com/

## 🎓 Recommended Reading Order

1. **First Time Setup**
   - [GETTING-STARTED.md](GETTING-STARTED.md)
   - Import `example-workflow.json`

2. **Understanding the System**
   - [QUICKSTART.md](QUICKSTART.md)
   - [PROJECT-STRUCTURE.md](PROJECT-STRUCTURE.md)

3. **Deep Knowledge**
   - [README.md](README.md)
   - [opcua-server/server.js](opcua-server/server.js)

4. **Customization**
   - `docker-compose.yml`
   - `docker-compose.override.yml.example`
   - `.env` and `env.example`

## 🚀 Next Steps

### Immediate (Now)
1. Run `setup.ps1` or `setup.bat`
2. Run `start.ps1` or `start.bat`
3. Open http://localhost:5678

### Short Term (Today)
1. Complete [GETTING-STARTED.md](GETTING-STARTED.md)
2. Import and run example workflow
3. Experiment with reading/writing tags

### Medium Term (This Week)
1. Read [README.md](README.md) fully
2. Create custom workflows
3. Connect to your own OPC UA servers

### Long Term (Ongoing)
1. Deploy to production (see README.md)
2. Integrate with other systems
3. Share and collaborate

## 📝 Quick Reference Card

```
┌─────────────────────────────────────────────┐
│  QUICK REFERENCE                            │
├─────────────────────────────────────────────┤
│  Setup:     .\setup.ps1                     │
│  Start:     .\start.ps1                     │
│  Stop:      .\stop.ps1                      │
│  Logs:      .\logs.ps1                      │
│                                             │
│  n8n:       http://localhost:5678           │
│  OPC UA:    opcua-server:4840               │
│                                             │
│  Test Node: ns=1;s=Simulation.Temperature   │
└─────────────────────────────────────────────┘
```

## 🎉 You're Ready!

Everything you need is here. Pick your starting point above and dive in!

**Happy automating! 🚀**

---

*Last Updated: November 2024*
*Version: 1.0*

