# 🐳 Docker Basics on WSL Ubuntu

This document contains the basic Docker operations performed on Ubuntu (WSL), including running containers, accessing them, and troubleshooting common mistakes.

---
## What is Docker

- Docker is a tool that allows developers to "package" an application and everything it needs to run (like libraries, settings, and dependencies) into a single unit called a container.
- The most famous problem Docker solves is the "it works on my machine" headache. By using Docker, you ensure that if the app works on your laptop, it will work exactly the same on your teammate's computer, a testing server, or a cloud platform like AWS or Azure.


### 📚 Key Concepts to Know

| Term        | What it is |
|------------|-----------|
| Dockerfile | A text file with instructions on how to build your environment. |
| Image      | A blueprint or snapshot created from your Dockerfile. It is a read-only file. |
| Container  | A live, running instance of an image where your code actually executes. |
| Docker Hub | An online library to download pre-built images like databases (MySQL, MongoDB) or web servers (Nginx). |


### Nginx
- In a Docker environment, Nginx acts as the high-performance traffic controller for your containerized applications. 
- While Nginx is a web server at its core, it is most commonly used in Docker to manage how users and other containers access your services.

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
