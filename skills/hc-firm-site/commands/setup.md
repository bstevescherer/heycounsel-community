---
name: hc-firm-site:setup
description: Set up a new firm website project — installs GSD if needed, gathers firm info, and configures Claude for a non-technical attorney
allowed-tools:
  - Bash
  - Read
  - Write
  - AskUserQuestion
---

<objective>
Prepare everything needed to build a law firm website using the HeyCounsel method.

This skill runs ONCE before anything else. It:
1. Verifies GSD is installed (and walks through installation if not)
2. Asks ~15 intake questions about the firm
3. Writes FIRM_BRIEF.md — the source of truth for everything that gets built
4. Copies LAW_FIRM_WEBSITE_GUIDE.md into the project
5. Writes .claude/CLAUDE.md — configures Claude to communicate at the right level and reference the right documents throughout every session
6. Ends with the exact command to run next

After this skill completes, run:
/gsd:new-project --auto @.planning/FIRM_BRIEF.md
</objective>

<process>

## Step 1 — Check if GSD is installed

Run this check:

```bash
if [ -f "$HOME/.claude/get-shit-done/VERSION" ] && [ -d "$HOME/.claude/commands/gsd" ]; then
  echo "INSTALLED: $(cat $HOME/.claude/get-shit-done/VERSION)"
else
  echo "NOT_INSTALLED"
fi
```

**If output starts with INSTALLED:**
Show this message and continue to Step 3:

```
✓ GSD is installed (version X.X.X)
```

**If output is NOT_INSTALLED:**
Continue to Step 2.

---

## Step 2 — Install GSD (only if not installed)

GSD is not installed. Explain it and walk through installation before continuing.

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  First: Let's install GSD
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before we set up your firm website project, we need
to install a tool called GSD (Get Shit Done).

GSD is a planning and project management framework
for Claude Code. Think of it like a project manager
that lives inside Claude — it helps break the
website build into organized phases, tracks what's
been done, and makes sure nothing gets missed.

We'll install it now. It takes about 30 seconds.
```

Use AskUserQuestion:
- Question: "Ready to install GSD?"
- Options: ["Yes, install it", "No, I'll do it later"]

**If user says no:** Show this and exit:
```
No problem. When you're ready, install GSD by running
this command in your terminal:

  npx -y get-shit-done-cc@latest --global

Then restart Claude Code and run /hc-firm-site:setup again.
```

**If user says yes:** Run:
```bash
npx -y get-shit-done-cc@latest --global
```

After running, verify it worked:
```bash
if [ -f "$HOME/.claude/get-shit-done/VERSION" ] && [ -d "$HOME/.claude/commands/gsd" ]; then
  echo "SUCCESS: $(cat $HOME/.claude/get-shit-done/VERSION)"
else
  echo "FAILED"
fi
```

**If SUCCESS:** Show this and EXIT — the user MUST restart before continuing:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ GSD installed successfully (version X.X.X)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

One more step: restart Claude Code so it picks up
the new GSD commands.

  → Close this window
  → Reopen Claude Code in your project folder
  → Run /hc-firm-site:setup again to continue

You only have to do this once.
```

**If FAILED:** Show this and exit:
```
Something went wrong with the GSD installation.
This sometimes happens if Node.js isn't installed.

Try opening your terminal app (not Claude Code) and running:
  npx -y get-shit-done-cc@latest --global

If you see an error about "node" or "npm", you may need to
install Node.js first at: https://nodejs.org (click "LTS Download")

Then restart Claude Code and run /hc-firm-site:setup again.
```

---

## Step 3 — Check project state

Check if this project already has a FIRM_BRIEF.md:

```bash
[ -f ".planning/FIRM_BRIEF.md" ] && echo "EXISTS" || echo "NEW"
```

**If EXISTS:** Use AskUserQuestion:
- Question: "A FIRM_BRIEF.md already exists in this project. What would you like to do?"
- Options:
  - "Start fresh — overwrite everything"
  - "Cancel — keep what I have"

If cancel: exit.
If start fresh: continue to Step 4.

**If NEW:** Continue to Step 4.

---

## Step 4 — Create project folders

```bash
mkdir -p .planning
mkdir -p .claude
```

---

## Step 5 — Confirm the tech stack

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Your tech stack
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

