# Extra commands and additional learnings will be posted here

## 📂 Important Concepts: Path References in Linux

Understanding **path references** is essential for navigating and managing files in Linux.

---

### 📌 What is a Path?

A **path** defines the location of a file or directory in the Linux file system.

There are two main types:

* **Absolute Path**
* **Relative Path**

---

## 🔹 Absolute Path

An **absolute path** specifies the complete location of a file starting from the root directory `/`.

### ✅ Example

If your file is located at:

```bash
/home/user/photos/holiday.jpg
```

You can access it using:

```bash
ls /home/user/photos/holiday.jpg
```
---

## 🔹 Relative Path

A **relative path** specifies the location of a file based on your current directory.

### ✅ Example

If you are currently inside:

```bash
/home/user/photos/
```

You can access the file using:

```bash
ls holiday.jpg
```

or

```bash
ls ./holiday.jpg
```
---

## 🔼 Navigating to Parent Directory

To move one level up in the directory structure:

### Using Absolute Path

```bash
cd /home/user
```

### Using Relative Path

```bash
cd ..
```

---

# ⚡ Special Symbols in Paths

| Symbol | Meaning           |
| ------ | ----------------- |
| `.`    | Current directory |
| `..`   | Parent directory  |
| `~`    | Home directory    |

---

## 🎯 Summary

| Type              | Example                         | Use Case                  |
| ----------------- | ------------------------------- | ------------------------- |
| Absolute Path     | `/home/user/photos/holiday.jpg` | Access from anywhere      |
| Relative Path     | `holiday.jpg`                   | When already in directory |
| Parent Navigation | `cd ..`                         | Move up one level         |

---

# 🚀 DevOps Learning Tracker - Upcoming Changes

## 📌 Immediate Tasks (This Week)
- [ * ] Fix image path issue in Linux notes
- [ * ] Restructure repo folders
- [ * ] Add GitHub setup documentation (SSH, clone, push)

## ⚙️ Linux Improvements
- [ ] Descriptive command for copy and grep
- [ ] Seperate create and remove commands for directory and files (mkdir and touch,rm)
- [ ] Hard link and soft link topics
- [ ] Create Hard link, create soft link add content to original files, display content, check content of link files
- [ ] Remove the file and check hard and soft link created
- [ ] Create another file with same name and check whose contents are visible (hard link or soft link)
- [ ] VI Editor operations
- [ ] Create another user and add comments, user ID
- [ ] Change password for users created, set password aging policy 
- [ ] /etc/passwd and /etc/shadow 
- [ ] Create groups, modify grp names, delete group and check config in /etc/group and /etc/gshadow
- [ ] Switch to user accounts created from root
- [ ] File permission tasks, add users to groups, change ownership
- [ ] Assigning ACL permmissions
- [ ] Set UID, GID and sticky bit

- [ ] Add file system diagrams
- [ ] Add permission examples (numeric & symbolic)
- [ ] Add shell scripting examples
- [ ] Create practice questions section

## 🌐 Git & GitHub Enhancements
- [ ] Add detailed SSH setup guide
- [ ] Document branching strategy
- [ ] Add commit message standards

## ☁️ Cloud (AWS)
- [ ] Add EC2 notes
- [ ] Add IAM concepts
- [ ] Add deployment architecture diagram

## 🐳 Docker
- [ ] Install Docker on WSL guide
- [ ] Add Dockerfile examples
- [ ] Add container lifecycle explanation

## 📊 Tableau / Data Tools
- [ ] Upload sample dashboards
- [ ] Add screenshots with explanations

## 🧠 Future Enhancements
- [ ] Add CI/CD pipeline project
- [ ] Integrate Jenkins
- [ ] Add real-world DevOps project
