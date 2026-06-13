# HC Firm Site Builder

**Build a professional law firm website using Claude Code — one command, no coding background required.**

This skill gives attorneys everything they need to build a production-quality firm website from scratch. It was developed during the construction of [Lovable Law](https://lovablelaw.com) — a real, live law firm website built by a practicing attorney with no coding experience in two days using Claude Code.

One command. Four phases. Handles design, SEO, AEO, compliance, accessibility, and security by default.

---

## What's Included

| Command | Purpose |
|---------|---------|
| `/hc-firm-site:build` | **The only command you need.** Builds the entire site in four phases — setup, foundation, content, leads + SEO, launch. Resumes automatically wherever you left off. |
| `/hc-firm-site:page` | Add any page type after launch (practice area, attorney profile, staff, blog post) |
| `/hc-firm-site:check` | The 16-point audit across compliance, SEO, security, and images — runs automatically in Phase 4, re-runnable anytime |
| `/hc-firm-site:help` | Command reference |

Also includes:
- **`reference/LAW_FIRM_WEBSITE_GUIDE.md`** — the complete best-practices reference covering StoryBrand copy, SEO/AEO for law firms, conversion principles, legal disclaimer requirements, WCAG accessibility, and bar advertising rules
- **`reference/phases/PHASE_1.md`–`PHASE_4.md`** — the four phase playbooks: the exact specs, decisions, success criteria, and known roadblocks for each phase of the build
- **`reference/DESIGN_REFERENCES.md`** — two curated style directions (Playful & Smart · Modern & Sophisticated) anchored by real law firm sites, so attorneys pick a direction instead of designing from scratch
- **Anthropic's `frontend-design` skill** — installed automatically; makes Claude design like a boutique studio instead of producing the generic "AI website" look
- **Sanity's `seo-aeo-best-practices` skill** — installed automatically; a maintained expert reference for SEO, AI answer engines (AEO), and Google's EEAT authority framework, used throughout Phases 2–4
- **Hardik Pandya's `stop-slop` skill** — installed automatically; strips AI-tell phrases and structures from every piece of copy on the site so it reads like an attorney wrote it, not ChatGPT

---

## The Full Workflow

```
/hc-firm-site:build
│
├── Setup (first run only)
│     Connect GitHub + Vercel → install design skill →
│     intake questions → FIRM_BRIEF.md + CLAUDE.md + PROGRESS.md
│
├── Phase 1 — Foundation
│     Astro + Tailwind + a custom design system you choose
│     → YOUR SITE IS LIVE on day one
│
├── Phase 2 — Content
│     Homepage, practice area pages, attorney profiles, blog
│
├── Phase 3 — Leads + SEO
│     Contact form (provider chosen with you), schema markup,
│     sitemap, FAQ sections for AI search
│
└── Phase 4 — Polish + Launch
      Accessibility, performance, security headers,
      bar compliance audit, custom domain
```

Every phase ends the same way: **commit → push → live deploy verified → your approval.** You watch your site get visibly better at every step, and nothing moves forward without your sign-off.

**Resumable by design.** Progress lives in `.planning/PROGRESS.md`. Close your laptop, hit a usage limit, clear the conversation — run `/hc-firm-site:build` again and it continues from the first unfinished step.

---

## What Gets Built

The Lovable Law build this skill is based on produced:

- Homepage with animated hero, practice areas section, team section, blog preview, and contact CTA
- Practice area pages (one per service, each with its own URL for SEO)
- Attorney and staff profile pages with JSON-LD Person schema
- Blog with Markdown-based posts, Article schema, and author attribution
- Contact modal with lead delivery to the attorney's inbox
- Structured data (LegalService, Person, FAQPage, Article) on every relevant page
- Sitemap and robots.txt
- HTTP security headers (grade A on securityheaders.com)
- Honeypot spam protection
- WCAG 2.1 AA accessibility (keyboard navigation, skip links, focus management)
- Bar compliance (attorney-client disclaimer, Attorney Advertising footer)

**Tech stack:** Astro · Tailwind CSS · GitHub · Vercel · contact form provider of your choice (decided in Phase 3)

---

## Installation

One line, in any terminal:

```bash
curl -s https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site/install.sh | bash
```

This installs the four commands, the phase playbooks, the reference guide, and both expert skills (frontend-design + seo-aeo-best-practices). Then **fully quit and reopen Claude Code** (Mac: Cmd+Q — just closing the window is not enough) so the new commands load.

Manual install (from this directory):

```bash
mkdir -p ~/.claude/commands/hc-firm-site ~/.claude/hc-firm-site/phases
cp commands/*.md ~/.claude/commands/hc-firm-site/
cp reference/LAW_FIRM_WEBSITE_GUIDE.md ~/.claude/hc-firm-site/
cp reference/phases/*.md ~/.claude/hc-firm-site/phases/
```

**No other frameworks required.** Everything the build needs ships with this skill.

---

## Usage

### Starting a new firm website

1. Create a new project folder and open it in Claude Code
2. Run `/hc-firm-site:build`
3. Follow along — the command walks you through accounts, intake, and all four phases
4. Stop and resume as many times as you want

### Adding a page after launch

```
/hc-firm-site:page practice-area
/hc-firm-site:page attorney
/hc-firm-site:page staff
/hc-firm-site:page blog
```

### Re-running the audit

```
/hc-firm-site:check
```

---

## What the Build Creates in Your Project

```
.planning/
├── PROGRESS.md                ← Where the build stands — makes it resumable
├── FIRM_BRIEF.md              ← Your firm's complete profile
├── LAW_FIRM_WEBSITE_GUIDE.md  ← Best practices reference
└── DECISIONS.md               ← Decisions made during the build, with reasoning

.claude/
└── CLAUDE.md                  ← Project configuration for Claude
```

**FIRM_BRIEF.md** captures everything about your firm: name, location, practice areas, attorney bios, target clients, positioning, fee structure, tone, and design direction. Claude reads this at the start of every session — you never have to re-explain your firm.

**CLAUDE.md** tells Claude to explain all technical concepts in plain language, reference the firm brief automatically, and enforce non-negotiables (one CTA everywhere, dedicated practice area URLs, required disclaimers, image size limits).

---

## The Expert Skills

The build installs and uses two free, expert-maintained skills:

**[Anthropic's `frontend-design` skill](https://github.com/anthropics/skills/tree/main/skills/frontend-design)** — In Phase 1, Claude reads your firm brief, develops 2–3 named design directions (typography, color system, overall feel), and lets you pick. The chosen direction is logged and honored for the rest of the build — so the result looks like *your firm*, not like every other AI-generated website.

Design proposals don't start from a blank page: during intake the attorney picks one of two curated style directions — **Playful & Smart** (Darwin Legal, Likewise Law) or **Modern & Sophisticated** (Crosby, Optimal Counsel, General Counsel, Manifest Law) — and Phase 1 grounds its proposals in that category's reference sites (`reference/DESIGN_REFERENCES.md`). Principles are borrowed, never pixels — and an attorney who wants a different direction entirely can always point at their own references instead.

**[Hardik Pandya's `stop-slop` skill](https://github.com/hardikpandya/stop-slop)** — Removes AI writing patterns from prose. A scored rubric (target 35+/50) plus reference files of banned phrases ("leverage," "robust," "in today's fast-paced world"), structural clichés (the "not just X but Y" rhythm, em-dash overuse), and before/after examples. Applied to every piece of copy in Phase 2 (homepage, practice areas, attorneys, blog) and Phase 3 (FAQ answers, meta descriptions) so the site reads like an attorney wrote it, not an AI.

**[Sanity's `seo-aeo-best-practices` skill](https://github.com/sanity-io/agent-toolkit/tree/main/skills/seo-aeo-best-practices)** — A current, maintained reference covering SEO, AEO (getting cited by AI assistants like ChatGPT and Perplexity), and Google's EEAT authority framework. Where it's used:
- **Phase 2 (Content):** the EEAT reference shapes how authority is built into the copy — named-attorney attribution, credential-specific bios, first-hand experience in blog posts. Law firms are a textbook EEAT case; this is where rankings are won.
- **Phase 3 (Leads + SEO):** the structured-data, technical-seo, and aeo-considerations references guide the JSON-LD, metadata, sitemap, and FAQ implementation. The Law Firm Website Guide says *what* a law firm site needs; this skill says *how* to implement it correctly and currently.
- **Phase 4 (Launch):** its technical SEO checklist is cross-checked during the final audit.

---

## The Audit (`/hc-firm-site:check`)

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
| P | Spam protection on contact form | Keeps bots out of your leads |

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

Claude reads the relevant sections at the start of each build phase.

---

## Background

This skill was developed alongside the construction of **Lovable Law** (lovablelaw.com) — a fictitious but fully functional AI-native law firm website built to demonstrate what's possible. The build was completed in two days by a practicing attorney with no prior coding experience, using Claude Code.

Version 2.0 collapsed the original multi-framework workflow (a separate project-management system plus four commands) into the single `/hc-firm-site:build` command, based on what tripped up attorneys in the first HeyCounsel cohort: framework installation steps, command syntax, runaway phase counts, and losing their place between sessions. The four-phase structure is the one that actually shipped Lovable Law — now encoded directly into the skill.

The full build story is documented in the *How I Built My Firm Website Using Claude Code in 2 Days* course, available through [HeyCounsel](https://heycounsel.com).

---

## Contributing

Found a bug? Want to add jurisdiction-specific compliance checks or a new page type? Pull requests welcome. See the [Contributing Guide](../../CONTRIBUTING.md) for submission standards.

---

*Built by Brian Scherer — [Lovable Law](https://lovablelaw.com) / [HeyCounsel](https://heycounsel.com)*  
*License: MIT*
