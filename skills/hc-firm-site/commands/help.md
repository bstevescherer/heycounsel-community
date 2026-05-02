---
name: hc-firm-site:help
description: Show the HeyCounsel firm website builder command reference
allowed-tools: []
---

<purpose>
Display the complete hc-firm-site command reference. Output ONLY the reference content below — no additional commentary, analysis, or next-step suggestions.
</purpose>

<reference>
# HeyCounsel — Firm Website Builder

A set of Claude Code skills for building a professional law firm website using proven best practices for SEO, AEO, conversion, and legal compliance. Designed for attorneys with no coding background.

Built on top of the GSD framework. These skills prepare your context and guide you — GSD handles the actual project planning and execution.

---

## How It Works

```
/hc-firm-site:setup   →   /gsd:new-project --auto @.planning/FIRM_BRIEF.md   →   /gsd:plan-phase 1   →   /gsd:execute-phase 1
```

Run `/hc-firm-site:setup` once before anything else. It gathers your firm's information, creates all the context files, and configures Claude to communicate at the right level for a non-technical attorney. Then GSD takes over for planning and building — with all your firm context already loaded.

Use `/hc-firm-site:page` anytime during the build to create a specific page. Use `/hc-firm-site:check` before launch to verify everything is in order.

---

## Commands

### `/hc-firm-site:setup`
**Run this first — before `/gsd:new-project`.**

Gathers your firm's information through a short intake conversation, then creates three things:
- `FIRM_BRIEF.md` — your firm's complete profile (name, location, practice areas, attorneys, target clients, pricing, tone)
- `LAW_FIRM_WEBSITE_GUIDE.md` — best practices reference covering StoryBrand, SEO/AEO, conversion, and legal disclaimers
- `.claude/CLAUDE.md` — project configuration that tells Claude to explain technical concepts in plain English and reference your firm's documents automatically throughout every session

Ends with the exact command to run next.

**Usage:** `/hc-firm-site:setup`

---

### `/hc-firm-site:page [type]`
**Use during the build when creating specific pages.**

Creates a fully structured page for your firm website — practice area page, attorney profile, staff profile, or blog post — with the right content structure, SEO metadata, JSON-LD schema, and legal disclaimers baked in. Reads your `FIRM_BRIEF.md` automatically so the content is specific to your firm, not generic.

**Page types:**
- `practice-area` — Full practice area page with FAQ schema, SEO meta, disclaimer
- `attorney` — Attorney profile with bar admission, areas of focus, education, schema
- `staff` — Non-attorney staff profile (ops, intake, etc.) with appropriate structure
- `blog` — Blog post with proper author attribution, schema, and disclaimer

**Usage:**
```
/hc-firm-site:page practice-area
/hc-firm-site:page attorney
/hc-firm-site:page staff
/hc-firm-site:page blog
```

---

### `/hc-firm-site:check`
**Run before launch.**

Audits every page of the site and produces a checklist of anything that needs to be fixed before going live. Checks for:
- Missing or incomplete legal disclaimers (footer, contact form, blog posts, practice area pages)
- Missing meta titles or descriptions
- Missing or incomplete JSON-LD structured data
- Images over 200 KB
- Practice area pages missing their own URL
- Blog posts missing author attribution
- Contact form missing attorney-client disclaimer

Outputs a clear pass/fail list. Anything that fails includes a plain-English explanation of what's wrong and how to fix it.

**Usage:** `/hc-firm-site:check`

---

### `/hc-firm-site:help`
Show this reference.

**Usage:** `/hc-firm-site:help`

---

## Files Created by These Skills

```
.planning/
├── FIRM_BRIEF.md              # Your firm's profile — the source of truth
├── LAW_FIRM_WEBSITE_GUIDE.md  # Best practices reference
├── DECISIONS.md               # Log of decisions made during the build
└── (GSD files created by /gsd:new-project)
    ├── PROJECT.md
    ├── REQUIREMENTS.md
    ├── ROADMAP.md
    └── STATE.md

.claude/
└── CLAUDE.md                  # Project-level instructions for Claude
```

---

## The Full Workflow

**Starting a new firm website:**
```
/hc-firm-site:setup
/gsd:new-project --auto @.planning/FIRM_BRIEF.md
/gsd:plan-phase 1
/gsd:execute-phase 1
(repeat plan/execute for each phase)
/hc-firm-site:check
/gsd:verify-work
```

**Creating a specific page during the build:**
```
/hc-firm-site:page practice-area
```

**Resuming work after a break:**
```
/gsd:progress
```

**Checking where you are:**
```
/gsd:progress
```

---

## Stack

These skills assume the following stack — already decided, not up for debate:
- **Astro 6** — builds the site
- **Tailwind CSS v4** — styles it
- **GitHub** — version control
- **Vercel** — deployment
- **Supabase** — contact form lead storage
- **Resend** — email notifications

---

*HeyCounsel Firm Website Builder — built on the GSD framework*
*Based on the Lovable Law build — lovablelaw.com*
</reference>
