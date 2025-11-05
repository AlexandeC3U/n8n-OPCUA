const {
    OPCUAServer,
    Variant,
    DataType,
    StatusCodes,
    ServerState,
    UAObject
} = require("node-opcua");

async function main() {
    // Create OPC UA Server
    const server = new OPCUAServer({
        port: 4840,
        resourcePath: "/UA/SimulationServer",
        buildInfo: {
            productName: "n8n OPC UA Simulation Server",
            buildNumber: "1.0.0",
            buildDate: new Date()
        },
        serverInfo: {
            applicationName: { text: "n8n OPC UA Simulation Server" },
            applicationUri: "urn:NodeOPCUA-SimulationServer"
        }
    });

    await server.initialize();

    console.log("OPC UA Server initializing...");

    const addressSpace = server.engine.addressSpace;
    const namespace = addressSpace.getOwnNamespace();

    // Create a folder for simulation variables
    const simulationFolder = namespace.addFolder("ObjectsFolder", {
        browseName: "Simulation"
    });

    // Add various test variables
    
    // 1. Temperature sensor (changes over time)
    let temperature = 20.0;
    const temperatureVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "Temperature",
        displayName: "Temperature Sensor",
        description: "Simulated temperature in Celsius",
        dataType: "Double",
        value: {
            get: () => {
                // Simulate temperature fluctuation
                temperature = 20 + Math.sin(Date.now() / 10000) * 5;
                return new Variant({ 
                    dataType: DataType.Double, 
                    value: temperature 
                });
            }
        }
    });

    // 2. Pressure sensor
    let pressure = 101.325;
    const pressureVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "Pressure",
        displayName: "Pressure Sensor",
        description: "Simulated pressure in kPa",
        dataType: "Double",
        value: {
            get: () => {
                pressure = 101 + Math.random() * 2;
                return new Variant({ 
                    dataType: DataType.Double, 
                    value: pressure 
                });
            }
        }
    });

    // 3. Counter (increments)
    let counter = 0;
    const counterVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "Counter",
        displayName: "Counter",
        description: "Incrementing counter",
        dataType: "UInt32",
        value: {
            get: () => {
                counter = (counter + 1) % 1000;
                return new Variant({ 
                    dataType: DataType.UInt32, 
                    value: counter 
                });
            }
        }
    });

    // 4. Writable Boolean (pump status)
    let pumpStatus = false;
    const pumpVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "PumpStatus",
        displayName: "Pump Status",
        description: "Pump on/off status (writable)",
        dataType: "Boolean",
        accessLevel: "CurrentRead | CurrentWrite",
        userAccessLevel: "CurrentRead | CurrentWrite",
        value: {
            get: () => {
                return new Variant({ 
                    dataType: DataType.Boolean, 
                    value: pumpStatus 
                });
            },
            set: (variant) => {
                pumpStatus = variant.value;
                console.log(`Pump status changed to: ${pumpStatus}`);
                return StatusCodes.Good;
            }
        }
    });

    // 5. Writable Setpoint
    let setpoint = 25.0;
    const setpointVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "TemperatureSetpoint",
        displayName: "Temperature Setpoint",
        description: "Temperature setpoint (writable)",
        dataType: "Double",
        accessLevel: "CurrentRead | CurrentWrite",
        userAccessLevel: "CurrentRead | CurrentWrite",
        value: {
            get: () => {
                return new Variant({ 
                    dataType: DataType.Double, 
                    value: setpoint 
                });
            },
            set: (variant) => {
                setpoint = variant.value;
                console.log(`Temperature setpoint changed to: ${setpoint}`);
                return StatusCodes.Good;
            }
        }
    });

    // 6. String variable (machine state)
    const machineStates = ["Idle", "Running", "Stopped", "Error"];
    let machineStateIndex = 0;
    const machineStateVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "MachineState",
        displayName: "Machine State",
        description: "Current machine state",
        dataType: "String",
        value: {
            get: () => {
                // Change state every 10 seconds
                machineStateIndex = Math.floor(Date.now() / 10000) % machineStates.length;
                return new Variant({ 
                    dataType: DataType.String, 
                    value: machineStates[machineStateIndex] 
                });
            }
        }
    });

    // 7. Production counter
    let productionCount = 0;
    const productionVariable = namespace.addVariable({
        componentOf: simulationFolder,
        browseName: "ProductionCount",
        displayName: "Production Counter",
        description: "Total items produced",
        dataType: "UInt32",
        accessLevel: "CurrentRead | CurrentWrite",
        userAccessLevel: "CurrentRead | CurrentWrite",
        value: {
            get: () => {
                return new Variant({ 
                    dataType: DataType.UInt32, 
                    value: productionCount 
                });
            },
            set: (variant) => {
                productionCount = variant.value;
                console.log(`Production count set to: ${productionCount}`);
                return StatusCodes.Good;
            }
        }
    });

    // Auto-increment production count
    setInterval(() => {
        if (pumpStatus) {
            productionCount++;
        }
    }, 2000);

    // Start the server
    await server.start();

    const endpointUrl = server.endpoints[0].endpointDescriptions()[0].endpointUrl;
    console.log("=".repeat(60));
    console.log("OPC UA Simulation Server started successfully!");
    console.log("=".repeat(60));
    console.log(`Server endpoint: ${endpointUrl}`);
    console.log(`\nConnection details for n8n:`);
    console.log(`  - Endpoint URL: opc.tcp://opcua-server:4840/UA/SimulationServer`);
    console.log(`  - Security Mode: None`);
    console.log(`  - Security Policy: None`);
    console.log(`\nAvailable nodes:`);
    console.log(`  - ns=1;s=Simulation.Temperature (Double, Read-only)`);
    console.log(`  - ns=1;s=Simulation.Pressure (Double, Read-only)`);
    console.log(`  - ns=1;s=Simulation.Counter (UInt32, Read-only)`);
    console.log(`  - ns=1;s=Simulation.PumpStatus (Boolean, Read/Write)`);
    console.log(`  - ns=1;s=Simulation.TemperatureSetpoint (Double, Read/Write)`);
    console.log(`  - ns=1;s=Simulation.MachineState (String, Read-only)`);
    console.log(`  - ns=1;s=Simulation.ProductionCount (UInt32, Read/Write)`);
    console.log("=".repeat(60));

    // Graceful shutdown
    process.on("SIGINT", async () => {
        console.log("\nShutting down OPC UA server...");
        await server.shutdown();
        console.log("Server stopped.");
        process.exit(0);
    });
}

main().catch((err) => {
    console.error("Fatal error:", err);
    process.exit(1);
});

