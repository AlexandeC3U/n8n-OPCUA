.PHONY: help build up down restart logs logs-n8n logs-opcua ps clean backup restore install

# Default target
help:
	@echo "n8n OPC UA Docker Management"
	@echo "============================"
	@echo ""
	@echo "Available commands:"
	@echo "  make build       - Build all containers"
	@echo "  make up          - Start all services"
	@echo "  make down        - Stop all services"
	@echo "  make restart     - Restart all services"
	@echo "  make logs        - View logs from all services"
	@echo "  make logs-n8n    - View n8n logs"
	@echo "  make logs-opcua  - View OPC UA server logs"
	@echo "  make ps          - Show running containers"
	@echo "  make clean       - Stop and remove all containers and volumes"
	@echo "  make backup      - Backup n8n data"
	@echo "  make restore     - Restore n8n data from backup"
	@echo "  make install     - Install OPC UA server dependencies"
	@echo ""

# Build containers
build:
	docker-compose build

# Start services
up:
	@echo "Installing OPC UA server dependencies..."
	@cd opcua-server && npm install --silent 2>/dev/null || true
	@echo "Starting services..."
	docker-compose up -d
	@echo ""
	@echo "Services started successfully!"
	@echo "n8n: http://localhost:5678"
	@echo "OPC UA Server: opc.tcp://opcua-server:4840/UA/SimulationServer"

# Stop services
down:
	docker-compose down

# Restart services
restart:
	docker-compose restart

# View all logs
logs:
	docker-compose logs -f

# View n8n logs
logs-n8n:
	docker-compose logs -f n8n

# View OPC UA server logs
logs-opcua:
	docker-compose logs -f opcua-server

# Show container status
ps:
	docker-compose ps

# Clean everything
clean:
	@echo "WARNING: This will remove all containers and volumes!"
	@echo "Press Ctrl+C to cancel or Enter to continue..."
	@read line
	docker-compose down -v
	@echo "Cleanup complete!"

# Backup n8n data
backup:
	@mkdir -p backups
	docker run --rm -v n8n_opcua_data:/data -v $$(pwd)/backups:/backup alpine tar czf /backup/n8n-backup-$$(date +%Y%m%d-%H%M%S).tar.gz -C /data .
	@echo "Backup created in ./backups/"

# Restore n8n data (use BACKUP_FILE variable)
restore:
	@if [ -z "$(BACKUP_FILE)" ]; then \
		echo "Error: BACKUP_FILE not specified"; \
		echo "Usage: make restore BACKUP_FILE=./backups/n8n-backup-20241105-120000.tar.gz"; \
		exit 1; \
	fi
	docker run --rm -v n8n_opcua_data:/data -v $$(pwd)/backups:/backup alpine tar xzf /backup/$$(basename $(BACKUP_FILE)) -C /data
	@echo "Restore complete!"

# Install OPC UA server dependencies
install:
	cd opcua-server && npm install
	@echo "Dependencies installed!"

