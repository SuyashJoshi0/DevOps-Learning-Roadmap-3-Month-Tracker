# Kubernetes Fundamentals
## Kubernetes, Minikube, Cluster Lifecycle & Amazon EKS

---

# Table of Contents

1. Introduction to Kubernetes
2. Why Kubernetes?
3. Kubernetes Architecture
4. Control Plane Components
5. Worker Node Components
6. What is a Kubernetes Cluster?
7. What is Minikube?
8. Kubernetes Cluster Lifecycle
9. Minikube Commands
10. Kubernetes vs Amazon EKS
11. Minikube vs Amazon EKS
12. Local Development Workflow
13. Production Workflow
14. Interview Questions

---

# 1. Introduction to Kubernetes

## What is Kubernetes?

Kubernetes (commonly abbreviated as **K8s**) is an open-source container orchestration platform used to:

- Deploy applications
- Manage containers
- Scale applications automatically
- Perform rolling updates
- Recover failed containers
- Load balance traffic
- Manage application networking

Originally developed by Google and now maintained by the Cloud Native Computing Foundation (CNCF).

---

# Why was Kubernetes created?

Before Kubernetes

```
Application
      |
Docker Container
      |
Virtual Machine
      |
Server
```

Problems

- Difficult to manage hundreds of containers
- No automatic recovery
- Manual scaling
- Manual deployments
- Downtime during updates

Kubernetes solves these problems automatically.

---

# Kubernetes Architecture

```
                    Kubernetes Cluster

          +----------------------------------+
          |          Control Plane           |
          |----------------------------------|
          | API Server                       |
          | Scheduler                        |
          | Controller Manager               |
          | etcd                             |
          +---------------+------------------+
                          |
          -----------------------------------
                 Kubernetes Network
          -----------------------------------
              |                     |
              |                     |
     +----------------+     +----------------+
     | Worker Node 1  |     | Worker Node 2  |
     |----------------|     |----------------|
     | kubelet        |     | kubelet        |
     | kube-proxy     |     | kube-proxy     |
     | Container RT   |     | Container RT   |
     | nginx Pod      |     | redis Pod      |
     +----------------+     +----------------+
```

---

# Control Plane Components

## API Server

- Entry point of Kubernetes.
- All kubectl commands communicate with the API Server.

Example

```
kubectl get pods
        │
        ▼
   API Server
```

---

## etcd

- Distributed key-value database.
- Stores entire cluster state.

Stores

- Pods
- Deployments
- Services
- Secrets
- ConfigMaps
- Nodes

---

## Scheduler

Responsible for selecting which node should run a Pod.

Decision based on

- CPU
- Memory
- Labels
- Affinity
- Taints
- Resource availability

---

## Controller Manager

Continuously checks whether the cluster is in the desired state.

Example

Desired Pods = 3

Actual Pods = 2

Controller automatically creates the missing Pod.

---

# Worker Node Components

## kubelet

Runs on every node.

Responsibilities

- Talks to API Server
- Starts Pods
- Monitors Pods
- Reports node health

---

## kube-proxy

Handles

- Networking
- Service discovery
- Load balancing

---

## Container Runtime

Responsible for running containers.

Examples

- containerd
- CRI-O
- Docker (older versions)

---

# What is a Kubernetes Cluster?

A Kubernetes cluster consists of

```
Control Plane
        +
Worker Node(s)
```

Example

```
Kubernetes Cluster

Control Plane
      │
--------------------
│         │         │
Node1    Node2    Node3
```

---

# What is Minikube?

Minikube is **not Kubernetes itself**.

It is a tool that creates a local Kubernetes cluster for learning and development.

Think of it as

```
Laptop
   │
Minikube
   │
Single-node Kubernetes Cluster
```

Characteristics

- Single node
- Runs locally
- Free
- Ideal for learning

---

# What happens when you run:

```bash
minikube start
```

Minikube creates

```
Kubernetes Cluster
        │
-------------------------
API Server
Scheduler
Controller Manager
etcd
Worker Node
Container Runtime
```

Everything runs on your laptop.

---

# Is Minikube the Cluster?

No.

Minikube is the **tool**.

The cluster created by Minikube is named

```
minikube
```

Verify

```bash
kubectl config current-context
```

Output

```
minikube
```

---

# Cluster Lifecycle

## Start Cluster

```bash
minikube start
```

Starts

- API Server
- Scheduler
- Controller Manager
- etcd
- Worker Node

---

## Check Cluster

```bash
minikube status
```

Example

```
host: Running
kubelet: Running
apiserver: Running
```

---

## Stop Cluster

```bash
minikube stop
```

