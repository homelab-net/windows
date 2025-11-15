# Claude Code for Windows 11

Setup and diagnostic tools for running Claude Code CLI on Windows 11 bare metal.

## Quick Start

### For Claude Pro/Max Users (Recommended)

1. **Install Node.js** (if not already installed)
   ```powershell
   winget install OpenJS.NodeJS
   ```

2. **Install Claude Code**
   ```powershell
   npm install -g @anthropic-ai/claude-code
   ```

3. **Run Claude Code** (will open browser to authenticate)
   ```powershell
   claude-code
   ```

4. **Login with your Pro account** when prompted in browser

### For API Key Users

1. **Install and set API key**
   ```powershell
   npm install -g @anthropic-ai/claude-code
   [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key-here', 'User')
   ```

2. **Run Claude Code**
   ```powershell
   claude-code
   ```

> **Warning:** If you have Pro/Max and set an API key, the API key takes priority and you'll be charged per token!

## Prerequisites

- Windows 11
- Node.js 18+ ([Download](https://nodejs.org))
- **Either:**
  - Claude Pro or Max subscription (authenticates via browser), **OR**
  - Anthropic API Key ([Get one](https://console.anthropic.com))

> **Note:** If you have Claude Pro/Max, you don't need an API key! Claude Code will authenticate through your browser.

## Files in This Repository

| File | Description |
|------|-------------|
| `SETUP_PRO_USERS.md` | **Simplified guide for Claude Pro/Max users** ⭐ |
| `SETUP.md` | Complete setup guide (both Pro and API methods) |
| `TROUBLESHOOTING.md` | Common issues and solutions |
| `QUICK_REFERENCE.md` | Quick reference card for commands |
| `diagnose.ps1` | PowerShell script to check system compatibility |
| `install.ps1` | Automated installation script |

## Installation Options

### Option 1: Automated (Recommended)

```powershell
# Install globally and configure
.\install.ps1 -Global -ApiKey "your-api-key"

# Or install without API key configuration
.\install.ps1 -Global -SkipApiKey
```

### Option 2: Manual

```powershell
# Global installation
npm install -g @anthropic-ai/claude-code

# Or use npx (no installation needed)
npx @anthropic-ai/claude-code
```

## Usage

```powershell
# Start in current directory
claude-code

# Start in specific directory
claude-code C:\path\to\project

# With specific model
claude-code --model claude-sonnet-4-5-20250929

# Show help
claude-code --help
```

## Troubleshooting

Having issues? Try these steps:

1. Run the diagnostic script: `.\diagnose.ps1`
2. Check the [Troubleshooting Guide](TROUBLESHOOTING.md)
3. Ensure Node.js 18+ is installed: `node --version`
4. Verify API key is set: `echo $env:ANTHROPIC_API_KEY`
5. Try reinstalling: `npm uninstall -g @anthropic-ai/claude-code && npm install -g @anthropic-ai/claude-code`

## Documentation

- [Complete Setup Guide](SETUP.md) - Detailed installation and configuration
- [Troubleshooting Guide](TROUBLESHOOTING.md) - Solutions for common problems
- [Official Claude Code Docs](https://docs.claude.com/en/docs/claude-code)

## Getting Help

- Run diagnostic: `.\diagnose.ps1`
- Check setup guide: See [SETUP.md](SETUP.md)
- Report issues: [GitHub Issues](https://github.com/anthropics/claude-code/issues)

## Requirements

- **OS:** Windows 11 (Windows 10 should work but not officially tested)
- **Node.js:** v18.0.0 or higher
- **Terminal:** Windows Terminal recommended (PowerShell 7+ or Command Prompt)
- **Internet:** Active connection to Anthropic API

## Quick Diagnostic

```powershell
# Check all prerequisites
.\diagnose.ps1

# Check Node.js
node --version

# Check npm
npm --version

# Check Claude Code
claude-code --version

# Check API key
echo $env:ANTHROPIC_API_KEY
```

## Authentication: Pro vs API

### Using Claude Pro/Max (Recommended for Most Users)

**Pros:**
- Fixed monthly cost ($20 for Pro, $200 for Max)
- No per-token charges
- Included with your existing subscription
- Simple browser authentication

**Cons:**
- Shared usage limits with web/mobile (~10-40 prompts per 5 hours)
- Smaller context window (200K tokens)

**How it works:**
1. Run `claude-code`
2. Browser opens for authentication
3. Login with your Claude account
4. Start coding!

### Using API Key (For Heavy Users)

**Pros:**
- Pay only for what you use
- Larger context window (1M tokens for Sonnet 4.5)
- No rate limits based on messages
- Better for large codebases

**Cons:**
- Pay per token (can be $3-15+ per million tokens)
- Need separate API account
- Costs can be unpredictable

**How it works:**
1. Get API key from console.anthropic.com
2. Set environment variable
3. Run `claude-code`

### Check Which One You're Using

Inside Claude Code, type:
```
/status
```

This shows your current authentication method.

## License

See repository license file for details.
