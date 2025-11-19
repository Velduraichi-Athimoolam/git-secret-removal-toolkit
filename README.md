# 🧩 Gitleaks Troubleshooting & Secret Removal Toolkit

A complete toolkit to identify, remove, and validate leaked credentials (API keys, tokens, certificates) in Git repositories.

## ✅ Features
- Local Gitleaks installation & verification  
- Safe backup workflow before cleanup  
- 3 cleanup methods:
  - Remove file from entire history
  - Remove specific commit
  - Multi-branch cleanup  
- Automated scripts for fast cleanup  
- Best practices for preventing future leaks  

---

# 🧠 Overview
Leaks happen — certificates, tokens, passwords sometimes end up in Git history.  
This toolkit helps you:

✔ Detect leaks  
✔ Clean Git history safely  
✔ Automate file/commit scrubbing  
✔ Enforce security practices  

---

# 🧩 Step 1: Install & Verify Gitleaks

## 📦 Installation

### **Windows**
Download the binary → add to PATH.

# 🧩 Gitleaks Troubleshooting & Secret Removal Toolkit

A complete toolkit to identify, remove, and validate leaked credentials (API keys, tokens, certificates) in Git repositories.

## ✅ Features
- Local Gitleaks installation & verification  
- Safe backup workflow before cleanup  
- 3 cleanup methods:
  - Remove file from entire history
  - Remove specific commit
  - Multi-branch cleanup  
- Automated scripts for fast cleanup  
- Best practices for preventing future leaks  

---

# 🧠 Overview
Leaks happen — certificates, tokens, passwords sometimes end up in Git history.  
This toolkit helps you:

✔ Detect leaks  
✔ Clean Git history safely  
✔ Automate file/commit scrubbing  
✔ Enforce security practices  

---

# 🧩 Step 1: Install & Verify Gitleaks

## 📦 Installation

### **Windows**
Download the binary → add to PATH.

Verify installation:

```bash
gitleaks version
```


### **MacOS**
```bash
brew install gitleaks
```

### **Linux**
```bash
curl -sSfL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64.tar.gz | tar -xz
sudo mv gitleaks /usr/local/bin/

```


# 🧪 Step 2: Run Initial Scan

Before cleanup, check if the repository contains leaks:
