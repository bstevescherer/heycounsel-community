#!/bin/bash

# HC Firm Site Builder — Installer
# Downloads the hc-firm-site commands, the four phase playbooks, the Law Firm
# Website Guide, and Anthropic's frontend-design skill into your Claude Code
# configuration directory.
#
# Usage:
#   curl -s https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site/install.sh | bash

BASE="$HOME/.claude"
RAW="https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site"
ANTHROPIC_SKILLS_RAW="https://raw.githubusercontent.com/anthropics/skills/main/skills"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  HC Firm Site Builder — Installing skills"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create directories
mkdir -p "$BASE/commands/hc-firm-site"
mkdir -p "$BASE/hc-firm-site/phases"

# Download the command files
echo "Downloading commands..."
for cmd in build check page help; do
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

# Download the four phase playbooks
echo ""
echo "Downloading phase playbooks..."
for phase in PHASE_1 PHASE_2 PHASE_3 PHASE_4; do
  url="$RAW/reference/phases/${phase}.md"
  dest="$BASE/hc-firm-site/phases/${phase}.md"
  if curl -sf "$url" -o "$dest"; then
    echo "  ✓  ${phase}.md"
  else
    echo "  ✗  ${phase}.md — download failed"
    exit 1
  fi
done

# Download the reference guides
echo ""
echo "Downloading reference guides..."
for ref in LAW_FIRM_WEBSITE_GUIDE DESIGN_REFERENCES; do
  url="$RAW/reference/${ref}.md"
  dest="$BASE/hc-firm-site/${ref}.md"
  if curl -sf "$url" -o "$dest"; then
    echo "  ✓  ${ref}.md"
  else
    echo "  ✗  ${ref}.md — download failed"
    exit 1
  fi
done

# Install Anthropic's frontend-design skill (official, free) — it makes Claude
# design websites with a real visual point of view instead of generic AI defaults.
# Skipped if already installed. Non-fatal if the download fails — the build
# command re-checks and offers to install it later.
echo ""
echo "Installing Anthropic's frontend-design skill..."
if [ -f "$BASE/skills/frontend-design/SKILL.md" ]; then
  echo "  ✓  already installed — skipping"
else
  mkdir -p "$BASE/skills/frontend-design"
  if curl -sf "$ANTHROPIC_SKILLS_RAW/frontend-design/SKILL.md" -o "$BASE/skills/frontend-design/SKILL.md"; then
    echo "  ✓  frontend-design (from anthropics/skills)"
  else
    echo "  ⚠  download failed — not a problem, the build command"
    echo "     will offer to install it again when you start."
    rm -rf "$BASE/skills/frontend-design"
  fi
fi

# Install Hardik Pandya's stop-slop skill (free, MIT) — strips AI-tell phrases
# and structures from prose. Used in Phases 2-3 when writing every line of copy
# on the site. Skipped if already installed; non-fatal on download failure.
STOP_SLOP_RAW="https://raw.githubusercontent.com/hardikpandya/stop-slop/main"
echo ""
echo "Installing the stop-slop skill (AI writing-pattern remover)..."
if [ -f "$BASE/skills/stop-slop/SKILL.md" ]; then
  echo "  ✓  already installed — skipping"
else
  mkdir -p "$BASE/skills/stop-slop/references"
  slop_ok=true
  curl -sf "$STOP_SLOP_RAW/SKILL.md" -o "$BASE/skills/stop-slop/SKILL.md" || slop_ok=false
  for ref in phrases structures examples; do
    curl -sf "$STOP_SLOP_RAW/references/${ref}.md" -o "$BASE/skills/stop-slop/references/${ref}.md" || slop_ok=false
  done
  if [ "$slop_ok" = true ]; then
    echo "  ✓  stop-slop (from hardikpandya/stop-slop)"
  else
    echo "  ⚠  download failed — not a problem, the build command"
    echo "     will offer to install it again when you start."
    rm -rf "$BASE/skills/stop-slop"
  fi
fi

# Install Sanity's seo-aeo-best-practices skill (free, general-purpose) — a
# maintained reference for SEO, AEO (AI answer engines), and Google's EEAT
# framework. Used in Phases 2-4 of the build for metadata, schema markup,
# sitemaps, and content authority. Skipped if already installed; non-fatal
# if the download fails — the build command re-checks later.
SANITY_SKILLS_RAW="https://raw.githubusercontent.com/sanity-io/agent-toolkit/main/skills/seo-aeo-best-practices"
echo ""
echo "Installing Sanity's seo-aeo-best-practices skill..."
if [ -f "$BASE/skills/seo-aeo-best-practices/SKILL.md" ]; then
  echo "  ✓  already installed — skipping"
else
  mkdir -p "$BASE/skills/seo-aeo-best-practices/references"
  seo_ok=true
  curl -sf "$SANITY_SKILLS_RAW/SKILL.md" -o "$BASE/skills/seo-aeo-best-practices/SKILL.md" || seo_ok=false
  for ref in eeat-principles structured-data technical-seo aeo-considerations; do
    curl -sf "$SANITY_SKILLS_RAW/references/${ref}.md" -o "$BASE/skills/seo-aeo-best-practices/references/${ref}.md" || seo_ok=false
  done
  if [ "$seo_ok" = true ]; then
    echo "  ✓  seo-aeo-best-practices (from sanity-io/agent-toolkit)"
  else
    echo "  ⚠  download failed — not a problem, the build command"
    echo "     will offer to install it again when you start."
    rm -rf "$BASE/skills/seo-aeo-best-practices"
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✓ Installation complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  New commands available in Claude Code:"
echo ""
echo "    /hc-firm-site:build   ← the only command you need."
echo "                            Builds your entire site in 4 phases"
echo "                            and resumes wherever you left off."
echo "    /hc-firm-site:page      add pages after launch"
echo "    /hc-firm-site:check     re-run the compliance + SEO audit"
echo "    /hc-firm-site:help      command reference"
echo ""
echo "  Next steps:"
echo "  1. Fully quit Claude Code and reopen it — just closing the window"
echo "     is not enough. Claude needs a full restart to load new commands."
echo "     Mac: Cmd+Q  |  Windows: right-click taskbar icon → Quit"
echo "  2. Open or create your firm website project folder"
echo "  3. Run /hc-firm-site:build to begin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
