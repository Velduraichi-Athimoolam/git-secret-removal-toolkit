# 🧩 Gitleaks Troubleshooting & Secret Removal Toolkit

This repository provides a complete toolkit and step-by-step guide to identify, remove, and validate leaked credentials (API keys, tokens, certificates) in Git repositories.

It includes:
- Local Gitleaks installation and verification
- Safe backup strategy before modifying history
- Three cleanup methods (single file, specific commit, multi-branch cleanup)
- Verification steps after cleanup
- Best practices for preventing future leaks
- Automated scripts for commit and file cleanup

---

## 🧠 Overview

Leaks can happen — certificates, tokens, passwords, or sensitive configuration files sometimes end up in Git history.  
This repository helps you:

✔ Detect leaks  
✔ Clean Git history safely  
✔ Automate commit and file removal  
✔ Enforce good security practices  

---

# 🧩 Step 1: Install & Verify Gitleaks

## 📦 Installation

### **Windows**
Download the binary from the official releases page and add it to PATH:


gitleaks version


### **macOS**


brew install gitleaks


### **Linux**
```bash
curl -sSfL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64.tar.gz | tar -xz
sudo mv gitleaks /usr/local/bin/

🧪 Step 2: Run Initial Scan

Before cleanup, verify if the repo currently contains leaks:

gitleaks detect -s ./ --no-git -v


✔ If no leaks detected → you’re safe
✔ If leaks found → note the file path or commit ID

🔥 Step 3: Backup Before Cleanup

Always create a backup branch before modifying Git history:

git checkout main
git checkout -b backup_main
git push origin backup_main

🪶 Step 4: Cleanup Methods

This repo supports three cleanup strategies.

🧩 Method 1: Remove a Single File from Entire History

Use this if only one file contains sensitive data.

git filter-repo --sensitive-data-removal --path path/to/leaked_file.pem --invert-paths


Push with force:

git push origin <branch> --force

🧩 Method 2: Remove a Specific Commit

Script available here → scrub_commit.sh

Modify inside the script:

COMMIT_ID="<your_commit_id>"

Add affected branches to BRANCHES=(...)

Run:

bash scrub_commit.sh


This will:

Identify branches containing the commit

Remove the commit only from those branches

Push rewritten history back to origin

🧩 Method 3: Remove a File Across Multiple Branches

Script available here → remove_file_history.sh

Modify inside the script:

FILE_PATH="path/to/file"

Add target branches to BRANCHES=(...)

Run:

bash remove_file_history.sh


This will:

Remove the file’s entire history

Rewrite history for all branches

Push with --force

🔍 Step 5: Verification & Validation
✔ 1. Check if the commit still exists
git fetch --all
git branch -r --contains <COMMIT_ID>


No output = commit successfully removed.

✔ 2. Clone Fresh & Run Gitleaks Again
git clone <repo-url>
cd repo
gitleaks detect -s ./ --no-git -v


Expected:

No references to the sensitive file

No leaks detected

🧠 Best Practices to Prevent Future Leaks
🔒 1. Use CI/CD Leak Scanning

Add a Gitleaks stage to GitHub Actions, Jenkins, GitLab, etc.

GitHub Action example:

name: Gitleaks Scan
on: [pull_request]

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: zricethezav/gitleaks-action@v2

🔑 2. Use Pre-Commit Hooks

Protect staged files:

gitleaks protect --staged --verbose

🔐 3. Store Secrets Properly

Use secure storage:

AWS Secrets Manager

Azure Key Vault

HashiCorp Vault

GitHub Actions Secrets

📘 4. Educate Contributors

Add to onboarding:

“Never commit secrets”

“Always run Gitleaks before push”

“Review PRs for sensitive data”

📁 Repo Structure
.
├── README.md
├── LICENSE
├── scrub_commit.sh
├── remove_file_history.sh
└── .gitleaks.toml.example (optional)

🏁 Final Notes

✔ Always notify your team before force-pushing rewritten history
✔ Confirm cleanup using a fresh clone
✔ Keep your backup branch until cleanup is fully approved
✔ Never commit credentials again — automate checks
