# Learning Prompts for Docker Container Management Project

This file contains comprehensive learning prompts to help you understand and execute the Terraform + Ansible Docker container management project.

## **Foundation Learning Prompts**

### **1. Understanding the Project Architecture**
- "Explain the difference between Infrastructure as Code (IaC) and Configuration Management in this project"
- "How does Terraform handle infrastructure provisioning while Ansible manages configuration?"
- "What is the purpose of the Docker network 'tx-net' and how does it connect the containers?"

### **2. Docker Fundamentals**
- "What are Docker images vs containers, and how does this project use both?"
- "Explain the port mapping in the Terraform configuration (internal vs external ports)"
- "How does the Docker network enable communication between the Nginx and Redis containers?"

## **Terraform Learning Prompts**

### **3. Terraform Basics**
- "Walk me through the `main.tf` file and explain each resource block"
- "What does `keep_locally = true` do for Docker images?"
- "How does Terraform determine the order of resource creation?"

### **4. Terraform Workflow**
- "What happens when I run `terraform init`?"
- "Explain the difference between `terraform plan` and `terraform apply`"
- "How can I safely destroy the infrastructure with `terraform destroy`?"

## **Ansible Learning Prompts**

### **5. Ansible Configuration**
- "How does the `inventory.ini` file define the containers as Ansible hosts?"
- "Explain the `ansible.cfg` file and its Docker connection settings"
- "What does `gather_facts: false` mean and why is it used here?"

### **6. Playbook Understanding**
- "Break down the `playbook.yml` file into its logical sections"
- "How does Ansible target specific container groups (web vs redis)?"
- "What is the purpose of the health check tasks at the end?"

## **Practical Execution Prompts**

### **7. Step-by-Step Execution**
- "Guide me through running this project from start to finish"
- "What should I check after running `terraform apply` to ensure success?"
- "How do I verify that both Nginx and Redis are working correctly?"

### **8. Troubleshooting**
- "What are common issues I might encounter and how do I resolve them?"
- "How can I check container logs and status?"
- "What do I do if ports 8080 or 6379 are already in use?"

## **Advanced Learning Prompts**

### **9. Customization and Extension**
- "How could I add a third container (like a database) to this setup?"
- "What modifications would I need to make to change the external ports?"
- "How could I add environment variables or volume mounts to the containers?"

### **10. Production Considerations**
- "What security considerations should I keep in mind when running this in production?"
- "How could I add monitoring and alerting to this setup?"
- "What backup and recovery strategies would be appropriate?"

## **Hands-On Practice Prompts**

### **11. Interactive Learning**
- "Let me try to modify the Nginx configuration - what happens if I change the health check endpoint?"
- "Can you help me add a custom HTML page to the Nginx container?"
- "What happens if I try to run the Ansible playbook before the containers are created?"

### **12. Debugging Practice**
- "Walk me through debugging a scenario where the Redis container won't start"
- "How would I troubleshoot network connectivity issues between containers?"
- "What commands should I run to diagnose Ansible connection problems?"

## **Recommended Learning Sequence**

1. **Start with**: Foundation prompts to understand the overall architecture
2. **Then**: Terraform prompts to learn infrastructure provisioning
3. **Next**: Ansible prompts to understand configuration management
4. **Finally**: Practical execution prompts to actually run the project
5. **Advanced**: Customization and production considerations

## **Quick Start Commands to Practice**

```bash
# Navigate to the project directory
cd Docker-container-management

# Initialize Terraform
terraform init

# Plan the infrastructure
terraform plan

# Apply the infrastructure
terraform apply -auto-approve

# Run Ansible configuration
ansible-playbook playbook.yml

# Test the services
curl http://localhost:8080/health
redis-cli -h localhost -p 6379 PING

# Clean up
terraform destroy -auto-approve
```

## **How to Use These Prompts**

1. **Copy and paste** any prompt into your AI assistant or ChatGPT
2. **Ask follow-up questions** based on the responses you receive
3. **Practice hands-on** by running the commands while learning
4. **Take notes** on concepts you want to explore further
5. **Experiment** with modifications to understand how changes affect the system

## **Learning Tips**

- **Start simple**: Begin with foundation prompts before diving into complex topics
- **Practice regularly**: Run the commands multiple times to build muscle memory
- **Break things**: Intentionally make mistakes to learn troubleshooting
- **Document your journey**: Keep notes on what you learn and questions you have
- **Build incrementally**: Add one new concept at a time rather than trying to learn everything at once

---

*Use these prompts to guide your learning journey through Infrastructure as Code, Docker containerization, and automated configuration management!*
