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
- **General Purpose** (t2, t3):
	Web servers, small databases, development/test environments, CI/CD pipelines.
- **Compute Optimized** (c5):
	High-performance web servers, scientific modeling, batch processing, gaming servers, machine learning inference.
- **Memory Optimized** (r5):
	 High-performance relational databases (SQL/NoSQL), in-memory caches (Redis/Memcached), big data analytics (Spark/Hadoop).
- **Storage Optimized** (i3):
	 NoSQL databases (Cassandra/MongoDB), data warehousing, high-throughput distributed file systems, log processing.

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

---

## 4. Security Groups

A security group acts as a virtual firewall for EC2.

###Controls:
- **Inbound traffic**
- **Outbound traffic**
- **Common Rules:
- **SSH → Port 22
- **HTTP → Port 80**
- **HTTPS → Port 443**

### Example:

If port 22 is not allowed → SSH access will fail

---

## 5. Elastic IP (EIP)

An Elastic IP is a static public IP address.

## Key Points:
- **Default public IP changes on restart**
- **Elastic IP remains constant**

###Use Cases:
- **Hosting websites**
- **DNS mapping**
- **Avoid downtime**

Note:

AWS charges for unused Elastic IPs

---

##User Data

User Data is a script that runs automatically during instance launch.

###Use Cases:
- **Install software**
- **Configure services**
- **Automate setup**

###Example:
```bash
#!/bin/bash
apt update
apt install -y apache2
systemctl start apache2

---
