#!/usr/bin/env pwsh
# Claude Code Installation Script for Windows 11
# This script automates the installation of Claude Code

param(
    [switch]$Global,
    [switch]$SkipApiKey,
    [string]$ApiKey
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Claude Code Installation Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as admin for system-wide changes
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "✓ Running as Administrator" -ForegroundColor Green
} else {
    Write-Host "○ Not running as Administrator (OK for user installation)" -ForegroundColor Yellow
}
Write-Host ""

# Step 1: Check Node.js
Write-Host "[Step 1/5] Checking Node.js..." -ForegroundColor Cyan
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green

        $versionNumber = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
        if ($versionNumber -lt 18) {
            Write-Host "⚠ Warning: Node.js version $nodeVersion detected. Version 18+ is recommended." -ForegroundColor Yellow
            $continue = Read-Host "Continue anyway? (y/N)"
            if ($continue -ne 'y' -and $continue -ne 'Y') {
                Write-Host "Installation cancelled. Please upgrade Node.js first." -ForegroundColor Yellow
                exit 1
            }
        }
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "✗ Node.js is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Node.js first:" -ForegroundColor Yellow
    Write-Host "  Option 1: winget install OpenJS.NodeJS" -ForegroundColor White
    Write-Host "  Option 2: Download from https://nodejs.org" -ForegroundColor White
    Write-Host ""
    exit 1
}
Write-Host ""

# Step 2: Check npm
Write-Host "[Step 2/5] Checking npm..." -ForegroundColor Cyan
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Host "✓ npm is installed: $npmVersion" -ForegroundColor Green
    } else {
        throw "npm not found"
    }
} catch {
    Write-Host "✗ npm is not installed" -ForegroundColor Red
    Write-Host "npm should come with Node.js. Please reinstall Node.js." -ForegroundColor Yellow
    exit 1
}
Write-Host ""

# Step 3: Install Claude Code
Write-Host "[Step 3/5] Installing Claude Code..." -ForegroundColor Cyan

if ($Global) {
    Write-Host "Installing Claude Code globally..." -ForegroundColor Yellow
    try {
        npm install -g @anthropic-ai/claude-code
        Write-Host "✓ Claude Code installed globally" -ForegroundColor Green
    } catch {
        Write-Host "✗ Installation failed" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "○ Skipping global installation (you can use npx)" -ForegroundColor Yellow
    Write-Host "  To install globally later, run: npm install -g @anthropic-ai/claude-code" -ForegroundColor Cyan
}
Write-Host ""

# Step 4: Configure API Key
Write-Host "[Step 4/5] Configuring API Key..." -ForegroundColor Cyan

if ($SkipApiKey) {
    Write-Host "○ Skipping API key configuration (--SkipApiKey flag)" -ForegroundColor Yellow
} elseif ($ApiKey) {
    Write-Host "Setting API key from parameter..." -ForegroundColor Yellow
    try {
        [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', $ApiKey, 'User')
        $env:ANTHROPIC_API_KEY = $ApiKey
        Write-Host "✓ API key configured" -ForegroundColor Green
        Write-Host "  Note: Restart your terminal for changes to take effect" -ForegroundColor Yellow
    } catch {
        Write-Host "✗ Failed to set API key" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
    }
} else {
    $currentKey = $env:ANTHROPIC_API_KEY
    if ($currentKey) {
        Write-Host "✓ API key already configured" -ForegroundColor Green
    } else {
        Write-Host "API key not found. Would you like to set it now?" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "You can get an API key from: https://console.anthropic.com" -ForegroundColor Cyan
        Write-Host ""
        $setKey = Read-Host "Set API key now? (y/N)"

        if ($setKey -eq 'y' -or $setKey -eq 'Y') {
            $apiKeyInput = Read-Host "Enter your Anthropic API key" -MaskInput

            if ($apiKeyInput) {
                try {
                    [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', $apiKeyInput, 'User')
                    $env:ANTHROPIC_API_KEY = $apiKeyInput
                    Write-Host "✓ API key configured" -ForegroundColor Green
                    Write-Host "  Note: Restart your terminal for changes to take effect" -ForegroundColor Yellow
                } catch {
                    Write-Host "✗ Failed to set API key" -ForegroundColor Red
                    Write-Host "Error: $_" -ForegroundColor Red
                }
            } else {
                Write-Host "○ No API key provided" -ForegroundColor Yellow
            }
        } else {
            Write-Host "○ Skipping API key configuration" -ForegroundColor Yellow
            Write-Host "  You can set it later with:" -ForegroundColor Cyan
            Write-Host "  [System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', 'your-key', 'User')" -ForegroundColor White
        }
    }
}
Write-Host ""

# Step 5: Verify Installation
Write-Host "[Step 5/5] Verifying Installation..." -ForegroundColor Cyan

if ($Global) {
    try {
        $claudeVersion = claude-code --version 2>$null
        if ($claudeVersion) {
            Write-Host "✓ Claude Code is ready: $claudeVersion" -ForegroundColor Green
        } else {
            throw "Cannot verify Claude Code installation"
        }
    } catch {
        Write-Host "⚠ Could not verify Claude Code installation" -ForegroundColor Yellow
        Write-Host "  Try: claude-code --version" -ForegroundColor Yellow
    }
} else {
    Write-Host "○ Global installation skipped" -ForegroundColor Yellow
    Write-Host "  You can run Claude Code with: npx @anthropic-ai/claude-code" -ForegroundColor Cyan
}
Write-Host ""

# Final Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host ""

if ($Global) {
    Write-Host "1. Restart your terminal" -ForegroundColor White
    Write-Host "2. Navigate to your project directory" -ForegroundColor White
    Write-Host "3. Run: claude-code" -ForegroundColor White
} else {
    Write-Host "1. Navigate to your project directory" -ForegroundColor White
    Write-Host "2. Run: npx @anthropic-ai/claude-code" -ForegroundColor White
    Write-Host "3. Or install globally: npm install -g @anthropic-ai/claude-code" -ForegroundColor White
}

if (-not $env:ANTHROPIC_API_KEY) {
    Write-Host ""
    Write-Host "⚠ Remember to set your API key before using Claude Code!" -ForegroundColor Yellow
    Write-Host "  Get one from: https://console.anthropic.com" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "For help, run:" -ForegroundColor Cyan
Write-Host "  claude-code --help" -ForegroundColor White
Write-Host "  Or inside Claude Code: /help" -ForegroundColor White
Write-Host ""
Write-Host "For troubleshooting, see TROUBLESHOOTING.md" -ForegroundColor Cyan
Write-Host ""

# Usage examples
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "USAGE EXAMPLES" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "# Install globally:" -ForegroundColor Yellow
Write-Host ".\install.ps1 -Global" -ForegroundColor White
Write-Host ""
Write-Host "# Install and set API key:" -ForegroundColor Yellow
Write-Host ".\install.ps1 -Global -ApiKey 'your-api-key-here'" -ForegroundColor White
Write-Host ""
Write-Host "# Check installation without installing:" -ForegroundColor Yellow
Write-Host ".\install.ps1 -SkipApiKey" -ForegroundColor White
Write-Host ""
