# 🚀 Getting Started with n8n and OPC UA

Welcome! This guide will help you get up and running in just a few minutes.

## 📋 What You'll Get

After completing this guide, you'll have:
- ✅ n8n workflow automation platform running
- ✅ OPC UA plugin installed and ready
- ✅ Simulation OPC UA server with test data
- ✅ Example workflow to import and experiment with

## 🎯 Three Simple Steps

### Step 1: Initial Setup (1 minute)

#### Option A: PowerShell (Recommended)
```powershell
# Open PowerShell in this directory and run:
.\setup.ps1
```

#### Option B: Command Prompt
```batch
REM Open Command Prompt in this directory and run:
setup.bat
```

This will:
- Create your `.env` configuration file
- Install OPC UA server dependencies

### Step 2: Start the Services (1 minute)

#### Option A: PowerShell
```powershell
.\start.ps1
```

#### Option B: Command Prompt
```batch
start.bat
```

The script will:
- ✓ Check Docker is running
- ✓ Build and start containers
- ✓ Open n8n in your browser

**Wait for**: The browser to open at http://localhost:5678

### Step 3: Configure n8n (2 minutes)

1. **Create your n8n account**
   - Enter your email and password
   - Click "Get Started"

2. **Add OPC UA Credential**
   - Click Settings (⚙️) → Credentials
   - Click "Add Credential"
   - Search for "OPC UA" and select it
   - Fill in:
     - **Name**: `OPC UA Simulation Server`
     - **Endpoint URL**: `opc.tcp://opcua-server:4840/UA/SimulationServer`
     - **Security Mode**: `None`
     - **Security Policy**: `None`
   - Click "Save"

3. **Import Example Workflow**
   - Click "Workflows" → "Add workflow" → "Import from file"
   - Select `example-workflow.json` from this folder
   - Click "Execute Workflow" to see it in action!

## 🎉 That's It!

You're now ready to experiment with OPC UA in n8n!

## 📊 What's Available to Test

Your OPC UA server has these pre-configured nodes:

### Read-Only Sensors
- 🌡️ **Temperature**: `ns=1;s=Simulation.Temperature` (oscillates 15-25°C)
- 📊 **Pressure**: `ns=1;s=Simulation.Pressure` (varies 101-103 kPa)
- 🔢 **Counter**: `ns=1;s=Simulation.Counter` (increments 0-999)
- 🏭 **Machine State**: `ns=1;s=Simulation.MachineState` (Idle/Running/Stopped/Error)

### Read/Write Controls
- 🔘 **Pump Status**: `ns=1;s=Simulation.PumpStatus` (Boolean on/off)
- 🎚️ **Setpoint**: `ns=1;s=Simulation.TemperatureSetpoint` (Target temperature)
- 📈 **Production**: `ns=1;s=Simulation.ProductionCount` (Items produced)

## 💡 Try These Quick Experiments

### Experiment 1: Read Sensor Data
1. Add a **Schedule Trigger** (every 5 seconds)
2. Add **OPC UA Read** node
3. Add node ID: `ns=1;s=Simulation.Temperature`
4. Execute and see live temperature!

### Experiment 2: Control the Pump
1. Add **OPC UA Write** node
2. Node ID: `ns=1;s=Simulation.PumpStatus`
3. Value: `true`
4. Data Type: `Boolean`
5. Execute to turn the pump ON!

### Experiment 3: Monitor and React
1. Schedule to read temperature every 10 seconds
2. Add **IF** node: temperature > 22
3. If true: write pump ON
4. If false: write pump OFF
5. Watch automated control in action!

## 🛠️ Useful Commands

| Action | PowerShell | Command Prompt |
|--------|-----------|----------------|
| **View Logs** | `.\logs.ps1` | `docker-compose logs -f` |
| **Stop Services** | `.\stop.ps1` | `docker-compose down` |
| **Restart** | `docker-compose restart` | `docker-compose restart` |
| **Check Status** | `docker-compose ps` | `docker-compose ps` |

## 📚 Next Steps

Once you're comfortable with the basics:

1. **Read the Full Guide**: Check out `README.md` for detailed documentation
2. **Explore n8n**: Visit https://docs.n8n.io/ for workflow ideas
3. **Customize**: Edit `docker-compose.yml` to add your own services
4. **Connect Real Devices**: Replace the simulation server with your actual OPC UA server

## ❓ Troubleshooting

### n8n won't start
```powershell
# Check Docker is running
docker info

# Check if ports are available
netstat -an | findstr "5678 4840"

# View detailed logs
.\logs.ps1
```

### Can't connect to OPC UA server
```powershell
# Check OPC UA server status
docker-compose logs opcua-server

# Restart the OPC UA server
docker-compose restart opcua-server
```

### Want to start fresh?
```powershell
# Stop and remove everything (including data)
docker-compose down -v

# Start again
.\start.ps1
```

## 🆘 Need Help?

- **Quick Start**: `QUICKSTART.md` - 5-minute guide
- **Full Documentation**: `README.md` - Complete reference
- **Project Structure**: `PROJECT-STRUCTURE.md` - File organization
- **n8n Documentation**: https://docs.n8n.io/
- **OPC UA Plugin**: https://factoryiq.io/modules

## 🎨 Example Use Cases

### Industrial IoT
- Monitor machine temperatures
- Track production counts
- Alert on anomalies
- Log to databases

### Building Automation
- Read HVAC data
- Control lighting
- Monitor energy usage
- Automate based on conditions

### Data Integration
- Pull OPC UA data
- Transform and enrich
- Push to cloud services
- Create dashboards

### Testing and Simulation
- Simulate factory scenarios
- Test control logic
- Validate workflows
- Training and demos

## 🌟 Tips for Success

1. **Start Simple**: Begin with reading a single tag
2. **Test Often**: Use "Execute Node" to test each step
3. **Check Logs**: Monitor OPC UA server logs to see connections
4. **Save Frequently**: Save your workflows as you build
5. **Experiment**: The simulation server is safe to experiment with!

## 🚀 Ready to Build?

```
    n8n (localhost:5678)
         ↕
    OPC UA Server (localhost:4840)
         ↕
    Your Amazing Workflows!
```

**Now go build something awesome! 🎉**

---

💡 **Pro Tip**: Keep `QUICKSTART.md` open in one window and n8n in another for easy reference!

