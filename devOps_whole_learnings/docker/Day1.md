# 🐳 Docker Basics on WSL Ubuntu

This document contains the basic Docker operations performed on Ubuntu (WSL), including running containers, accessing them, and troubleshooting common mistakes.

---

## 📌 1. Verify Docker Installation

```bash
docker --version
```
## 📌 2. Run Hello World Container


```bash
docker run hello-world
```
## 📌 3. Pull Nginx Image


```bash
docker pull nginx
```
## 📌 4. Run Nginx Container on Port 8080


```bash
docker run -d -p 8080:80 nginx
```
- -d → Run in background
- -p 8080:80 → Map localhost:8080 to container port 80

✔ Access in browser:

```bash
http://localhost:8080
```
## 📌 5. List Running Containers

```bash
docker ps
```
## 📌 6. Exec into Running Container

```bash
docker exec -it <container_Id> bash
```
## 📌 7. View Container logs

```bash
docker logs -f <container_Id>
```
- -f → Follow logs in real-time

### ⚠️ Common Mistake Faced

While executing commands, the following prompt was observed:
```bash
root@bc6bda76635e:/#
```
This indicates that the shell is inside a Docker container, not the WSL Ubuntu host.

### ❌ Issues Encountered

```bash
sudo: command not found
wsl: command not found
```

- The correct flow is:
```bash
Windows (PowerShell)
   ↓
wsl --shutdown

WSL Ubuntu
   ↓
docker commands

Docker Container
   ↓
app-level commands only
```
### ✅ Correct Approach
Exit container
```bash 
exit
```
Run command on WSL Host

```bash
docker -f <conainer_Id>
```
## 📌 8. Fix and check docker permissions (Optional)

```bash
sudo usermod -aG docker $USER
```
Check if a user is added to docker group using
```bash
groups 
id john_doe(name of the user)
grep '^docker' /etc/group
getent group docker
```

Then restart WSL from Windows PowerShell:
```bash
wsl --shutdown
```
