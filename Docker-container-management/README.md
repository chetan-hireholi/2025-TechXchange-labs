# Terraform + Ansible: Local Docker Containers Management

This project demonstrates Infrastructure as Code (IaC) with Terraform for provisioning and Ansible for configuration management of two local Docker containers:

- **Nginx web server** exposed on `http://localhost:8080`
- **Redis server** exposed on `localhost:6379`

## Architecture

1. **Terraform**: Creates and manages Docker infrastructure (network, images, containers)
2. **Ansible**: Configures and manages the running containers

## Prerequisites

### Core Requirements
- Docker installed and running
  - macOS/Windows: Docker Desktop
  - Linux: Docker Engine
- Internet access to pull images: `nginx:stable`, `redis:7`

### Terraform
- Terraform >= 1.4.0

### Ansible
- Ansible installed (`pip install ansible`)
- Python Docker SDK (`pip install docker`)

## Project Structure

### Terraform Files
- `versions.tf`: Terraform and provider requirements
- `main.tf`: Docker provider, network, images, and containers
- `outputs.tf`: Helpful outputs (URLs/connection strings)

### Ansible Files
- `ansible.cfg`: Ansible configuration with Docker connection settings
- `inventory.ini`: Defines containers as Ansible hosts
- `playbook.yml`: Main playbook for container management
- `requirements.txt`: Python dependencies

## Complete Workflow

### Phase 1: Infrastructure Provisioning (Terraform)

1. **Initialize providers**:
```bash
terraform init
```

2. **Review the plan**:
```bash
terraform plan
```

3. **Create infrastructure**:
```bash
terraform apply -auto-approve
```

4. **Verify basic services**:
- Web: open `http://localhost:8080` in a browser
- Redis CLI (if installed):
```bash
redis-cli -h 127.0.0.1 -p 6379 PING
```

### Phase 2: Configuration Management (Ansible)

5. **Run Ansible playbook**:
```bash
ansible-playbook -i inventory.ini playbook.yml
```

6. **Test enhanced services**:
- **Nginx**: Visit `http://localhost:8080/health` for health check
- **Redis**: `redis-cli -h localhost -p 6379 PING`

### Phase 3: Management & Monitoring

7. **Target specific services**:
```bash
# Only web containers
ansible-playbook playbook.yml --limit web

# Only redis containers  
ansible-playbook playbook.yml --limit redis
```

8. **Check container status**:
```bash
docker ps
docker logs tx-web --follow
docker logs tx-redis --follow
```

### Phase 4: Cleanup

9. **Destroy infrastructure**:
```bash
terraform destroy -auto-approve
```

## What Gets Created

### Infrastructure (Terraform)
- Docker network `tx-net`
- Container `tx-web` from `nginx:stable` bound to port 8080
- Container `tx-redis` from `redis:7` bound to port 6379

### Configuration (Ansible)
- **Nginx**: Custom config with `/health` endpoint
- **Redis**: Memory limits (128MB), persistence settings, LRU eviction policy
- **Health Monitoring**: Service availability checks

## Platform Support

Works on macOS, Linux, and Windows:
- **macOS/Linux**: Docker Engine
- **Windows**: Docker Desktop or WSL2 + Docker Engine

### Windows Notes
- Use PowerShell, Command Prompt, or Windows Terminal
- Ensure Docker Desktop is running
- With WSL2, run commands inside your Linux distro with Docker integration enabled

## Troubleshooting

### Common Issues
- **Images fail to pull**: Check network/proxy and run `docker login` if needed
- **Port conflicts**: Change external ports in `main.tf` under the `ports` blocks and re-apply
- **Ansible connection issues**: Ensure containers are running before running Ansible

### Debug Commands
```bash
# Check container status
docker ps

# View logs
docker logs tx-web --follow
docker logs tx-redis --follow

# Test connectivity
curl http://localhost:8080/health
redis-cli -h localhost -p 6379 PING
```

## Key Benefits

- **Separation of Concerns**: Terraform handles infrastructure, Ansible handles configuration
- **Idempotent**: Safe to run multiple times
- **Cross-Platform**: Works on Windows, macOS, and Linux
- **Minimal**: Only 2 containers, easy to understand and extend
- **Production-Ready**: Includes health checks, monitoring, and proper configuration
