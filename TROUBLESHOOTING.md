# Claude Code Troubleshooting Guide for Windows 11

This guide covers common issues when running Claude Code on Windows 11 and their solutions.

## Table of Contents

- [Installation Issues](#installation-issues)
- [API Key Issues](#api-key-issues)
- [Runtime Issues](#runtime-issues)
- [Performance Issues](#performance-issues)
- [Network Issues](#network-issues)
- [Terminal Issues](#terminal-issues)

---

## Installation Issues

### Node.js Not Found

**Symptoms:**
```
'node' is not recognized as an internal or external command
```

**Solutions:**

1. **Install Node.js:**
   ```powershell
   # Using winget
   winget install OpenJS.NodeJS

   # Or download from https://nodejs.org
   ```

2. **Add Node.js to PATH:**
   ```powershell
   # Check current PATH
   echo $env:PATH

   # Add Node.js manually (as Administrator)
   [System.Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\Program Files\nodejs\', 'Machine')

   # Restart terminal
   ```

3. **Verify installation:**
   ```powershell
   node --version
   npm --version
   ```

### npm Install Fails

**Symptoms:**
```
Error: EACCES: permission denied
Error: EPERM: operation not permitted
```

**Solutions:**

1. **Run as Administrator:**
   - Right-click PowerShell/Terminal
   - Select "Run as Administrator"
   - Retry installation

2. **Clear npm cache:**
   ```powershell
   npm cache clean --force
   npm install -g @anthropic-ai/claude-code
   ```

3. **Use a different installation location:**
   ```powershell
   # Set npm global prefix to user directory
   npm config set prefix "%APPDATA%\npm"

   # Add to PATH
   [System.Environment]::SetEnvironmentVariable('Path', $env:Path + ";$env:APPDATA\npm", 'User')
   ```

### Claude Code Command Not Found After Install

**Symptoms:**
```
'claude-code' is not recognized as an internal or external command
```

**Solutions:**

1. **Restart your terminal** (required after global install)

2. **Verify installation:**
   ```powershell
   npm list -g @anthropic-ai/claude-code
   ```

3. **Check npm global bin location:**
   ```powershell
   npm config get prefix
   # Should be in PATH
   ```

4. **Use npx instead:**
   ```powershell
   npx @anthropic-ai/claude-code
   ```

---

## API Key Issues

### API Key Not Recognized

**Symptoms:**
```
Error: Missing API key
ANTHROPIC_API_KEY environment variable not set
```

**Solutions:**

1. **Set environment variable permanently:**
   ```powershell
   # Run as Administrator or current user
   [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key-here', 'User')

   # Restart terminal
   ```

2. **Set for current session:**
   ```powershell
   $env:ANTHROPIC_API_KEY = "your-key-here"
   ```

3. **Use .env file:**
   Create `.env` in your project directory:
   ```
   ANTHROPIC_API_KEY=your-key-here
   ```

4. **Verify it's set:**
   ```powershell
   echo $env:ANTHROPIC_API_KEY
   ```

### Invalid API Key

**Symptoms:**
```
Error: Invalid API key
Authentication failed
```

**Solutions:**

1. **Verify key format:**
   - Should start with `sk-ant-`
   - Check for extra spaces or characters

2. **Generate new key:**
   - Visit https://console.anthropic.com
   - Navigate to API Keys
   - Create new key
   - Delete old key if compromised

3. **Check key permissions:**
   - Ensure key has proper permissions
   - Check if key is active

---

## Runtime Issues

### Claude Code Crashes on Start

**Symptoms:**
```
Segmentation fault
Unexpected error occurred
Process terminated
```

**Solutions:**

1. **Check Node.js version:**
   ```powershell
   node --version
   # Should be v18 or higher
   ```

2. **Update Node.js:**
   ```powershell
   winget upgrade OpenJS.NodeJS
   ```

3. **Reinstall Claude Code:**
   ```powershell
   npm uninstall -g @anthropic-ai/claude-code
   npm cache clean --force
   npm install -g @anthropic-ai/claude-code
   ```

4. **Check antivirus/firewall:**
   - Temporarily disable to test
   - Add exception for Node.js/claude-code

### Command Execution Fails

**Symptoms:**
```
Error executing command
Permission denied
```

**Solutions:**

1. **Check execution policy:**
   ```powershell
   Get-ExecutionPolicy

   # If Restricted, change it
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **Run as Administrator:**
   - For system-level commands
   - Or adjust permissions on target directories

3. **Check file permissions:**
   ```powershell
   # Check current directory permissions
   Get-Acl . | Format-List
   ```

### Cannot Read/Write Files

**Symptoms:**
```
EACCES: permission denied
Cannot read file
```

**Solutions:**

1. **Check directory permissions:**
   ```powershell
   # Take ownership of directory
   takeown /f "C:\path\to\directory" /r /d y

   # Grant permissions
   icacls "C:\path\to\directory" /grant $env:USERNAME:(OI)(CI)F /t
   ```

2. **Avoid system directories:**
   - Don't run in C:\Windows, C:\Program Files
   - Use user directories like Documents, Desktop

3. **Check if files are locked:**
   - Close other applications
   - Check Task Manager for processes

---

## Performance Issues

### Slow Response Times

**Solutions:**

1. **Check internet connection:**
   ```powershell
   Test-Connection anthropic.com
   ```

2. **Use faster model:**
   ```powershell
   claude-code --model claude-haiku-4-0
   ```

3. **Check system resources:**
   ```powershell
   # Open Task Manager
   taskmgr
   # Check CPU, Memory, Disk usage
   ```

4. **Close unnecessary applications**

### High Memory Usage

**Solutions:**

1. **Limit context size:**
   - Work in smaller directories
   - Use `.claudeignore` to exclude files

2. **Restart Claude Code periodically:**
   - Long sessions can accumulate memory
   - Exit and restart

3. **Check for memory leaks:**
   ```powershell
   # Monitor Node.js processes
   Get-Process node
   ```

---

## Network Issues

### Cannot Connect to Anthropic API

**Symptoms:**
```
Network error
Connection timeout
ECONNREFUSED
```

**Solutions:**

1. **Check internet connection:**
   ```powershell
   Test-Connection anthropic.com -Count 4
   ```

2. **Check firewall:**
   ```powershell
   # Add firewall rule for Node.js
   New-NetFirewallRule -DisplayName "Node.js" -Direction Outbound -Program "C:\Program Files\nodejs\node.exe" -Action Allow
   ```

3. **Configure proxy (if behind corporate proxy):**
   ```powershell
   # Set npm proxy
   npm config set proxy http://proxy.company.com:8080
   npm config set https-proxy http://proxy.company.com:8080

   # Set environment variables
   $env:HTTP_PROXY = "http://proxy.company.com:8080"
   $env:HTTPS_PROXY = "http://proxy.company.com:8080"
   ```

4. **Check DNS:**
   ```powershell
   nslookup anthropic.com
   ```

### SSL Certificate Errors

**Symptoms:**
```
SSL certificate error
CERT_INVALID
```

**Solutions:**

1. **Update Windows certificates:**
   ```powershell
   # Update root certificates
   certutil -generateSSTFromWU roots.sst
   ```

2. **Check system time:**
   ```powershell
   # Verify time is correct
   Get-Date

   # Sync time
   w32tm /resync
   ```

3. **For corporate environments:**
   ```powershell
   # May need to install corporate CA certificates
   # Contact IT department
   ```

---

## Terminal Issues

### Unicode/Character Display Issues

**Symptoms:**
- Garbled characters
- Boxes instead of text
- Missing symbols

**Solutions:**

1. **Use Windows Terminal:**
   ```powershell
   winget install Microsoft.WindowsTerminal
   ```

2. **Set UTF-8 encoding:**
   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   chcp 65001
   ```

3. **Install better fonts:**
   - Cascadia Code (comes with Windows Terminal)
   - JetBrains Mono
   - Fira Code

### Colors Not Displaying

**Solutions:**

1. **Enable ANSI colors:**
   ```powershell
   # In Windows Terminal, colors work by default
   # In older terminals, may need to enable
   $env:FORCE_COLOR = "1"
   ```

2. **Use Windows Terminal:**
   - Best color support
   - Modern terminal emulator

### Copy/Paste Not Working

**Solutions:**

1. **Windows Terminal:**
   - Ctrl+Shift+C to copy
   - Ctrl+Shift+V to paste
   - Or enable "Paste on right-click"

2. **PowerShell:**
   - Right-click to paste
   - Select text, then right-click to copy

---

## Getting Help

If these solutions don't resolve your issue:

1. **Run diagnostic script:**
   ```powershell
   .\diagnose.ps1
   ```

2. **Check Claude Code documentation:**
   - https://docs.claude.com/en/docs/claude-code

3. **Report issues:**
   - GitHub: https://github.com/anthropics/claude-code/issues

4. **Community resources:**
   - Discord: Anthropic community
   - Forums: https://support.anthropic.com

---

## Quick Fixes Checklist

When something isn't working, try these in order:

- [ ] Restart terminal
- [ ] Check Node.js version (`node --version`)
- [ ] Verify API key is set (`echo $env:ANTHROPIC_API_KEY`)
- [ ] Clear npm cache (`npm cache clean --force`)
- [ ] Check internet connection (`Test-Connection anthropic.com`)
- [ ] Run diagnostic script (`.\diagnose.ps1`)
- [ ] Reinstall Claude Code
- [ ] Restart computer
- [ ] Check Windows Updates
- [ ] Review this troubleshooting guide

---

## Advanced Debugging

### Enable Debug Logging

```powershell
# Set debug environment variable
$env:DEBUG = "*"

# Run Claude Code
claude-code
```

### Check Node.js Modules

```powershell
# List global packages
npm list -g --depth=0

# Check for conflicting packages
npm outdated -g
```

### System Information

```powershell
# Collect system info for bug reports
systeminfo
node --version
npm --version
$PSVersionTable
```
