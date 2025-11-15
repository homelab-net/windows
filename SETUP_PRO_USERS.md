# Claude Code Setup for Windows 11 (Pro/Max Users)

**You have Claude Pro or Max? Great! You don't need an API key.**

This simplified guide is specifically for users with Claude Pro or Max subscriptions.

## What You Need

- ✅ Windows 11
- ✅ Claude Pro or Max subscription
- ✅ Node.js 18+ (we'll help you install this)

**You do NOT need:**
- ❌ Anthropic API key
- ❌ API credits
- ❌ Additional payment setup

## Installation Steps

### Step 1: Install Node.js

Open PowerShell and run:

```powershell
winget install OpenJS.NodeJS
```

**Or** download from: https://nodejs.org (get the LTS version)

After installation, **restart your terminal**.

Verify installation:
```powershell
node --version
# Should show v18 or higher
```

### Step 2: Install Claude Code

```powershell
npm install -g @anthropic-ai/claude-code
```

This will take a minute or two. Wait for it to complete.

### Step 3: Run Claude Code

```powershell
claude-code
```

**What happens next:**
1. Your web browser will open automatically
2. You'll see a login page
3. Login with your Claude Pro/Max account (same email/password you use for claude.ai)
4. Browser shows "Authentication successful"
5. Return to your terminal - Claude Code is now ready!

### Step 4: Start Using It!

That's it! You're now in Claude Code. Try typing:

```
Hello! Can you help me with my code?
```

## Usage Limits (Pro Users)

- ~10-40 prompts every 5 hours in Claude Code
- Shared with your web/mobile usage
- Same limits as using Claude on the web

## Important Warnings

### ⚠️ Don't Set an API Key!

**DO NOT** run this command:
```powershell
# DON'T DO THIS if you have Pro!
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', '...')
```

If you set an API key environment variable, Claude Code will use the API instead of your Pro subscription, and you'll be charged per token!

### Check Your Authentication Method

To verify you're using your Pro subscription (not API):

Inside Claude Code, type:
```
/status
```

It should show "Subscription" authentication, NOT "API Key".

### If You Accidentally Set an API Key

Remove it:
```powershell
[System.Environment]::SetEnvironmentVariable('ANTHROPIC_API_KEY', $null, 'User')
```

Then restart your terminal and Claude Code.

## Troubleshooting

### "Node.js not found"

1. Make sure you installed Node.js
2. **Restart your terminal** (very important!)
3. Try: `node --version`

### Browser doesn't open for authentication

1. Manually open: https://claude.ai
2. Login there first
3. Try `claude-code` again

### "Rate limit exceeded"

You've used your Pro allocation for the 5-hour window. Wait or continue using Claude on the web.

### Still having issues?

Run the diagnostic:
```powershell
.\diagnose.ps1
```

Or see the full troubleshooting guide: `TROUBLESHOOTING.md`

## Quick Commands (Inside Claude Code)

| Command | What it does |
|---------|-------------|
| `/help` | Show all available commands |
| `/status` | Check authentication method and usage |
| `/exit` | Exit Claude Code |
| `/clear` | Clear conversation history |

## Differences from Web Claude

**Same:**
- Same AI model (Sonnet 4.5)
- Same conversation quality
- Same capabilities

**Different:**
- Runs in your terminal
- Can access your local files
- Can execute commands on your computer
- Integrated with your development environment

## Next Steps

1. Navigate to a project directory:
   ```powershell
   cd C:\path\to\your\project
   ```

2. Start Claude Code there:
   ```powershell
   claude-code
   ```

3. Ask Claude to help with your code!

## Getting the Most Out of It

**Good uses:**
- Code reviews
- Bug fixes
- Writing tests
- Explaining code
- Refactoring
- Learning new concepts

**Tips:**
- Start in your project directory
- Be specific with questions
- Share relevant code files
- Use `/help` to discover features

## Need More Help?

- Full setup guide: `SETUP.md`
- Troubleshooting: `TROUBLESHOOTING.md`
- Quick reference: `QUICK_REFERENCE.md`
- Official docs: https://docs.claude.com/en/docs/claude-code

---

**Remember:** You're using your Pro subscription - no API key needed!
