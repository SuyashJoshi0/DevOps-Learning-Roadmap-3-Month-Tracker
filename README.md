# 🔗 GitHub Setup Using WSL (Ubuntu) — Complete Guide

## 📌 Overview

This document explains the complete setup of connecting **Ubuntu (WSL)** to GitHub using **SSH authentication**, along with common errors and their fixes.

---

# 🧱 Environment Setup

## 💻 System Used

* Windows + WSL (Ubuntu)
* Git installed inside WSL

## 🔧 Install Git

```bash
sudo apt update
sudo apt install git
```

## ⚙️ Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```

---

# 🔐 SSH Authentication Setup (Recommended)

## 🧩 Why SSH?

* No need to enter username/password every time
* More secure than HTTPS
* Industry standard for DevOps workflows

---

## 🔑 Step 1: Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

### 📝 Note:

In our case, the key was initially generated as:

```
./ssh_key
./ssh_key.pub
```

---

## 📁 Step 2: Move Key to Default Location

```bash
mkdir -p ~/.ssh
mv ssh_key ~/.ssh/id_ed25519
mv ssh_key.pub ~/.ssh/id_ed25519.pub
```

---

## 🔒 Step 3: Set Correct Permissions

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

---

## ⚙️ Step 4: Start SSH Agent & Add Key

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

## 📋 Step 5: Copy Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

👉 Copy the full output (single line starting with `ssh-ed25519`)

---

## 🌐 Step 6: Add Key to GitHub

* Go to: GitHub → Settings → SSH and GPG Keys
* Click: **New SSH Key**
* Paste your key
* Save

---

## 🧪 Step 7: Test SSH Connection

```bash
ssh -T git@github.com
```

### ✅ Expected Output:

```
Hi <your-username>! You've successfully authenticated...
```

---

# 🔄 Switching from HTTPS to SSH

## 📌 Check Current Remote

```bash
git remote -v
```

## 🔁 Update Remote URL

```bash
git remote set-url origin git@github.com:username/repository-name.git
```

---

# 🚀 Push Code to GitHub

## 📦 Initial Push

```bash
git push -u origin main
```

---

# ⚠️ Errors Faced & Fixes

## ❌ 1. Password Authentication Failed

**Error:**

```
Invalid username or token
```

**Fix:**

* GitHub removed password auth
* Use:

  * Personal Access Token (PAT) OR
  * SSH (preferred ✅)

---

## ❌ 2. Write Access Not Granted (403)

**Cause:**

* Wrong credentials or repo permission

**Fix:**

* Use correct account
* Ensure repo ownership or collaborator access

---

## ❌ 3. Permission Denied (publickey)

**Cause:**

* SSH key not loaded or wrong location

**Fix:**

```bash
ssh-add ~/.ssh/id_ed25519
```

---

## ❌ 4. No Such File or Directory (SSH Key)

**Cause:**

* Key created outside `.ssh` directory

**Fix:**

* Move key to `~/.ssh/`

---

## ❌ 5. Repository Not Found

**Cause:**

* Incorrect repo URL

**Fix:**

```bash
git remote set-url origin git@github.com:username/repo.git
```

---

## ❌ 6. Rejected Push (Fetch First)

**Cause:**

* Remote repo has existing commits

**Fix:**

```bash
git pull origin main --allow-unrelated-histories
git push
```

---

## ❌ 7. No Upstream Branch

**Fix:**

```bash
git push -u origin main
```

---

# 🧠 Key Learnings

* WSL and Windows are separate environments
* SSH keys must be generated inside WSL
* GitHub no longer supports password authentication
* SSH is the best long-term solution
* Git errors are often **informative, not failures**

---

# 🎯 Final Workflow

```bash
git add .
git commit -m "your message"
git push
```

---

# 🚀 Conclusion

Successfully connected WSL Ubuntu to GitHub using SSH authentication.
Now able to push code securely without repeated login prompts.

---

## ⭐ Future Improvements

* Automate SSH agent startup
* Use GitHub Actions for CI/CD
* Implement branching strategies