We have a recommended set of tools for building your
firm website. Each one was chosen for a specific
reason — here's what they are and why:

  Astro 6        Builds the site. Produces pages that
                 load extremely fast and score well on
                 Google — critical for SEO. Purpose-
                 built for content sites like this one.

  Tailwind CSS   Handles all the styling (colors,
                 fonts, spacing, layout). Works hand-
                 in-hand with Astro and keeps the
                 design consistent across every page.

  GitHub         Your version control system — think
                 of it as a "save history" for every
                 change made to your site. Free, and
                 connects directly to Vercel.

  Vercel         Publishes your site to the internet.
                 Every time you push a change to
                 GitHub, Vercel automatically deploys
                 it live. Free tier covers everything
                 a firm website needs.

  Supabase       A database that stores every contact
                 form submission. So even if an email
                 notification gets missed, your leads
                 are always saved somewhere safe.

  Resend         Sends you an email notification the
                 moment someone fills out your contact
                 form. Simple, reliable, free to start.

This stack is battle-tested, free at the scale of a
law firm website, and produces a fast, professional
result. We strongly recommend using all of it as-is.
```

Use AskUserQuestion:
- Question: "Would you like to use this stack as recommended, or swap anything out? If you'd like to make changes, describe what you'd prefer and why — we'll adjust before building."
- Options:
  - "Use the recommended stack — let's go"
  - "I'd like to swap something out"

**If they want to swap something out:**
Ask them what they'd like to change and why. Accept their preference, note the substitution, and update the CLAUDE.md in Step 8 to reflect it. Continue to Step 6.

**If they accept the recommended stack:**
Show:
```
✓ Stack confirmed. All six tools will be used.
```
Continue to Step 6.

---

## Step 6 — Intake questions

Show this message before starting:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Let's set up your firm
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

I'm going to ask you about your firm in five groups
of questions. Your answers will be saved into a
FIRM_BRIEF.md file that Claude will reference
throughout the entire website build.

The more specific you are, the better the site will
match your firm. There are no wrong answers — just
describe things as you would to a colleague.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  How your copy will be written
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

All website copy will follow the StoryBrand framework
— a proven approach to writing that converts visitors
into clients.

The core idea: your CLIENT is the hero of the story,
not your firm. Most law firm websites lead with the
firm's credentials, awards, and history. StoryBrand
flips this — it leads with the client's problem,
positions the firm as a trusted guide, and gives the
visitor a clear path to getting help.

Why it works for law firms specifically:
  → Clients visit your site when they have a problem.
    They want to know you understand it — fast.
  → Legal websites that lead with "we are experienced
    attorneys" convert worse than ones that lead with
    "you're dealing with X — here's how we help."
  → The framework gives every section of the site a
    single job: move the visitor one step closer to
    getting in touch.

Your answers to the questions below will help Claude
write copy that follows this structure automatically.
The better you describe your clients' problems and
fears, the better the copy will be.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  💡 Tip: use dictation to answer faster
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Speaking your answers out loud is 3–4x faster than
typing and tends to capture more useful detail.

  Mac:           Press Fn twice to start dictating
  iPhone/iPad:   Tap the microphone icon on the keyboard
  Windows:       Press Win + H

Just talk through each question as if explaining it
to a colleague. Claude will organize it automatically.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Ask each group conversationally — output the question as a normal message and wait for the response before moving to the next group. Do not use AskUserQuestion for these — the questions are too detailed for a popup dialog.

---

**Group 1 of 5 — The Firm**

Say:

"Let's start with the basics. Please answer these questions about your firm:

1. What is your firm's full name?
2. What city and state is the firm based in?
3. What are your primary practice areas? List all of them.
   (Examples: Corporate Law, M&A, Contracts, Employment, Regulatory, Real Estate, IP, etc.)
4. Do you have a tagline or short description of what makes your firm different?
   (If not, just say "none" — we can develop this together)

You can answer as a numbered list or just talk through them however is easiest."

Wait for the response, then continue.

---

**Group 2 of 5 — The Team**

Say:

"Now tell me about your team. For each attorney, please share:

- Full name and title (e.g., Managing Partner, Senior Associate)
- Bar admission (state and year, e.g., "New York State Bar, 2015")
- Areas of focus within the firm
- Education (law school + undergraduate, if you want it on the site)
- A few sentences about their background or what they're known for

For any non-attorney staff you want featured on the site (e.g., operations, intake, paralegal):
- Full name and title
- A brief description of their role

If it's just you for now, that's completely fine — just describe yourself."

Wait for the response, then continue.

---

**Group 3 of 5 — Your Clients**

Say:

"Help me understand who you serve:

1. Who is your ideal client?
   (Be specific: e.g., "Series A and B startups in tech", "founder-owned businesses with $5M–$50M in revenue", "PE-backed companies going through M&A")

2. What is the main legal problem they come to you to solve?

3. What do your clients typically worry about before hiring a lawyer?
   (e.g., cost surprises, slow response times, getting passed to junior associates)

4. How do clients usually find you right now?
   (referrals, LinkedIn, former colleagues, etc.)"

Wait for the response, then continue.

---

**Group 4 of 5 — Positioning and Pricing**

Say:

"A few questions about how you position the firm:

1. Do you offer flat fees, hourly billing, or both?
   If flat fees: what are some examples with prices?
   (e.g., "LLC formation $1,500", "contract review from $750")
   If hourly: what is your rate or range?

2. What do you do differently from other firms your clients might consider?

3. How would you describe the firm's tone and personality?
   (e.g., "formal and precise", "direct and no-nonsense", "approachable and plain-speaking")"

Wait for the response, then continue.

---

**Group 5 of 5 — Design and Existing Presence**

Say:

"Last group — a few questions about the look and feel:

1. Do you have any websites you admire visually?
   These don't have to be law firms — any industry.
   Share URLs if you can, or just describe what you like about them.

2. Do you have any brand colors, or a color direction you prefer?
   (e.g., "dark and serious", "clean and minimal", "navy and gold", "I have no preference")

3. Do you have an existing website? If yes, what is the URL?

4. Do you have professional headshots ready for the attorneys?
   (Yes / No / Some of them)

5. Is there anything else about the firm, your clients, or the website that you want Claude to know before we start building?"

Wait for the response, then continue to Step 7.

---

## Step 7 — Write FIRM_BRIEF.md

Using all the answers collected, write `.planning/FIRM_BRIEF.md` in this format:

```markdown
# Firm Brief — [Firm Name]

