# AWS EC2 Core Concepts

These are fundamental components of Amazon EC2 in Amazon Web Services (AWS).

---

## 1. AMI (Amazon Machine Image)

An **AMI** is a pre-configured template used to launch an virtual servers (EC2 instances).

### It contains:
- Operating System (Linux, Windows, etc.)
- Pre-installed software
- Application server configurations
- System settings

### Types of AMIs:
- **Public AMI** – Provided by AWS
- **Private AMI** – Created by user
- **Marketplace AMI** – Paid images with licensed software

### Example:
Instead of manually installing Ubuntu + Docker, use an AMI that already includes them.

---

## 2. Instance Types

An **instance type** defines the hardware configuration of your EC2 instance.

### It includes:
- CPU (vCPU)
- Memory (RAM)
- Storage
- Network performance

### Categories:
- **General Purpose** (t2, t3)
- **Compute Optimized** (c5)
- **Memory Optimized** (r5)
- **Storage Optimized** (i3)

### Example:
- Small app → `t2.micro`
- High CPU task → `c5.large`
- Database → `r5.large`

---

## 3. Key Pairs

A **key pair** is used for secure login to EC2 instances.

### Components:
- **Public Key** → Stored in instance
- **Private Key (.pem file)** → Stored with user

### Example:
```bash
ssh -i mykey.pem ubuntu@<public-ip>
