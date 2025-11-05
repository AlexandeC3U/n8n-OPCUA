# Quick Start - n8n OPC UA (5 minutes)

## Step 1: Start Services (1 minute)

### Windows PowerShell
```powershell
.\scripts\setup.ps1    # First time only
.\scripts\start.ps1
```

### Windows Batch
```batch
scripts\setup.bat      # First time only
scripts\start.bat
```

### Linux/Mac
```bash
make install           # First time only
make up
```

Browser opens to http://localhost:5678 automatically.

## Step 2: Configure n8n (2 minutes)

1. **Create Account** (first time)
   - Enter email and password

2. **Add OPC UA Credential**
   - Settings (⚙️) → Credentials → Add Credential
   - Search "OPC UA" and select
   - Fill in:
     - **Endpoint URL**: `opc.tcp://opcua-server:4840/UA/SimulationServer`
     - **Security Mode**: `None`
     - **Security Policy**: `None`
   - Save

## Step 3: Create Workflow (2 minutes)

### Option A: Import Example
1. Workflows → Add workflow → Import from file
2. Select `example-workflow.json`
3. Execute Workflow

### Option B: Create New
1. Add **Schedule Trigger** (every 10 seconds)
2. Add **OPC UA** node
   - Operation: Read
   - Node IDs: `ns=1;s=Simulation.Temperature`
3. Execute Workflow

## Test Variables

### Read-Only
```
ns=1;s=Simulation.Temperature       # Temperature sensor
ns=1;s=Simulation.Pressure          # Pressure sensor
ns=1;s=Simulation.Counter           # Incrementing counter
ns=1;s=Simulation.MachineState      # Machine state
```

### Read/Write
```
ns=1;s=Simulation.PumpStatus        # Boolean pump control
ns=1;s=Simulation.TemperatureSetpoint
ns=1;s=Simulation.ProductionCount
```

## Quick Commands

### Windows
```powershell
.\scripts\start.ps1              # Start
.\scripts\stop.ps1               # Stop
.\scripts\logs.ps1               # Logs
```

### Linux/Mac
```bash
make up                          # Start
make down                        # Stop
make logs                        # Logs
```

## Example Workflows

### Read Temperature
```
Schedule Trigger (5s)
  ↓
OPC UA Read (Temperature)
```

### Control Pump
```
Manual Trigger
  ↓
OPC UA Write (PumpStatus = true)
```

### Automated Control
```
Schedule Trigger (10s)
  ↓
OPC UA Read (Temperature)
  ↓
IF temp > 22
  ├─ True → Write Pump ON
  └─ False → Write Pump OFF
```

## Troubleshooting

### Can't connect?
- Use `opcua-server` not `localhost` in n8n
- Check: `.\scripts\logs.ps1 opcua`

### Reset everything
```bash
docker-compose down -v
.\scripts\start.ps1
```

## Next Steps

- Read **[README.md](README.md)** for full details
- Check **[START-HERE.md](START-HERE.md)** for overview
- Connect to your real OPC UA servers!

---

**Need more details?** See [README.md](README.md)
