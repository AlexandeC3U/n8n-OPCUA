# 👋 START HERE

> Complete n8n + OPC UA environment ready to use!

## 🚀 Get Started (3 Commands)

### Windows PowerShell
```powershell
.\scripts\setup.ps1    # Creates .env config
.\scripts\start.ps1    # Starts everything + opens browser
```

### Windows Command Prompt
```batch
.\scripts\setup.bat    # Creates .env config
.\scripts\start.bat    # Starts everything + opens browser
```

### Linux/Mac
```bash
make install           # Setup
make up                # Start
```

## ✅ What You Get

- **n8n UI**: http://localhost:5678 (with OPC UA plugin installed)
- **OPC UA Server**: `opc.tcp://opcua-server:4840/UA/SimulationServer`
- **7 Test Variables**: Temperature, Pressure, Pump Control, etc.
- **Example Workflow**: `example-workflow.json` (import into n8n)

## 🎯 First Workflow

1. **Open**: http://localhost:5678
2. **Create account** (first time)
3. **Add OPC UA Credential**:
   - Settings → Credentials → Add Credential → OPC UA
   - Endpoint: `opc.tcp://opcua-server:4840/UA/SimulationServer`
   - Security Mode: `None`
   - Security Policy: `None`
4. **Import**: Workflows → Import → Select `example-workflow.json`
5. **Execute**: Click "Execute Workflow" 🎉

## 📊 Test Nodes Available

```
# Read-only sensors
ns=1;s=Simulation.Temperature       # 15-25°C
ns=1;s=Simulation.Pressure          # 101-103 kPa
ns=1;s=Simulation.Counter           # 0-999
ns=1;s=Simulation.MachineState      # Idle/Running/etc

# Read/Write controls
ns=1;s=Simulation.PumpStatus        # Boolean
ns=1;s=Simulation.TemperatureSetpoint
ns=1;s=Simulation.ProductionCount
```

## 🛠️ Daily Commands

| Action | Windows | Linux/Mac |
|--------|---------|-----------|
| Start | `.\scripts\start.ps1` | `make up` |
| Stop | `.\scripts\stop.ps1` | `make down` |
| Logs | `.\scripts\logs.ps1` | `make logs` |
| Status | `docker-compose ps` | `make ps` |

## 📚 Documentation

- **[README.md](README.md)** - Main documentation
- **[QUICKSTART.md](QUICKSTART.md)** - 5-minute guide
- **[docs/](docs/)** - Additional guides

## 🔑 Key Points

- ✅ **OPC UA plugin** is pre-installed - connect to ANY OPC UA server
- ✅ Use `opcua-server` hostname (NOT `localhost`) in n8n
- ✅ Data persists in Docker volumes
- ✅ Simulation server is for testing only

## 🆘 Problems?

```bash
# Check logs
.\scripts\logs.ps1           # Windows
make logs                    # Linux/Mac

# Reset everything
docker-compose down -v
.\scripts\start.ps1          # Windows
make up                      # Linux/Mac
```

---

**Ready?** Run `.\scripts\setup.ps1` then `.\scripts\start.ps1` and start automating! 🚀
