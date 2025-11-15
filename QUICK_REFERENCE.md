# Claude Code - Quick Reference Card for Windows 11

## Installation Commands

```powershell
# Automated installation (recommended)
.\install.ps1 -Global

# Manual global install
npm install -g @anthropic-ai/claude-code

# Use without installing (npx)
npx @anthropic-ai/claude-code
```

## Setup API Key

```powershell
# Permanent (recommended)
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key', 'User')

# Session only
$env:ANTHROPIC_API_KEY = "your-key"

# Or create .env file
echo "ANTHROPIC_API_KEY=your-key" > .env
```

## Running Claude Code

```powershell
# Start in current directory
claude-code

# Start in specific directory
claude-code C:\path\to\project

# Using npx
npx @anthropic-ai/claude-code
```

## Common Commands (Inside Claude Code)

| Command | Description |
|---------|-------------|
| `/help` | Show help and available commands |
| `/clear` | Clear conversation history |
| `/exit` or `/quit` | Exit Claude Code |
| `/model` | Change AI model |
| `/files` | List files in context |

## Diagnostic Commands

```powershell
# Run full diagnostic
.\diagnose.ps1

# Check versions
node --version
npm --version
claude-code --version

# Check API key
echo $env:ANTHROPIC_API_KEY

# Test npm global bin
npm config get prefix
```

## Troubleshooting Quick Fixes

```powershell
# Clear npm cache
npm cache clean --force

# Reinstall Claude Code
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code

# Fix execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Update Node.js
winget upgrade OpenJS.NodeJS
```

## Installation Scripts

```powershell
# Full automated setup
.\install.ps1 -Global -ApiKey "your-key"

# Install without API key
.\install.ps1 -Global -SkipApiKey

# Diagnostic only
.\diagnose.ps1
```

## Requirements Checklist

- [ ] Windows 11
- [ ] Node.js v18+
- [ ] npm (comes with Node.js)
- [ ] Anthropic API key
- [ ] Internet connection
- [ ] Windows Terminal (recommended)

## Quick Start (Copy & Paste)

```powershell
# 1. Install Node.js (if needed)
winget install OpenJS.NodeJS

# 2. Install Claude Code
npm install -g @anthropic-ai/claude-code

# 3. Set API key (replace with your key)
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'sk-ant-your-key-here', 'User')

# 4. Restart terminal, then run
claude-code
```

## Get API Key

1. Visit: https://console.anthropic.com
2. Sign up/Login
3. Go to API Keys
4. Create new key
5. Copy and save securely

## Useful Links

- Setup Guide: `SETUP.md`
- Troubleshooting: `TROUBLESHOOTING.md`
- Official Docs: https://docs.claude.com/en/docs/claude-code
- Node.js Download: https://nodejs.org
- Windows Terminal: `winget install Microsoft.WindowsTerminal`

## Common Issues

| Issue | Quick Fix |
|-------|-----------|
| "node not found" | `winget install OpenJS.NodeJS` |
| "claude-code not found" | Restart terminal after install |
| "API key missing" | Set `ANTHROPIC_API_KEY` env var |
| "Permission denied" | Run PowerShell as Administrator |
| "SSL error" | Check system time & date |

## Model Options

```powershell
# Fastest (Haiku)
claude-code --model claude-haiku-4-0

# Balanced (Sonnet) - Default
claude-code --model claude-sonnet-4-5-20250929

# Most Capable (Opus)
claude-code --model claude-opus-4-0
```

## Environment Variables

```powershell
# API Key (required)
$env:ANTHROPIC_API_KEY = "your-key"

# Debug mode
$env:DEBUG = "*"

# Proxy (if needed)
$env:HTTP_PROXY = "http://proxy:8080"
$env:HTTPS_PROXY = "http://proxy:8080"
```

---

**Tip:** Keep this file open in a separate window for quick reference!
