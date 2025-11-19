🧩 Gitleaks Troubleshooting & Secret Removal Toolkit

This repository provides a complete toolkit and step-by-step guide to identify, remove, and validate leaked credentials (API keys, tokens, certificates) in Git repositories.

It includes:

Local Gitleaks installation and verification

Safe backup strategy before modifying history

Three cleanup methods (single file, specific commit, multi-branch cleanup)

Verification steps after cleanup

Best practices for preventing future leaks

Automated scripts for commit and file cleanup

🧠 Overview

Leaks happen — certificates, tokens, passwords, or sensitive configuration files sometimes end up in Git history.

This repository helps you:

✔ Detect leaks
✔ Clean Git history safely
✔ Automate commit and file removal
✔ Enforce strong security practices

🧩 Step 1: Install & Verify Gitleaks
📦 Installation
Windows

Download the latest release from Gitleaks GitHub.

Verify installation:

gitleaks version

macOS
brew install gitleaks

Linux
curl -sSfL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64.tar.gz | tar -xz
sudo mv gitleaks /usr/local/bin/

🧪 Step 2: Run Initial Scan

Before cleanup, verify if the repo currently contains leaks:

gitleaks detect -s ./ --no-git -v


✔ No leaks detected → safe
✔ Leaks found → note file path or commit ID

🔥 Step 3: Backup Before Cleanup

Always backup before rewriting Git history:

git checkout main
git checkout -b backup_main
git push origin backup_main

🪶 Step 4: Cleanup Methods

This repo supports three cleanup strategies.

🧩 Method 1: Remove a Single File from Entire History

Use this if only one file contains sensitive data.

git filter-repo --sensitive-data-removal --path path/to/leaked_file.pem --invert-paths


Push rewritten history:

git push origin <branch> --force

🧩 Method 2: Remove a Specific Commit

Script available → scrub_commit.sh

Modify:

COMMIT_ID="<your_commit_id>"
BRANCHES=(branch1 branch2 branch3)


Run:

bash scrub_commit.sh


This removes only the affected commit from selected branches.

🧩 Method 3: Remove a File Across Multiple Branches

Script available → remove_file_history.sh

Modify:

FILE_PATH="path/to/file"
BRANCHES=(main develop patch-1)


Run:

bash remove_file_history.sh


This removes the file and its entire history from multiple branches.

🔍 Step 5: Verification & Validation
✔ 1. Check if the commit still exists
git fetch --all
git branch -r --contains <COMMIT_ID>


No output → commit successfully removed.

✔ 2. Clone Fresh & Verify With Gitleaks
git clone <repo-url>
cd repo
gitleaks detect -s ./ --no-git -v


Expected results:

No references to sensitive files

No leaks detected

🧠 Best Practices to Prevent Future Leaks
🔒 1. Use CI/CD Leak Scanning

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

Include in team onboarding:

“Never commit secrets”

“Always run Gitleaks before pushing”

“Review PRs for sensitive data”
