#!/usr/bin/env pwsh
# Claude Code Diagnostic Script for Windows 11
# This script checks your system for Claude Code compatibility

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Claude Code Diagnostic Tool" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$issues = @()
$warnings = @()
$success = @()

# Check Windows Version
Write-Host "[Checking Windows Version...]" -ForegroundColor Yellow
try {
    $osInfo = Get-CimInstance Win32_OperatingSystem
    $osVersion = $osInfo.Caption
    Write-Host "✓ OS: $osVersion" -ForegroundColor Green
    $success += "Windows version detected"

    if ($osInfo.Caption -notlike "*Windows 11*") {
        $warnings += "Not Windows 11 - Claude Code should still work but is optimized for Windows 11"
    }
} catch {
    $issues += "Could not detect Windows version"
    Write-Host "✗ Could not detect Windows version" -ForegroundColor Red
}
Write-Host ""

# Check PowerShell Version
Write-Host "[Checking PowerShell Version...]" -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion
Write-Host "✓ PowerShell Version: $psVersion" -ForegroundColor Green
$success += "PowerShell version: $psVersion"
if ($psVersion.Major -lt 5) {
    $issues += "PowerShell version too old (need 5.0+)"
}
Write-Host ""

# Check Node.js
Write-Host "[Checking Node.js...]" -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✓ Node.js Version: $nodeVersion" -ForegroundColor Green
        $success += "Node.js installed: $nodeVersion"

        # Extract version number
        $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
        if ($versionNumber -lt 18) {
            $warnings += "Node.js version $nodeVersion detected. Version 18+ recommended for Claude Code"
        }
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "✗ Node.js not found" -ForegroundColor Red
    $issues += "Node.js not installed or not in PATH"
    Write-Host "  Install: winget install OpenJS.NodeJS" -ForegroundColor Yellow
    Write-Host "  Or download from: https://nodejs.org" -ForegroundColor Yellow
}
Write-Host ""

# Check npm
Write-Host "[Checking npm...]" -ForegroundColor Yellow
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Host "✓ npm Version: $npmVersion" -ForegroundColor Green
        $success += "npm installed: $npmVersion"
    } else {
        throw "npm not found"
    }
} catch {
    Write-Host "✗ npm not found" -ForegroundColor Red
    $issues += "npm not installed or not in PATH"
}
Write-Host ""

# Check npx
Write-Host "[Checking npx...]" -ForegroundColor Yellow
try {
    $npxVersion = npx --version 2>$null
    if ($npxVersion) {
        Write-Host "✓ npx Version: $npxVersion" -ForegroundColor Green
        $success += "npx available: $npxVersion"
    } else {
        throw "npx not found"
    }
} catch {
    Write-Host "✗ npx not found" -ForegroundColor Red
    $warnings += "npx not found - comes with npm, may need to reinstall Node.js"
}
Write-Host ""

# Check Claude Code installation
Write-Host "[Checking Claude Code Installation...]" -ForegroundColor Yellow
try {
    $claudeCodeVersion = claude-code --version 2>$null
    if ($claudeCodeVersion) {
        Write-Host "✓ Claude Code installed: $claudeCodeVersion" -ForegroundColor Green
        $success += "Claude Code globally installed"
    } else {
        throw "Not installed globally"
    }
} catch {
    Write-Host "○ Claude Code not installed globally" -ForegroundColor Yellow
    Write-Host "  This is OK - you can use: npx @anthropic-ai/claude-code" -ForegroundColor Yellow
    Write-Host "  Or install globally: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
}
Write-Host ""

# Check API Key
Write-Host "[Checking API Key...]" -ForegroundColor Yellow
$apiKey = $env:ANTHROPIC_API_KEY
if ($apiKey) {
    $maskedKey = $apiKey.Substring(0, [Math]::Min(10, $apiKey.Length)) + "..."
    Write-Host "✓ ANTHROPIC_API_KEY is set: $maskedKey" -ForegroundColor Green
    $success += "API key configured"
} else {
    Write-Host "○ ANTHROPIC_API_KEY not set" -ForegroundColor Yellow
    $warnings += "API key not found in environment variables"
    Write-Host "  You'll need to set this to use Claude Code" -ForegroundColor Yellow
    Write-Host "  Set permanently: [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key', 'User')" -ForegroundColor Yellow
    Write-Host "  Set for session: `$env:ANTHROPIC_API_KEY = 'your-key'" -ForegroundColor Yellow
}
Write-Host ""

# Check Windows Terminal
Write-Host "[Checking Windows Terminal...]" -ForegroundColor Yellow
$wtInstalled = Get-AppxPackage -Name Microsoft.WindowsTerminal -ErrorAction SilentlyContinue
if ($wtInstalled) {
    Write-Host "✓ Windows Terminal is installed (Recommended)" -ForegroundColor Green
    $success += "Windows Terminal available"
} else {
    Write-Host "○ Windows Terminal not found" -ForegroundColor Yellow
    $warnings += "Windows Terminal not installed - recommended for best experience"
    Write-Host "  Install: winget install Microsoft.WindowsTerminal" -ForegroundColor Yellow
}
Write-Host ""

# Check internet connectivity
Write-Host "[Checking Internet Connectivity...]" -ForegroundColor Yellow
try {
    $response = Test-Connection -ComputerName anthropic.com -Count 1 -Quiet -ErrorAction Stop
    if ($response) {
        Write-Host "✓ Internet connection OK" -ForegroundColor Green
        $success += "Internet connectivity verified"
    } else {
        throw "No connection"
    }
} catch {
    Write-Host "✗ Cannot reach anthropic.com" -ForegroundColor Red
    $issues += "Internet connectivity issue - check firewall/proxy settings"
}
Write-Host ""

# Check execution policy
Write-Host "[Checking PowerShell Execution Policy...]" -ForegroundColor Yellow
$execPolicy = Get-ExecutionPolicy
Write-Host "  Current Policy: $execPolicy" -ForegroundColor Cyan
if ($execPolicy -eq "Restricted") {
    Write-Host "○ Execution policy is Restricted" -ForegroundColor Yellow
    $warnings += "PowerShell execution policy is Restricted"
    Write-Host "  May need to run: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Yellow
} else {
    Write-Host "✓ Execution policy allows script execution" -ForegroundColor Green
}
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "DIAGNOSTIC SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($issues.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "✓ ALL CHECKS PASSED!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your system is ready for Claude Code!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. If Claude Code isn't installed: npm install -g @anthropic-ai/claude-code" -ForegroundColor White
    Write-Host "2. If API key not set, configure it (see SETUP.md)" -ForegroundColor White
    Write-Host "3. Run: claude-code" -ForegroundColor White
} else {
    if ($issues.Count -gt 0) {
        Write-Host "CRITICAL ISSUES ($($issues.Count)):" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "  ✗ $issue" -ForegroundColor Red
        }
        Write-Host ""
    }

    if ($warnings.Count -gt 0) {
        Write-Host "WARNINGS ($($warnings.Count)):" -ForegroundColor Yellow
        foreach ($warning in $warnings) {
            Write-Host "  ○ $warning" -ForegroundColor Yellow
        }
        Write-Host ""
    }

    Write-Host "Refer to SETUP.md for installation instructions" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "For detailed setup instructions, see SETUP.md" -ForegroundColor Cyan
Write-Host "For troubleshooting, see TROUBLESHOOTING.md" -ForegroundColor Cyan
Write-Host ""
