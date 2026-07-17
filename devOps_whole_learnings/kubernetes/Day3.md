# Kubernetes Lab 02

# Deployments, ReplicaSets, Rolling Updates & Rollbacks

---

# Objective

In this lab, we move from managing a single Pod (Lab 01) to managing production-ready applications using Kubernetes Deployments.

By the end of this lab, you will be able to:

* Create a Deployment using a YAML manifest.
* Deploy multiple replicas of an application.
* Understand the relationship between Deployment, ReplicaSet, and Pods.
* Perform rolling updates without downtime.
* Monitor rollout status.
* Roll back to a previous version.
* Scale applications up and down.
* Compare standalone Pods with Deployments.

---

# Prerequisites

* Ubuntu/Linux
* Docker installed
* Minikube running
* kubectl configured

Verify the cluster:

```bash
minikube status
kubectl get nodes
```

Expected:

```text
NAME       STATUS   ROLES           AGE
minikube   Ready    control-plane
```

---

# Lab Architecture

```
                  deployment.yaml
                         │
                         ▼
                 Kubernetes API Server
                         │
                         ▼
                   Deployment
                         │
                         ▼
                    ReplicaSet
                         │
        ┌────────────┬────────────┬────────────┐
        ▼            ▼            ▼
      Pod-1        Pod-2        Pod-3
        │            │            │
      nginx        nginx        nginx
```

---

# Step 1 – Remove Previous Standalone Pod

If the standalone Pod from Lab 01 still exists:

```bash
kubectl delete pod nginx
```

Verify:

```bash
kubectl get pods
```

---

# Step 2 – Create deployment.yaml

Create the manifest:

```bash
nano deployment.yaml
```

Paste the following:

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx
        image: nginx:1.27
        ports:
        - containerPort: 80
```

Save the file.

---

# Understanding deployment.yaml

## apiVersion

```yaml
apiVersion: apps/v1
```

Specifies the Kubernetes API version for Deployments.

---

## kind

```yaml
kind: Deployment
```

Creates a Deployment resource.

---

## metadata

```yaml
metadata:
  name: nginx-deployment
```

Name of the Deployment.

---

## replicas

```yaml
replicas: 3
```

Desired number of Pods.

Kubernetes continuously ensures that exactly three Pods are running.

---

## selector

```yaml
selector:
  matchLabels:
    app: nginx
```

The Deployment manages Pods with the label:

```
app=nginx
```

---

## template

Everything inside `template` defines the Pod specification.

---

## containers

```yaml
containers:
- name: nginx
  image: nginx:1.27
```

Specifies the container image and configuration.

---

# Step 3 – Apply the Deployment

```bash
kubectl apply -f deployment.yaml
```

Expected:

```text
deployment.apps/nginx-deployment created
```

---

# Step 4 – Verify Deployment

```bash
kubectl get deployments
```

Example:

```text
NAME               READY   UP-TO-DATE   AVAILABLE
nginx-deployment   3/3     3            3
```

---

# Step 5 – Verify Pods

```bash
kubectl get pods
```

Example:

```text
nginx-deployment-7b5c98dfd4-ab123
nginx-deployment-7b5c98dfd4-cd456
nginx-deployment-7b5c98dfd4-ef789
```

Notice:

* Three Pods
* Auto-generated names
* Managed by a Deployment

---

# Step 6 – View ReplicaSet

```bash
kubectl get replicasets
```

Example:

```text
NAME                          DESIRED
nginx-deployment-7b5c98dfd4      3
```

Relationship:

```
Deployment
      │
      ▼
ReplicaSet
      │
      ▼
Pods
```

---

# Step 7 – Update the Image

Edit:

```bash
nano deployment.yaml
```

Change:

```yaml
image: nginx:1.27
```

to

```yaml
image: nginx:1.28
```

Save.

---

# Step 8 – Apply the Updated Manifest

```bash
kubectl apply -f deployment.yaml
```

Expected:

```text
deployment.apps/nginx-deployment configured
```

---

# Step 9 – Observe Rolling Update

Watch Pods:

```bash
kubectl get pods -w
```

Rolling update sequence:

```
Old Pod A
↓

New Pod A

↓

Old Pod B

↓

New Pod B

↓

Old Pod C

↓

New Pod C
```

The application remains available during the update.

---

# Step 10 – Check Rollout Status

```bash
kubectl rollout status deployment/nginx-deployment
```

or

```bash
kubectl rollout status deployment nginx-deployment
```

Expected:

```text
deployment "nginx-deployment" successfully rolled out
```

---

# Step 11 – View Rollout History

```bash
kubectl rollout history deployment/nginx-deployment
```

Example:

```text
REVISION
1
2
```

Each successful update creates a new revision.

---

# Step 12 – Roll Back

Undo the last rollout:

```bash
kubectl rollout undo deployment/nginx-deployment
```

Expected:

```text
deployment.apps/nginx-deployment rolled back
```

Verify:

```bash
kubectl rollout status deployment/nginx-deployment
```

---

# Step 13 – Scale the Deployment

Increase replicas:

```bash
kubectl scale deployment nginx-deployment --replicas=5
```

Reduce replicas:

```bash
kubectl scale deployment nginx-deployment --replicas=2
```

Verify:

```bash
kubectl get pods
```

---

# Step 14 – Delete the Deployment

```bash
kubectl delete deployment nginx-deployment
```

This deletes:

* Deployment
* ReplicaSet
* Managed Pods

---

# Internal Workflow

## Deployment Creation

```
kubectl apply
        │
        ▼
