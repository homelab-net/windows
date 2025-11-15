# Claude Code for Windows 11

Setup and diagnostic tools for running Claude Code CLI on Windows 11 bare metal.

## Quick Start

1. **Run Diagnostic Script** (recommended first step)
   ```powershell
   .\diagnose.ps1
   ```

2. **Install Claude Code**
   ```powershell
   # Automated installation
   .\install.ps1 -Global

   # Or manual installation
   npm install -g @anthropic-ai/claude-code
   ```

3. **Set API Key**
   ```powershell
   [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key-here', 'User')
   ```

4. **Run Claude Code**
   ```powershell
   claude-code
   ```

## Prerequisites

- Windows 11
- Node.js 18+ ([Download](https://nodejs.org))
- Anthropic API Key ([Get one](https://console.anthropic.com))

## Files in This Repository

| File | Description |
|------|-------------|
| `SETUP.md` | Complete setup guide with detailed instructions |
| `TROUBLESHOOTING.md` | Common issues and solutions |
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

## License

See repository license file for details.
