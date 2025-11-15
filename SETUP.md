# Claude Code Setup for Windows 11

This guide will help you install and configure Claude Code CLI on Windows 11.

## Prerequisites

1. **Windows 11** with administrator access
2. **Node.js** (version 18 or higher)
3. **npm** or **npx** (comes with Node.js)
4. **PowerShell** or **Windows Terminal**
5. **Anthropic API Key**

## Quick Start

### 1. Check Prerequisites

Run the diagnostic script to check your system:

```powershell
.\diagnose.ps1
```

### 2. Install Claude Code

**Option A: Using npx (Recommended)**
```powershell
npx @anthropic-ai/claude-code@latest
```

**Option B: Global Installation**
```powershell
npm install -g @anthropic-ai/claude-code
```

### 3. Set Up API Key

You need an Anthropic API key to use Claude Code.

**Option A: Environment Variable (Persistent)**
```powershell
# Run PowerShell as Administrator
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-api-key-here', 'User')
```

**Option B: Session Variable (Temporary)**
```powershell
$env:ANTHROPIC_API_KEY = "your-api-key-here"
```

**Option C: Create a .env file**
Create a `.env` file in your project directory:
```
ANTHROPIC_API_KEY=your-api-key-here
```

### 4. Verify Installation

```powershell
# If installed globally
claude-code --version

# If using npx
npx @anthropic-ai/claude-code --version
```

## Running Claude Code

### Basic Usage

```powershell
# Start Claude Code in current directory
claude-code

# Or with npx
npx @anthropic-ai/claude-code
```

### With Specific Options

```powershell
# Specify a directory
claude-code /path/to/project

# With custom model
claude-code --model claude-sonnet-4-5-20250929
```

## Common Terminal Options for Windows 11

### Windows Terminal (Recommended)
- Modern, supports tabs and customization
- Download from Microsoft Store
- Best experience for Claude Code

### PowerShell 7+
- Modern PowerShell version
- Better than Windows PowerShell 5.1
- Install: `winget install Microsoft.PowerShell`

### Command Prompt
- Works but less features
- Not recommended for Claude Code

## Troubleshooting

### Node.js Not Found
```powershell
# Install Node.js using winget
winget install OpenJS.NodeJS

# Or download from https://nodejs.org
```

### Permission Errors
```powershell
# Run PowerShell as Administrator
# Or adjust execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### API Key Not Recognized
```powershell
# Verify environment variable is set
echo $env:ANTHROPIC_API_KEY

# Restart your terminal after setting environment variables
```

### npx Command Not Found
```powershell
# Ensure npm is in PATH
npm --version

# If not, add Node.js to PATH:
# System Properties > Environment Variables > Path
# Add: C:\Program Files\nodejs\
```

### Claude Code Won't Start
1. Check Node.js version: `node --version` (should be 18+)
2. Clear npm cache: `npm cache clean --force`
3. Reinstall: `npm uninstall -g @anthropic-ai/claude-code && npm install -g @anthropic-ai/claude-code`
4. Check antivirus isn't blocking the executable

## Getting an API Key

1. Go to https://console.anthropic.com
2. Sign up or log in
3. Navigate to API Keys section
4. Create a new API key
5. Copy and save it securely

## Next Steps

- Run `.\diagnose.ps1` to check your setup
- Set your API key using one of the methods above
- Start Claude Code in your project directory
- Type `/help` inside Claude Code for available commands

## Additional Resources

- Claude Code Documentation: https://docs.claude.com/en/docs/claude-code
- Anthropic API Documentation: https://docs.anthropic.com
- Troubleshooting Guide: See TROUBLESHOOTING.md
