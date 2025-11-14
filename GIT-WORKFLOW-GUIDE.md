# Git & GitHub Workflow Guide

**Complete reference for professional Git workflow on macOS**

Version: 1.0
Last Updated: 2025-11-14

---

## Table of Contents

1. [Initial Setup](#initial-setup)
2. [Authentication Methods](#authentication-methods)
3. [Daily Workflow](#daily-workflow)
4. [Branch Management](#branch-management)
5. [Conflict Resolution](#conflict-resolution)
6. [Advanced Operations](#advanced-operations)
7. [GitHub CLI](#github-cli)
8. [Troubleshooting](#troubleshooting)
9. [Quick Reference](#quick-reference)
10. [Best Practices](#best-practices)

---

## Initial Setup

### Install Git

**Option 1: Via Xcode Command Line Tools** (Recommended - includes Apple's version)
```bash
xcode-select --install
```

**Option 2: Via Homebrew** (Latest version, more control)
```bash
brew install git
```

**Verify installation:**
```bash
git --version
# Expected: git version 2.x.x
```

---

### Configure Git Identity

**Required before first commit:**
```bash
# Set your name (appears in commits)
git config --global user.name "Your Full Name"

# Set your email (MUST match GitHub email)
git config --global user.email "your.email@example.com"

# Verify configuration
git config --global --list
```

**Expected output:**
```
user.name=Your Full Name
user.email=your.email@example.com
```

---

### Additional Recommended Settings

```bash
# Use main as default branch name (modern standard)
git config --global init.defaultBranch main

# Enable credential caching (macOS Keychain)
git config --global credential.helper osxkeychain

# Better diff output
git config --global color.ui auto

# Set default editor (choose one)
git config --global core.editor "nano"           # Simple
git config --global core.editor "code --wait"    # VS Code
git config --global core.editor "vim"            # Vim

# See all global settings
git config --global --list
```

---

## Authentication Methods

### Method 1: SSH Keys (Recommended for Daily Use)

**Advantages:**
- No password needed after setup
- Most secure (cryptographic proof)
- Never expires
- Professional standard

**Setup:**

```bash
# 1. Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"
# Press Enter 3 times (default location, no passphrase)

# 2. Copy public key to clipboard
cat ~/.ssh/id_ed25519.pub | pbcopy
# OR view it to copy manually:
cat ~/.ssh/id_ed25519.pub

# 3. Add to GitHub:
# Go to: GitHub.com → Settings → SSH and GPG keys → New SSH key
# Title: "Mac Terminal"
# Key: Paste the key (Cmd+V)
# Click: Add SSH key

# 4. Test connection
ssh -T git@github.com
# Expected: "Hi YourUsername! You've successfully authenticated..."
```

**Troubleshooting SSH:**
```bash
# If SSH key isn't being used:
ssh-add ~/.ssh/id_ed25519

# Check loaded keys:
ssh-add -l

# Start SSH agent if needed:
eval "$(ssh-agent -s)"
```

---

### Method 2: Personal Access Token (For Multiple Machines/CI)

**Advantages:**
- Works on any machine
- Easy to revoke
- Can set expiration
- Good for automation

**Setup:**

```bash
# 1. Create token on GitHub:
# GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic)
# Generate new token → Check "repo" scope → Generate
# Copy the token (starts with ghp_...)

# 2. Clone repository with HTTPS
git clone https://github.com/Username/repo.git
# Username: YourUsername
# Password: [Paste token here, NOT your GitHub password]

# 3. Save credentials
git config --global credential.helper osxkeychain
# Next git operation will save credentials to Keychain
```

---

### Method 3: GitHub CLI (Modern, Most Convenient)

**Advantages:**
- Easiest authentication (one command)
- Manages tokens automatically
- Can create PRs, issues from terminal
- Works with SSH or HTTPS

**Setup:**

```bash
# 1. Install
brew install gh

# 2. Login (interactive)
gh auth login
# Follow prompts:
# - GitHub.com
# - SSH (recommended) or HTTPS
# - Generate new SSH key: Yes
# - Title: "Mac Terminal"
# - Login with browser: Yes

# 3. Verify
gh auth status
# Expected: "Logged in to github.com as YourUsername"
```

**Useful GitHub CLI commands:**
```bash
gh repo view              # View current repo
gh repo clone owner/repo  # Clone repository
gh pr create              # Create pull request
gh pr list                # List pull requests
gh pr checkout 123        # Checkout PR #123
gh issue list             # List issues
gh issue create           # Create issue
```

---

## Daily Workflow

### Clone a Repository (First Time)

**With SSH:**
```bash
cd ~
git clone git@github.com:Username/repository-name.git
cd repository-name
```

**With HTTPS:**
```bash
cd ~
git clone https://github.com/Username/repository-name.git
cd repository-name
```

**With GitHub CLI:**
```bash
cd ~
gh repo clone Username/repository-name
cd repository-name
```

---

### Start of Day Routine

```bash
# Navigate to project
cd ~/project-name

# Check current status
git status

# Pull latest changes
git pull
# OR pull specific branch:
git pull origin main

# See what changed
git log --oneline -5
```

---

### Making Changes

```bash
# 1. Check current branch
git branch
# * main  (asterisk shows current branch)

# 2. Create new branch for your work (optional but recommended)
git checkout -b feature/new-feature

# 3. Make changes (edit files in any editor)
# ... edit files ...

# 4. Check what changed
git status
# Shows: modified, added, deleted files

# 5. See detailed changes
git diff
# Shows line-by-line changes

# 6. Stage changes
git add .                    # Stage all changes
git add file1.txt file2.txt  # Stage specific files
git add *.sh                 # Stage all .sh files

# 7. Review staged changes
git status
# Files in green are staged

# 8. Commit with message
git commit -m "Add new feature: description of what you did"

# 9. Push to GitHub
git push
# First time on new branch:
git push -u origin feature/new-feature
```

---

### End of Day Routine

```bash
# Make sure all changes are committed
git status
# Expected: "nothing to commit, working tree clean"

# If you have uncommitted changes:
git add .
git commit -m "End of day: description"
git push

# See today's work
git log --oneline --since="1 day ago"
```

---

## Branch Management

### View Branches

```bash
# Local branches only
git branch

# All branches (including remote)
git branch -a

# Remote branches only
git branch -r

# Branches with last commit info
git branch -v
```

---

### Create and Switch Branches

```bash
# Create new branch
git branch new-branch-name

# Switch to branch
git checkout branch-name

# Create and switch in one command (recommended)
git checkout -b new-branch-name

# Modern alternative (Git 2.23+)
git switch branch-name           # Switch
git switch -c new-branch-name    # Create and switch
```

---

### Delete Branches

```bash
# Delete local branch (safe - prevents delete if unmerged)
git branch -d branch-name

# Force delete (CAREFUL - deletes even if unmerged)
git branch -D branch-name

# Delete remote branch
git push origin --delete branch-name
```

---

### Rename Branch

```bash
# Rename current branch
git branch -m new-name

# Rename specific branch
git branch -m old-name new-name

# Update remote
git push origin :old-name new-name
git push origin -u new-name
```

---

## Conflict Resolution

### When Conflicts Occur

**Scenario 1: During merge**

```bash
git merge origin/main
# Output: CONFLICT (content): Merge conflict in file.txt

# 1. See conflicted files
git status
# Files marked as "both modified"

# 2. Open conflicted file - you'll see markers:
# <<<<<<< HEAD
# Your changes
# =======
# Their changes
# >>>>>>> origin/main

# 3. Edit file to resolve (remove markers, keep what you want)

# 4. Mark as resolved
git add file.txt

# 5. Complete the merge
git commit -m "Resolved merge conflicts"

# 6. Push
git push
```

---

**Scenario 2: modify/delete conflicts**

```bash
git merge origin/main
# Output: CONFLICT (modify/delete): file.txt deleted in origin/main and modified in HEAD

# OPTION A: Keep the file (your version)
git add file.txt
git commit -m "Resolved conflict: kept modified file"

# OPTION B: Accept the deletion
git rm file.txt
git commit -m "Resolved conflict: accepted deletion"
```

---

### Abort Operations

```bash
# Abort merge
git merge --abort

# Abort rebase
git rebase --abort

# Abort cherry-pick
git cherry-pick --abort
```

---

## Advanced Operations

### View History

```bash
# Compact log (one line per commit)
git log --oneline

# Last 10 commits
git log --oneline -10

# Commits with file changes
git log --stat

# Commits with full diff
git log -p

# Graph view (shows branches)
git log --oneline --graph --all

# Commits by specific author
git log --author="Your Name"

# Commits in date range
git log --since="2 weeks ago"
git log --since="2025-01-01" --until="2025-01-31"

# Search commit messages
git log --grep="bug fix"
```

---

### Undo Changes

**Undo uncommitted changes:**
```bash
# Discard changes in specific file
git checkout -- file.txt

# Discard all uncommitted changes (CAREFUL!)
git reset --hard HEAD

# Remove untracked files (CAREFUL!)
git clean -fd
```

**Undo last commit (keep changes):**
```bash
# Undo commit but keep changes staged
git reset --soft HEAD~1

# Undo commit and unstage changes
git reset HEAD~1

# Undo commit and discard changes (CAREFUL!)
git reset --hard HEAD~1
```

**Undo pushed commit:**
```bash
# Create new commit that undoes previous commit
git revert HEAD

# Revert specific commit
git revert abc123

# Push the revert
git push
```

---

### Stash Changes

**Temporarily save uncommitted changes:**

```bash
# Save all changes
git stash

# Save with description
git stash save "Work in progress on feature X"

# List all stashes
git stash list

# Apply most recent stash (keep in stash)
git stash apply

# Apply and remove from stash
git stash pop

# Apply specific stash
git stash apply stash@{2}

# Delete stash
git stash drop stash@{0}

# Clear all stashes (CAREFUL!)
git stash clear
```

---

### Compare Changes

```bash
# Compare working directory with last commit
git diff

# Compare staged changes with last commit
git diff --staged

# Compare two branches
git diff main feature-branch

# Compare specific commits
git diff abc123 def456

# Compare with remote
git diff origin/main

# Show changes in specific file
git diff file.txt
```

---

### Cherry-Pick Commits

**Apply specific commit from another branch:**

```bash
# Get commit hash
git log --oneline

# Apply commit to current branch
git cherry-pick abc123

# Apply multiple commits
git cherry-pick abc123 def456

# Cherry-pick without committing (to review first)
git cherry-pick --no-commit abc123
```

---

### Rebase

**Replay commits on top of another branch:**

```bash
# Rebase current branch onto main
git rebase main

# Interactive rebase (edit last 3 commits)
git rebase -i HEAD~3

# Continue after resolving conflicts
git rebase --continue

# Skip current commit
git rebase --skip

# Abort rebase
git rebase --abort
```

---

## GitHub CLI

### Repository Management

```bash
# Clone repository
gh repo clone owner/repo

# Create new repository
gh repo create my-new-repo --public

# View repository
gh repo view

# Open in browser
gh repo view --web

# Fork repository
gh repo fork owner/repo
```

---

### Pull Requests

```bash
# Create PR
gh pr create

# Create PR with details
gh pr create --title "Add feature" --body "Description"

# List PRs
gh pr list

# View PR details
gh pr view 123

# View PR in browser
gh pr view 123 --web

# Checkout PR locally
gh pr checkout 123

# Merge PR
gh pr merge 123

# Close PR
gh pr close 123

# Review PR
gh pr review 123 --approve
gh pr review 123 --request-changes --body "Please fix X"
```

---

### Issues

```bash
# Create issue
gh issue create

# List issues
gh issue list

# View issue
gh issue view 456

# Close issue
gh issue close 456

# Reopen issue
gh issue reopen 456
```

---

## Troubleshooting

### Common Issues

**"Permission denied (publickey)"**
```bash
# Test SSH
ssh -T git@github.com

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Check if key is loaded
ssh-add -l

# Regenerate if needed
ssh-keygen -t ed25519 -C "your@email.com"
```

---

**"Authentication failed" with HTTPS**
```bash
# Make sure you're using token, not password
# Regenerate token: GitHub → Settings → Developer settings → Tokens

# Clear saved credentials
git credential-osxkeychain erase
# Then enter: host=github.com, protocol=https, [blank line]

# Try again
git pull
# Enter username and NEW token
```

---

**"fatal: refusing to merge unrelated histories"**
```bash
git pull --allow-unrelated-histories
```

---

**"Your branch and 'origin/main' have diverged"**
```bash
# See the difference
git log HEAD..origin/main
git log origin/main..HEAD

# Option 1: Merge
git pull

# Option 2: Rebase
git pull --rebase

# Option 3: Force push (CAREFUL - overwrites remote!)
git push --force
```

---

**"Updates were rejected because the tip of your current branch is behind"**
```bash
# Pull first
git pull

# If conflicts, resolve them
# Then push
git push
```

---

**Accidentally committed to wrong branch**
```bash
# Undo commit (keep changes)
git reset --soft HEAD~1

# Switch to correct branch
git checkout correct-branch

# Commit again
git add .
git commit -m "Same message"
git push
```

---

**Large file causing push to fail**
```bash
# Remove from last commit
git rm --cached large-file.zip
git commit --amend -m "Remove large file"

# Add to .gitignore
echo "large-file.zip" >> .gitignore
git add .gitignore
git commit -m "Add large file to gitignore"
git push
```

---

### Check Configuration

```bash
# View all settings
git config --list

# View specific setting
git config user.name
git config user.email

# View remote URL
git remote -v

# Change remote URL
git remote set-url origin git@github.com:Username/repo.git
```

---

## Quick Reference

### Essential Commands

```bash
# Setup (one-time)
git config --global user.name "Name"
git config --global user.email "email@example.com"

# Clone
git clone git@github.com:user/repo.git

# Daily workflow
git pull                           # Get updates
git status                         # Check status
git add .                          # Stage all
git commit -m "message"            # Commit
git push                           # Push to GitHub

# Branching
git branch                         # List branches
git checkout -b new-branch         # Create & switch
git checkout main                  # Switch to main
git merge feature-branch           # Merge branch

# View history
git log --oneline -10              # Last 10 commits
git diff                           # See changes

# Undo
git reset --soft HEAD~1            # Undo last commit (keep changes)
git checkout -- file.txt           # Discard file changes

# Utilities
cd ~/repo-name                     # Navigate
open .                             # Open in Finder
pwd                                # Show path
```

---

### Git Status Codes

```bash
M  = Modified
A  = Added
D  = Deleted
R  = Renamed
C  = Copied
U  = Updated but unmerged
?? = Untracked
```

---

### Commit Message Best Practices

**Good commit messages:**
```
Add user authentication feature
Fix bug in payment processing
Update README with installation instructions
Refactor database queries for performance
```

**Bad commit messages:**
```
fix stuff
updates
asdf
done
```

**Format for complex changes:**
```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
- Bullet points for multiple changes
- Explain WHY, not just WHAT
- Reference issues: Fixes #123
```

---

## Best Practices

### 1. Commit Often

```bash
# Small, focused commits are better
git add feature.js
git commit -m "Add login form validation"

git add styles.css
git commit -m "Update button styles"

# NOT:
git add .
git commit -m "bunch of changes"
```

---

### 2. Pull Before Push

```bash
# Always pull before pushing to avoid conflicts
git pull
git push
```

---

### 3. Use Branches

```bash
# Never commit directly to main
git checkout -b feature/new-login
# ... do work ...
git push -u origin feature/new-login
# Create PR on GitHub
# Merge via GitHub
# Delete branch after merge
```

---

### 4. Write Meaningful Commit Messages

```bash
# Good
git commit -m "Fix null pointer exception in user profile"

# Bad
git commit -m "fix bug"
```

---

### 5. Keep .gitignore Updated

```bash
# Create .gitignore in project root
echo ".DS_Store" >> .gitignore
echo "node_modules/" >> .gitignore
echo "*.log" >> .gitignore
echo ".env" >> .gitignore

git add .gitignore
git commit -m "Add .gitignore"
```

**Common patterns:**
```
# macOS
.DS_Store

# IDE
.vscode/
.idea/

# Dependencies
node_modules/
venv/
__pycache__/

# Logs
*.log
logs/

# Environment
.env
.env.local

# Build outputs
dist/
build/
*.pyc
```

---

### 6. Never Commit Secrets

```bash
# NEVER commit:
# - Passwords
# - API keys
# - Private keys
# - Tokens
# - Credentials

# Use .env files and add to .gitignore
echo ".env" >> .gitignore
```

---

### 7. Review Before Committing

```bash
# Always check what you're committing
git status
git diff

# Then commit
git add .
git commit -m "message"
```

---

### 8. Keep Main Branch Stable

- Main should always work
- Test before merging
- Use branches for experiments
- Review code before merging

---

### 9. Use Pull Requests

- Don't merge directly
- Let others review
- Discuss changes
- Keep history clean

---

### 10. Regular Backups

```bash
# Push regularly (GitHub = backup)
git push

# Clone to multiple locations if critical
git clone git@github.com:user/repo.git ~/backup/
```

---

## Keyboard Shortcuts (Terminal)

```bash
Ctrl+C    # Cancel current command
Ctrl+D    # Exit terminal / EOF
Ctrl+L    # Clear screen
Ctrl+A    # Move to beginning of line
Ctrl+E    # Move to end of line
Ctrl+U    # Delete line before cursor
Ctrl+K    # Delete line after cursor
Ctrl+W    # Delete word before cursor
Ctrl+R    # Search command history
Tab       # Auto-complete
↑/↓       # Navigate command history
```

---

## File Operations

```bash
# Navigate
cd ~/project       # Go to project
cd ..              # Go up one level
cd -               # Go to previous directory
pwd                # Show current path

# List files
ls                 # List files
ls -la             # List all (including hidden)
ls -lh             # List with human-readable sizes

# View files
cat file.txt       # Display file
less file.txt      # Scroll through file (q to quit)
head file.txt      # First 10 lines
tail file.txt      # Last 10 lines
tail -f file.log   # Follow file updates

# Edit files
nano file.txt      # Simple editor
vim file.txt       # Vim editor
code file.txt      # VS Code (if installed)

# File operations
cp file.txt backup.txt    # Copy
mv old.txt new.txt        # Rename/move
rm file.txt               # Delete file
rm -rf directory/         # Delete directory
mkdir new-folder          # Create directory

# Search
grep "text" file.txt      # Search in file
grep -r "text" .          # Search recursively
find . -name "*.txt"      # Find files
```

---

## Aliases (Make Life Easier)

**Add to `~/.zshrc` or `~/.bash_profile`:**

```bash
# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'

# Shortcuts
alias project='cd ~/didactic-giggle'
```

**Reload after editing:**
```bash
source ~/.zshrc
# OR
source ~/.bash_profile
```

---

## Resources

### Official Documentation
- Git: https://git-scm.com/doc
- GitHub: https://docs.github.com
- GitHub CLI: https://cli.github.com/manual

### Interactive Learning
- https://learngitbranching.js.org/
- https://lab.github.com/

### Cheat Sheets
- https://education.github.com/git-cheat-sheet-education.pdf

---

## Appendix: Git Flow Diagram

```
Working Directory  →  Staging Area  →  Local Repository  →  Remote Repository
                       (git add)         (git commit)         (git push)

       ←               ←                 ←                    ←
   (git checkout)  (git reset)      (git fetch/pull)
```

---

**End of Guide**

Keep this file in your repository root or home directory for quick reference.

For questions or issues, refer to the Troubleshooting section or official Git documentation.

---

**Pro tip**: Print the Quick Reference section and keep it at your desk!
