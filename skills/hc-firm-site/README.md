# HC Firm Site Builder

**Build a professional law firm website using Claude Code — no coding background required.**

This skill set gives attorneys everything they need to build a production-quality firm website from scratch. It was developed during the construction of [Lovable Law](https://lovablelaw.com) — a real, live law firm website built by a practicing attorney with no coding experience in two days using Claude Code.

Four commands. One clear workflow. Handles SEO, AEO, compliance, accessibility, and security by default.

---

## What's Included

| Command | Purpose |
|---------|---------|
| `/hc-firm-site:setup` | Run once at the start — gathers firm info, writes the firm brief, configures Claude |
| `/hc-firm-site:page` | Create any page type (practice area, attorney profile, staff, blog post) |
| `/hc-firm-site:check` | Pre-launch audit — 16 checks across compliance, SEO, security, and images |
| `/hc-firm-site:help` | Command reference |

Also includes:
- **`reference/LAW_FIRM_WEBSITE_GUIDE.md`** — the complete best-practices reference covering StoryBrand copy, SEO/AEO for law firms, conversion principles, legal disclaimer requirements, WCAG accessibility, and bar advertising rules

---

## The Full Workflow

```
/hc-firm-site:setup
  └── Creates FIRM_BRIEF.md, .claude/CLAUDE.md, LAW_FIRM_WEBSITE_GUIDE.md

/gsd:new-project --auto @.planning/FIRM_BRIEF.md
  └── Creates PROJECT.md, REQUIREMENTS.md, ROADMAP.md

For each build phase:
  /gsd:discuss-phase 1   → CONTEXT.md  (your decisions for this phase)
  /gsd:plan-phase 1      → PLAN.md     (step-by-step build instructions)
  /gsd:execute-phase 1   → Working code
  /gsd:verify-work       → VERIFICATION.md

Before launch:
  /hc-firm-site:check    → 16-point audit (pass all before going live)
```

These skills sit on top of the [GSD framework](https://github.com/anthropics/get-shit-done). GSD handles project management, phase planning, execution, and verification. The `/hc-firm-site:` skills handle law-firm-specific context, content principles, and compliance requirements.

---

## What Gets Built

The Lovable Law build this skill is based on produced:

- Homepage with animated hero, practice areas section, team section, blog preview, and contact CTA
- Practice area pages (one per service, each with its own URL for SEO)
- Attorney and staff profile pages with JSON-LD Person schema
- Blog with Markdown-based posts, Article schema, and author attribution
- Contact modal with Supabase lead storage and Resend email notifications
- Structured data (LegalService, Person, FAQPage, Article) on every relevant page
- Sitemap and robots.txt
- HTTP security headers (grade A on securityheaders.com)
- Honeypot spam protection
- Supabase Row Level Security
- WCAG 2.1 AA accessibility (keyboard navigation, skip links, focus management)
- Bar compliance (attorney-client disclaimer, Attorney Advertising footer)

**Tech stack used:** Astro 6 · Tailwind CSS v4 · Vercel · Supabase · Resend · GitHub

---

## Installation

### Install all four commands at once

```bash
# From this directory:
mkdir -p ~/.claude/commands/hc-firm-site
cp commands/setup.md ~/.claude/commands/hc-firm-site/setup.md
cp commands/check.md ~/.claude/commands/hc-firm-site/check.md
cp commands/page.md  ~/.claude/commands/hc-firm-site/page.md
cp commands/help.md  ~/.claude/commands/hc-firm-site/help.md

# Copy the reference guide to Claude's data folder
mkdir -p ~/.claude/hc-firm-site
cp reference/LAW_FIRM_WEBSITE_GUIDE.md ~/.claude/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md
```

Or clone this repo and run the install script if one is provided.

### Prerequisite: GSD

These skills require the [GSD (Get Shit Done) framework](https://github.com/anthropics/get-shit-done) to be installed. `/hc-firm-site:setup` checks for GSD automatically and walks you through installation if it's missing.

---

## Usage

### Starting a new firm website

1. Create a new project folder and open it in Claude Code
2. Run `/hc-firm-site:setup` — Claude will ask ~15 questions about your firm
3. Run `/gsd:new-project --auto @.planning/FIRM_BRIEF.md` to generate the build plan
4. Work through each phase with `plan-phase` → `execute-phase` → `verify-work`
5. Use `/hc-firm-site:page` anytime to create specific pages
6. Run `/hc-firm-site:check` before launch

### Adding a page to an existing build

```
/hc-firm-site:page practice-area
/hc-firm-site:page attorney
/hc-firm-site:page staff
/hc-firm-site:page blog
```

### Pre-launch audit

```
/hc-firm-site:check
```

Runs 16 automated checks. Every check must pass before going live.

---

## What `/hc-firm-site:setup` Creates

```
.planning/
├── FIRM_BRIEF.md              ← Your firm's complete profile
└── LAW_FIRM_WEBSITE_GUIDE.md  ← Best practices reference

.claude/
└── CLAUDE.md                  ← Project configuration for Claude
```

**FIRM_BRIEF.md** captures everything about your firm: name, location, practice areas, attorney bios, target clients, positioning, fee structure, tone, and design direction. Claude reads this at the start of every session — you never have to re-explain your firm.

**CLAUDE.md** tells Claude to explain all technical concepts in plain language, reference the firm brief automatically, and enforce non-negotiables (one CTA everywhere, dedicated practice area URLs, required disclaimers, image size limits).

---

## The Pre-Launch Checklist (`/hc-firm-site:check`)

| # | Check | Why It Matters |
|---|-------|---------------|
| A | Footer disclaimer on all pages | Required for bar compliance in most jurisdictions |
| B | Contact form disclaimer | Protects against inadvertent attorney-client relationships |
| C | Blog post disclaimers | Required disclaimer for legal content |
| D | Practice area page disclaimers | Required for specific legal service descriptions |
| E | Meta titles on all pages | Core SEO — each page needs a unique, descriptive title |
| F | Meta descriptions on all pages | Controls how pages appear in search results |
| G | LegalService JSON-LD on homepage | Helps AI search engines understand what the firm does |
| H | FAQPage JSON-LD on practice area pages | AEO — gets practice area content cited by AI tools |
| I | Person JSON-LD on attorney pages | Establishes attorney identity for search and AI |
| J | Article JSON-LD on blog posts | Content attribution and AI citation eligibility |
| K | No images over 200 KB | Page speed — directly affects Google PageSpeed score |
| L | One page per practice area | SEO — each service needs its own URL to rank independently |
| M | Blog post author attribution | Credibility signal for both search engines and AI tools |
| N | HTTP security headers | Prevents clickjacking, MIME sniffing, and other common attacks |
| O | No secrets in source code or git | Prevents API key exposure — critical failure if not met |
| P | Spam protection on contact form | Keeps bots out of your leads database |

---

## Reference: Law Firm Website Guide

The `reference/LAW_FIRM_WEBSITE_GUIDE.md` file included in this skill covers:

- **StoryBrand framework** — why client-as-hero converts better than credential-first copy
- **SEO fundamentals** — practice area page structure, URL strategy, keyword targeting
- **AEO (Answer Engine Optimization)** — how to get cited by AI tools like ChatGPT and Perplexity
- **Conversion principles** — one CTA, pricing transparency, trust signals for B2B clients
- **Legal disclaimer requirements** — what goes where and why
- **Bar advertising rules** — New York requirements (with notes on how most state bars compare)
- **Business lawyer-specific guidance** — tone, client naming, what corporate clients actually search for
- **WCAG 2.1 AA accessibility** — what compliance requires and how to build it in from the start

This document feeds into GSD's planning process via the `--auto` flag on `/gsd:new-project`.

---

## Background

This skill set was developed alongside the construction of **Lovable Law** (lovablelaw.com) — a fictitious but fully functional AI-native law firm website built to demonstrate what's possible. The build was completed in two days by a practicing attorney with no prior coding experience, using Claude Code and the GSD framework.

The skills encode everything learned during that build: the decisions that had to be made, the mistakes that were corrected, and the best practices that produced a fast, secure, compliant, and SEO-optimized result.

The full build story is documented in the *How I Built My Firm Website Using Claude Code in 2 Days* course, available through [HeyCounsel](https://heycounsel.com).

---

## Contributing

Found a bug? Want to add jurisdiction-specific compliance checks or a new page type? Pull requests welcome. See the [Contributing Guide](../../CONTRIBUTING.md) for submission standards.

---

*Built by Brian Scherer — [Lovable Law](https://lovablelaw.com) / [HeyCounsel](https://heycounsel.com)*  
*License: MIT*