API Server
        │
        ▼
Deployment
        │
        ▼
ReplicaSet
        │
        ▼
Three Pods
```

---

## Rolling Update

```
Old ReplicaSet
        │
        ▼
New ReplicaSet
        │
        ▼
New Pods Created
        │
        ▼
Old Pods Removed
```

---

## Rollback

```
Revision 2
      │
      ▼
Rollback
      │
      ▼
Revision 1 Restored
```

---

# Comparison with Lab 01

## 1. Why use deployment.yaml instead of kubectl run?

### Lab 01

```
kubectl run nginx --image=nginx
```

This is an **imperative** approach.

It tells Kubernetes exactly what to do once.

Advantages:

* Simple
* Quick
* Good for learning

Disadvantages:

* Configuration isn't saved.
* Difficult to reproduce.
* Not ideal for production.

---

### Lab 02

```
kubectl apply -f deployment.yaml
```

This is a **declarative** approach.

You describe the desired state, and Kubernetes continuously works to maintain it.

Advantages:

* Version controlled (Git)
* Reproducible
* Easy to modify
* Shareable with teams
* Production standard

---

## 2. What are replicas?

A replica is an identical copy of a Pod.

Example:

```
Replica 1 → nginx
Replica 2 → nginx
Replica 3 → nginx
```

If one Pod fails:

```
Pod ❌

↓

ReplicaSet detects only 2 Pods

↓

Automatically creates a new Pod
```

---

## Were replicas required in Lab 01?

No.

Lab 01 created a standalone Pod.

```
kubectl run nginx
```

If that Pod failed:

```
Pod deleted

↓

Nothing replaces it.
```

There was no Deployment or ReplicaSet managing it.

---

## 3. After changing the image, are new Pods created automatically?

Yes.

You only change:

```yaml
image: nginx:1.28
```

Then run:

```bash
kubectl apply -f deployment.yaml
```

Kubernetes automatically performs a rolling update.

```
Old Pod

↓

New Pod

↓

Old Pod

↓

New Pod
```

No manual Pod creation is required.

---

## 4. Is deployment.yaml only used to create multiple Pods?

No.

It also provides:

* Declarative configuration
* Self-healing
* Automatic scaling
* Rolling updates
* Rollbacks
* Easy deployment through Git
* Repeatable deployments

Creating multiple Pods is just one capability.

---

# Lab 01 vs Lab 02

| Feature             | Lab 01 (Standalone Pod) | Lab 02 (Deployment) |
| ------------------- | ----------------------- | ------------------- |
| Resource Type       | Pod                     | Deployment          |
| Uses YAML           | No                      | Yes                 |
| Configuration Saved | No                      | Yes                 |
| Multiple Pods       | No                      | Yes                 |
| ReplicaSet          | No                      | Yes                 |
| Automatic Recovery  | No                      | Yes                 |
| Rolling Updates     | No                      | Yes                 |
| Rollback            | No                      | Yes                 |
| Scaling             | No                      | Yes                 |
| Production Ready    | No                      | Yes                 |

---

# Commands Practiced

```bash
kubectl apply -f deployment.yaml

kubectl get deployments

kubectl get pods

kubectl get replicasets

kubectl get pods -w

kubectl rollout status deployment/nginx-deployment

kubectl rollout history deployment/nginx-deployment

kubectl rollout undo deployment/nginx-deployment

kubectl scale deployment nginx-deployment --replicas=5

kubectl delete deployment nginx-deployment
```

---

# Key Learnings

* Learned the difference between imperative and declarative Kubernetes management.
* Created a Deployment from a YAML manifest.
* Understood how Deployments manage ReplicaSets and Pods.
* Learned the purpose of replicas and self-healing.
* Performed rolling updates with zero downtime.
* Monitored rollout progress.
* Rolled back to a previous version.
* Scaled applications up and down.
* Compared standalone Pods (Lab 01) with Deployments (Lab 02).
* Understood why YAML manifests are the standard approach in production environments.

---

# Next Topics

The recommended learning order after this lab is:

1. Labels and Selectors
2. Services (ClusterIP, NodePort, LoadBalancer)
3. Namespaces
4. ConfigMaps
5. Secrets
6. Persistent Volumes (PV/PVC)
7. Ingress
8. Helm
9. Kubernetes Networking
10. Amazon EKS