Stops

- Entire Kubernetes cluster

Resources remain saved.

---

## Restart Cluster

```bash
minikube start
```

Pods, Deployments, and Services are restored (unless they were deleted).

---

## Delete Cluster

```bash
minikube delete
```

Deletes

- Cluster
- Pods
- Deployments
- Services
- Persistent cluster configuration

Everything is removed.

---

# Can You Pause an Application?

### Standalone Pod

```
kubectl run nginx --image=nginx
```

Cannot be paused.

Options

- Keep running
- Delete it

---

### Deployment

```
kubectl create deployment nginx --image=nginx
```

Pause by scaling

```
kubectl scale deployment nginx --replicas=0
```

Resume

```
kubectl scale deployment nginx --replicas=1
```

This is how production environments typically "stop" an application without deleting its configuration.

---

# Kubernetes vs Amazon EKS

## Kubernetes

Kubernetes is the software platform.

It provides

- Scheduling
- Scaling
- Networking
- Self-healing
- Rolling updates

It does not specify where it runs.

---

## Amazon EKS

Amazon EKS (Elastic Kubernetes Service) is a managed Kubernetes service provided by AWS.

AWS manages

- Control Plane
- API Server
- etcd
- Scheduler
- High Availability
- Upgrades

You manage

- Applications
- Deployments
- Services
- Worker Nodes (or Fargate)

---

# Kubernetes vs Amazon EKS Comparison

| Feature | Kubernetes | Amazon EKS |
|----------|------------|------------|
| What is it? | Open-source orchestration platform | Managed Kubernetes service on AWS |
| Who manages Control Plane? | You | AWS |
| Runs on | Any infrastructure | AWS Cloud |
| High Availability | Configure yourself | Built-in |
| etcd Management | You | AWS |
| API Server | You | AWS |
| Scaling Worker Nodes | You | You (or Auto Scaling) |
| Kubernetes Version Upgrades | You | AWS assists with control plane upgrades |
| Best For | Learning, self-managed clusters | Production workloads on AWS |

---

# Minikube vs Amazon EKS

| Feature | Minikube | Amazon EKS |
|----------|-----------|------------|
| Purpose | Local development | Cloud production |
| Nodes | Single | Multiple |
| Cost | Free | Paid |
| Runs On | Laptop | AWS |
| Control Plane | Local | AWS Managed |
| Worker Nodes | Local | EC2 or Fargate |
| High Availability | No | Yes |
| Multi-node Support | Limited | Yes |
| Suitable For | Learning | Enterprise Applications |

---

# Do kubectl Commands Change?

No.

Exactly the same commands are used.

Examples

```
kubectl get pods
kubectl get nodes
kubectl describe pod nginx
kubectl logs nginx
kubectl exec -it nginx -- sh
kubectl apply -f deployment.yaml
kubectl delete pod nginx
```

Only the target cluster changes.

---

# Local Development Workflow

```
Developer

      │
      ▼

Minikube

      │

kubectl

      │

Local Kubernetes Cluster

      │

Application Pods
```

---

# AWS Production Workflow

```
Developer

      │

kubectl

      │

AWS EKS Control Plane

      │

Worker Nodes

      │

Pods

      │

Users
```

---

# Typical Learning Path

```
Docker
      ↓
Minikube
      ↓
Pods
      ↓
ReplicaSets
      ↓
Deployments
      ↓
Services
      ↓
Ingress
      ↓
ConfigMaps
      ↓
Secrets
      ↓
Persistent Volumes
      ↓
Helm
      ↓
Amazon EKS
      ↓
Production Kubernetes
```

---

# Interview Questions

### What is Kubernetes?

An open-source container orchestration platform used to deploy, manage, scale, and automate containerized applications.

---

### What is Minikube?

A tool that creates a local single-node Kubernetes cluster for development and learning.

---

### Is Minikube Kubernetes?

No.

Minikube creates and manages a Kubernetes cluster locally.

---

### What happens when you run `minikube start`?

It starts a local Kubernetes cluster, including the control plane components (API Server, Scheduler, Controller Manager, etcd) and the worker node.

---

### Do you need to run `minikube start` every day?

Only if the cluster has been stopped or the system has been rebooted. If Minikube is already running, it is not required.

---

### Can you pause a Pod?

No.

Pods cannot be paused directly. If the application is managed by a Deployment, you can scale the Deployment to zero replicas and later scale it back up.

---

### Do the same `kubectl` commands work in Amazon EKS?

Yes.

The Kubernetes API is consistent across Minikube, EKS, AKS, GKE, and other Kubernetes distributions. The only difference is the target cluster.
