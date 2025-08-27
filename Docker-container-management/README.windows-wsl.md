## Terraform + Ansible on Windows (PowerShell + WSL)

This guide explains how to run this project on Windows with:
- Terraform installed on Windows (PowerShell)
- Ansible installed inside WSL2 (Ubuntu or another Linux distro)
- Docker Desktop for Windows with WSL integration

The workflow is: provision Docker containers with Terraform from PowerShell, then configure them with Ansible from WSL.

### What this project deploys
- Docker network `tx-net`
- Nginx container `tx-web` → http://localhost:8080
- Redis container `tx-redis` → redis://localhost:6379

### Repo location
You can keep the repo on your Windows filesystem (e.g., `C:\...\2025-TechXchange-labs\Docker-container-management`).
- PowerShell will run Terraform from this folder.
- WSL will access the same folder via `/mnt/c/.../2025-TechXchange-labs/Docker-container-management`.

Tip: Avoid placing the repo under a path that syncs while running (e.g., cloud-sync). If you do, ensure sync is paused during `terraform apply/destroy`.

---

## Prerequisites

### Windows (PowerShell)
- Docker Desktop installed and running
- Terraform installed (e.g., via Chocolatey)
- Optional: Redis CLI for quick tests (e.g., `choco install redis-64`)

### WSL (inside your Linux distro)
- Ansible installed
- Python and Docker SDK for Ansible’s docker connection

Install in WSL:
```bash
# In WSL terminal (Ubuntu)
sudo apt update
sudo apt install -y python3 python3-pip
pip3 install --user ansible docker
# Or use project-pinned versions
# pip3 install --user -r /mnt/c/Path/To/2025-TechXchange-labs/Docker-container-management/requirements.txt
```

### Docker Desktop WSL Integration
- In Docker Desktop → Settings → Resources → WSL Integration
  - Enable integration for the WSL distro where Ansible is installed
- Verify Docker CLI works in both environments:
  - PowerShell: `docker version`
  - WSL: `docker version`

---

## Part A: Provision infrastructure with Terraform (PowerShell)

1) Open PowerShell and go to the project directory:
```powershell
cd "C:\Users\<you>\...\2025-TechXchange-labs\Docker-container-management"
```

2) Initialize Terraform:
```powershell
terraform init
```

3) Review the plan:
```powershell
terraform plan
```

4) Apply the changes:
```powershell
terraform apply -auto-approve
```

5) Check containers:
```powershell
docker ps
docker logs tx-web --follow  # Ctrl+C to stop following
docker logs tx-redis --follow
```

Outputs (also in `outputs.tf`):
- Web URL: `http://localhost:8080`
- Redis: `redis://localhost:6379`

---

## Part B: Configure and validate with Ansible (WSL)

1) Open your WSL terminal and go to the same folder via the mounted Windows path:
```bash
cd /mnt/c/Users/<you>/.../2025-TechXchange-labs/Docker-container-management
```

2) (If not already) install Python deps for Ansible’s docker connection:
```bash
pip3 install --user -r requirements.txt  # installs ansible and docker SDK if needed
```

3) Ensure Docker is reachable from WSL:
```bash
docker ps  # should list tx-web and tx-redis
```

4) Run the playbook:
```bash
ansible-playbook playbook.yml
```

- Inventory: `inventory.ini` groups `web` and `redis`
- Connection: `ansible_connection=docker` (Ansible connects directly to containers)

5) Validate services:
```bash
# Nginx health
curl -i http://localhost:8080/health

# Redis health (requires redis-cli on Windows or in WSL if installed)
redis-cli -h 127.0.0.1 -p 6379 PING
```

---

## Targeted runs
Run only one group:
```bash
# In WSL
ansible-playbook playbook.yml --limit web
ansible-playbook playbook.yml --limit redis
```

---

## Tear down (PowerShell)
When done, destroy the infrastructure from PowerShell:
```powershell
cd "C:\Users\<you>\...\2025-TechXchange-labs\Docker-container-management"
terraform destroy -auto-approve
```

---

## Troubleshooting
- Docker not reachable in WSL:
  - Enable WSL integration in Docker Desktop for your distro
  - Restart Docker Desktop and your WSL distro: `wsl --shutdown`
- Port already in use (8080 or 6379):
  - Change `external` ports in `main.tf`, then re-run `terraform apply`
- Ansible connection errors:
  - Ensure containers exist (`docker ps` in WSL)
  - Confirm `pip3 show docker` and `pip3 show ansible` in WSL
- File path issues:
  - In PowerShell, use Windows paths; in WSL, use `/mnt/c/...` paths

---

## Command quick reference

PowerShell (Terraform):
```powershell
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
```

WSL (Ansible):
```bash
pip3 install --user -r requirements.txt
ansible-playbook playbook.yml
ansible-playbook playbook.yml --limit web
ansible-playbook playbook.yml --limit redis
```

Docker (either environment):
```bash
docker ps
docker logs tx-web --follow
docker logs tx-redis --follow
```

---

## What runs where?
- Terraform: Windows PowerShell
- Ansible: WSL
- Docker Engine: Docker Desktop (shared with WSL via integration)

This separation lets you use each tool where it’s best supported while working against the same project files and Docker engine.