*Generated by /hc-firm-site:setup. This document is the source of truth for
the website build. Claude reads it automatically at the start of every session.*

---

## The Firm

**Name:** [firm name]
**Location:** [city, state]
**Practice Areas:** [list]
**Tagline / Differentiator:** [their answer or "to be developed"]

---

## The Team

### Attorneys

[For each attorney:]
**[Name]** — [Title]
- Bar: [bar admission]
- Focus: [areas of focus]
- Education: [education]
- Background: [background notes]

### Staff

[For each non-attorney staff member:]
**[Name]** — [Title]
- Role: [description]

---

## The Clients

**Ideal client:** [their description]
**Primary problem they solve:** [their answer]
**Client fears / objections:** [their answer]
**How clients currently find the firm:** [their answer]

---

## Positioning

**Fee structure:** [flat / hourly / both + specifics]
**Key differentiator:** [their answer]
**Tone and personality:** [their answer]

---

## Design Direction

**Visual references:** [URLs or descriptions]
**Color direction:** [their answer]
**Existing website:** [URL or none]
**Headshots ready:** [yes / no / some]

---

## Additional Context

[Anything from the "anything else" answer, or "None provided."]

---

## Security & Compliance Requirements

*These are non-negotiable for a law firm website. GSD must include a dedicated
security phase in the project plan to address each of these before launch.*

- **HTTP security headers** — configured in `vercel.json`: Content-Security-Policy,
  X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy
- **Secrets management** — all API keys stored as Vercel environment variables only;
  never hardcoded in source files or committed to git
- **Git hygiene** — `.env` and `.env.local` files excluded from git via `.gitignore`
- **Supabase Row Level Security** — RLS enabled on all database tables (including leads)
- **Server-side input validation** — contact form validated on the server, not just
  the browser; malformed submissions rejected before reaching the database
- **Spam protection** — honeypot field on the contact form at minimum; rate limiting
  recommended for production
- **No sensitive data in built output** — verify the compiled `dist/` folder contains
  no API keys, service keys, or credentials
- **ABA Formal Opinion 477R compliance** — attorneys have a professional responsibility
  to protect the confidentiality of client communications, including pre-engagement
  inquiries submitted via web forms; the contact form, data storage, and notification
  system must meet this standard
