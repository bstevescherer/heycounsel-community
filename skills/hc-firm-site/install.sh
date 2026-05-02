#!/bin/bash

# HC Firm Site Builder — Installer
# Downloads all four hc-firm-site commands and the Law Firm Website Guide
# into your Claude Code skills directory.
#
# Usage:
#   curl -s https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site/install.sh | bash

BASE="$HOME/.claude"
RAW="https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  HC Firm Site Builder — Installing skills"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create directories
mkdir -p "$BASE/commands/hc-firm-site"
mkdir -p "$BASE/hc-firm-site"

# Download the four command files
echo "Downloading commands..."
for cmd in setup check page help; do
  url="$RAW/commands/${cmd}.md"
  dest="$BASE/commands/hc-firm-site/${cmd}.md"
  if curl -sf "$url" -o "$dest"; then
    echo "  ✓  ${cmd}.md"
  else
    echo "  ✗  ${cmd}.md — download failed"
    echo "     Check your internet connection and try again."
    exit 1
  fi
done

# Download the reference guide
echo ""
echo "Downloading reference guide..."
url="$RAW/reference/LAW_FIRM_WEBSITE_GUIDE.md"
dest="$BASE/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md"
if curl -sf "$url" -o "$dest"; then
  echo "  ✓  LAW_FIRM_WEBSITE_GUIDE.md"
else
  echo "  ✗  LAW_FIRM_WEBSITE_GUIDE.md — download failed"
  exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✓ Installation complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Four new commands are now available in Claude Code:"
echo ""
echo "    /hc-firm-site:setup   ← run this first"
echo "    /hc-firm-site:page"
echo "    /hc-firm-site:check"
echo "    /hc-firm-site:help"
echo ""
echo "  Next steps:"
echo "  1. Restart Claude Code so it picks up the new commands"
echo "  2. Open or create your firm website project folder"
echo "  3. Run /hc-firm-site:setup to begin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
