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

Build a professional law firm website with Claude Code — no coding background required. Handles design, SEO, AEO, conversion, accessibility, security, and bar compliance by default.

---

## How It Works

```
/hc-firm-site:build
```

That's the whole workflow. One command walks you through everything:

- **Setup** — connect GitHub + Vercel, install the design skill, answer questions about your firm
- **Phase 1 — Foundation** — your custom design system + a live site on day one
- **Phase 2 — Content** — homepage, practice area pages, attorney profiles, blog
- **Phase 3 — Leads + SEO** — contact form, structured data, sitemap, AI-search optimization
- **Phase 4 — Polish + Launch** — accessibility, performance, security, bar compliance, custom domain

Each phase ends with your site updated **live** and your approval before moving on.

**It resumes automatically.** Stop anytime — close your laptop, hit a usage limit, clear the conversation. Run `/hc-firm-site:build` again and it picks up exactly where you left off (progress lives in `.planning/PROGRESS.md`).

---

## Commands

### `/hc-firm-site:build`
**The only command you need.** Builds the entire site in four phases, from empty folder to launched website. Resumable at any point.

**Usage:** `/hc-firm-site:build`

---

### `/hc-firm-site:page [type]`
**Use after launch (or anytime) to add a page.**

Creates a fully structured page — practice area, attorney profile, staff profile, or blog post — with the right content structure, SEO metadata, JSON-LD schema, and legal disclaimers baked in. Reads your `FIRM_BRIEF.md` automatically so the content is specific to your firm, and matches your existing design.

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
**Runs automatically in Phase 4 — re-run anytime after changes.**

Audits every page of the site and produces a checklist of anything that needs to be fixed. Checks for:
- Missing or incomplete legal disclaimers (footer, contact form, blog posts, practice area pages)
- Missing meta titles or descriptions
- Missing or incomplete JSON-LD structured data
- Images over 200 KB
- Practice area pages missing their own URL
- Blog posts missing author attribution
- HTTP security headers and secrets hygiene

Outputs a clear pass/fail list. Anything that fails includes a plain-English explanation of what's wrong and how to fix it.

**Usage:** `/hc-firm-site:check`

---

### `/hc-firm-site:help`
Show this reference.

**Usage:** `/hc-firm-site:help`

---

## Files Created by the Build

```
.planning/
├── PROGRESS.md                # Where the build stands — makes everything resumable
├── FIRM_BRIEF.md              # Your firm's profile — the source of truth
├── LAW_FIRM_WEBSITE_GUIDE.md  # Best practices reference
└── DECISIONS.md               # Log of decisions made during the build

.claude/
└── CLAUDE.md                  # Project-level instructions for Claude
```

---

## Common Situations

**"I lost my place / Claude seems confused"**
```
/hc-firm-site:build
```
It reads PROGRESS.md and resumes.

**"How do I change something on the live site?"**
Just describe it in plain English — Claude knows the codebase. Changes go live when committed and pushed.

**"What does commit and push mean?"**
Commit = save a snapshot of your work. Push = send it to GitHub, which automatically publishes it to your live site via Vercel.

---

## Stack

The build uses this stack — already decided, not up for debate:
- **Astro** — builds the site
- **Tailwind CSS** — styles it
- **GitHub** — version control
- **Vercel** — deployment and hosting
- **frontend-design skill** (Anthropic, official) — makes the design distinctly yours, not AI-generic
- **seo-aeo-best-practices skill** (Sanity) — expert reference for SEO, AI-search optimization, and Google's EEAT framework
- **stop-slop skill** (Hardik Pandya) — removes AI writing patterns from every piece of copy on your site
- **Contact form provider** — chosen with you in Phase 3 based on how you manage intake

---

*HeyCounsel Firm Website Builder*
*Based on the Lovable Law build — lovablelaw.com*
</reference>