- **Pre-launch security audit** — run `/hc-firm-site:check` before going live; the
  Security section of that audit must fully pass

---

## Build Notes

*This brief feeds directly into `/gsd:new-project --auto`. GSD will read this
document and create the full project plan — practice area pages, attorney profiles,
blog system, contact form, SEO, and security — based on what's here.*
```

---

## Step 8 — Copy LAW_FIRM_WEBSITE_GUIDE.md into the project

Read the guide from the skill's own folder and write it into the project:

```bash
cp "$HOME/.claude/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md" ".planning/LAW_FIRM_WEBSITE_GUIDE.md"
```

If the copy fails for any reason, note it but continue — it's not a blocker.

---

## Step 9 — Write .claude/CLAUDE.md

Write `.claude/CLAUDE.md` with the following content, substituting the firm name and practice areas from the brief:

```markdown
# [Firm Name] — Website Project

This project is building a law firm website for [Firm Name], a [practice areas]
firm based in [city, state]. The person working on this project is a practicing
attorney with no coding background.

---

## How to Communicate

Treat every technical concept as if you're explaining it for the very first time.
Specifically:

- **Before running any command**, explain in one sentence what it does and why
- **When errors occur**, explain what went wrong in plain English before attempting to fix it
- **When introducing a new tool or concept**, give a simple real-world analogy
- **Keep explanations short** — one concept at a time, not a wall of context
- **Never assume prior knowledge** of code, terminal commands, file structures, or web development

---

## Always Read Before Starting Work

At the beginning of every session, read these files:

- `.planning/FIRM_BRIEF.md` — the firm's complete profile, team, clients, and positioning
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — best practices for law firm websites (SEO, AEO, conversion, disclaimers, StoryBrand)

Every content, copy, and SEO decision should be consistent with these documents.

---

## Tech Stack — Already Decided

Do not suggest alternatives. The stack for this project is:

- **Astro 6** — builds the site
- **Tailwind CSS v4** — styles it
- **GitHub** — version control
- **Vercel** — deployment
- **Supabase** — contact form lead storage
- **Resend** — email notifications

---

## Non-Negotiables

These are not optional and must be implemented on every relevant page:

- Attorney-client disclaimer on the contact form
- Disclaimer in the footer on every page
- Disclaimer on every blog post
- Disclaimer on every practice area page
- Each practice area on its own URL (e.g., /practice-areas/contracts)
- Every blog post attributed to a named attorney
- No image committed to the repo larger than 200 KB
- JSON-LD structured data on every page (LegalService, Person, Article as appropriate)

Security requirements (must be addressed in a dedicated security phase):

- HTTP security headers in `vercel.json` (Content-Security-Policy, X-Frame-Options,
  X-Content-Type-Options, Referrer-Policy, Permissions-Policy)
- All API keys in Vercel environment variables only — never in source code or git
- `.env` files listed in `.gitignore` — never committed
- Supabase Row Level Security enabled on all tables
- Server-side input validation on all form submissions
- Honeypot spam protection on the contact form
- Built output (`dist/`) verified to contain no exposed credentials
- ABA Formal Opinion 477R: attorney obligation to protect pre-engagement
  client communications applies to this contact form and lead storage system

---

## Copy Principles

All website copy follows the StoryBrand framework:
- The CLIENT is the hero, not the firm
- Lead with the client's problem, not the firm's credentials
- Position the firm as the guide with a clear plan
- Every section has one job: move the visitor toward getting in touch

---

## Decision Log

When making significant decisions during the build, add an entry to
`.planning/DECISIONS.md` with: what was decided, why, and the teaching insight.
This file is course documentation for the HeyCounsel community.
```

---

## Step 10 — Show completion summary

Display this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ Setup complete — [Firm Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Files created:

  .planning/FIRM_BRIEF.md              ← Your firm's profile
  .planning/LAW_FIRM_WEBSITE_GUIDE.md  ← Best practices reference
  .claude/CLAUDE.md                    ← Claude's project instructions

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Next step — run this command:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /gsd:new-project --auto @.planning/FIRM_BRIEF.md

This tells Claude to read your firm brief and build
a full project plan — phases, tasks, and success
criteria — without asking redundant questions.

After that, you'll run:
  /gsd:plan-phase 1
  /gsd:execute-phase 1

And the build begins. Run /hc-firm-site:help at any
time to see all available commands.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</process>
