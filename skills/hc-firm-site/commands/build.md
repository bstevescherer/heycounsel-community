---
name: hc-firm-site:build
description: Build a complete law firm website in four phases — one command from empty folder to launched site. Resumable — run it again anytime and it picks up exactly where you left off.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - WebFetch
  - AskUserQuestion
---

<objective>
Build a complete, production-quality law firm website for a practicing attorney with
no coding background. This is the ONLY command the attorney needs for the entire build.

The journey:

1. **Setup** (first run only) — connect GitHub + Vercel, install the design skill,
   gather firm information, write the firm brief and project instructions
2. **Phase 1 — Foundation** — Astro + Tailwind project with a custom design system,
   deployed live on day one
3. **Phase 2 — Content** — homepage, practice area pages, attorney profiles, blog
4. **Phase 3 — Leads + SEO** — contact form, schema markup, sitemap, AI-search optimization
5. **Phase 4 — Polish + Launch** — accessibility, performance, security, bar compliance, launch

Every phase ends the same way: commit → push → verify the live deploy → show the
attorney their site → get approval before moving on.

**This command is resumable.** Progress lives in `.planning/PROGRESS.md`. If the
session ends, the context is cleared, or the attorney hits a usage limit, they just
run `/hc-firm-site:build` again and the build continues from the first unfinished step.
</objective>

<rules>
These apply to every step of every phase:

- **Plain English always.** The attorney has never coded. Explain every command before
  running it, define every technical term the first time, use real-world analogies.
- **One thing at a time.** Never dump multiple questions or concepts in one message
  unless the step explicitly groups them.
- **Never skip the ship ritual.** Every phase ends with commit → push → live deploy
  verified → attorney approval. No phase is "done" until the attorney has seen it live
  and said so.
- **Update PROGRESS.md immediately** after each milestone — it is the only thing that
  makes the build survivable across sessions.
- **Read before building.** At the start of each phase, read the phase playbook, the
  firm brief, and the relevant section of the Law Firm Website Guide. Files:
  - `.planning/FIRM_BRIEF.md` — the firm (created during Setup)
  - `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — best practices reference (copied into the
    project during Setup so the repo carries its own reference; if it's missing for
    any reason, read the installed original at
    `$HOME/.claude/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md` and re-copy it into
    `.planning/`)
  - `$HOME/.claude/hc-firm-site/phases/PHASE_N.md` — the playbook for phase N
- **Apply the frontend-design skill** whenever creating or significantly changing
  visual design (Phase 1 design system, Phase 2 pages). Read it from
  `$HOME/.claude/skills/frontend-design/SKILL.md` and follow its process.
- **Apply the seo-aeo-best-practices skill** whenever writing content or doing SEO
  work (Phases 2–4). It lives at `$HOME/.claude/skills/seo-aeo-best-practices/` —
  the SKILL.md is a hub pointing to reference files on EEAT, structured data,
  technical SEO, and AEO. Read the file relevant to the work at hand.
- **Apply the stop-slop skill to EVERY piece of copy written for the site** —
  homepage sections, practice area pages, attorney bios, blog posts, FAQ answers,
  meta descriptions, the footer, the contact form. It lives at
  `$HOME/.claude/skills/stop-slop/`; read `SKILL.md` plus `references/phrases.md`
  and `references/structures.md` once per phase and apply on every draft. The
  skill scores prose on a 50-point rubric — anything under 35/50 should be revised
  before showing the attorney. This is non-negotiable: it's the difference between
  "obviously AI" and copy that sounds like the attorney wrote it themselves.
- **Errors are teaching moments.** When something fails, explain what the error means
  in plain English first, then fix it.
</rules>

<process>

## Step 0 — Where are we?

Before anything else, check for an in-progress build:

```bash
[ -f ".planning/PROGRESS.md" ] && echo "RESUMING" || echo "FRESH_START"
```

**If RESUMING:**
1. Read `.planning/PROGRESS.md`, `.planning/FIRM_BRIEF.md`, and `.claude/CLAUDE.md`
2. Show a status box like this (fill in real status from PROGRESS.md):

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Welcome back — [Firm Name] website build
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ✓ Setup                 complete
  ✓ Phase 1 — Foundation  complete (site is live!)
  ▶ Phase 2 — Content     in progress
  ☐ Phase 3 — Leads + SEO
  ☐ Phase 4 — Polish + Launch

  Last completed: [most recent checked item]
  Picking up at:  [first unchecked item]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

3. Confirm with the attorney: "Ready to continue with [next step]?" Then jump directly
   to that step below. Skip everything already marked complete.

**If FRESH_START:** Continue to Setup, Step 1.

---

# PART ONE — SETUP (first run only)

## Step 1 — GitHub, Vercel, and connection walkthrough

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Before we build — let's connect your project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Your website needs three things in place before we start:

  ☐ A GitHub repository   — where your code lives
  ☐ A Vercel project      — where your site publishes to
  ☐ The two connected     — so every push goes live automatically

We'll walk through each one now. If you've already done
any of these steps, just confirm and we'll move on.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### 1a — GitHub account and repository

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Step 1 of 3 — GitHub
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GitHub is where your website's code lives. Think of
it as a Google Drive for code — every change is saved,
versioned, and backed up automatically.

If you don't have a GitHub account yet:
  1. Go to github.com
  2. Click "Sign up" (it's free)
  3. Create your account

Once you're logged in, create a new repository:
  1. Click the + in the top-right corner
  2. Select "New repository"
  3. Name it something like: my-firm-website
  4. Set visibility to Private
  5. Check "Add a README file"
  6. Click "Create repository"

You should now see a page with your new empty repo.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  One more thing while you're here — connect GitHub
  to Claude Code
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This lets Claude push code to GitHub on your behalf
so you never have to type passwords or tokens. It
takes about 30 seconds and you only do it once.

  1. In Claude Code, click the plug icon (⚡) in the
     bottom-left corner
  2. Find GitHub in the list and click Connect
  3. Follow the prompts to authorize

Once connected, Claude can push your code to GitHub
directly — no terminal passwords required.
```

Use AskUserQuestion:
- Question: "Do you have a GitHub account, a new repository, and GitHub connected to Claude Code?"
- Options: ["Yes, all three done", "I need help — something went wrong"]

**If they need help:** Ask them to describe what happened and troubleshoot before continuing.

**If ready:** Continue to 1b.

---

### 1b — Vercel account and project

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Step 2 of 3 — Vercel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Vercel is what publishes your site to the internet.
Every time you push code to GitHub, Vercel automatically
deploys it live — usually within 60 seconds.

Create your Vercel account:
  1. Go to vercel.com
  2. Click "Sign Up"
  3. Choose "Continue with GitHub" — this links the
     two accounts automatically

Once you're in, create a new project:
  1. Click "Add New" → "Project"
  2. Find your new GitHub repository in the list
     and click "Import"
  3. Leave all the default settings as-is
  4. Click "Deploy"

Vercel will build the site (it's mostly empty right
now — that's fine). You'll get a live URL like:
  my-firm-website.vercel.app

That URL is your site. It will update automatically
every time you push code.
```

Use AskUserQuestion:
- Question: "Do you have a Vercel project deployed and a live URL?"
- Options: ["Yes, I can see my live URL", "I need help — something went wrong"]

**If they need help:** Ask them to describe what happened and troubleshoot before continuing.

**If ready:** Continue to 1c.

---

### 1c — Connect your local folder to GitHub

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Step 3 of 3 — Connect to GitHub
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Now we need to connect this folder to the GitHub
repository you just created.

We're not uploading anything yet — we're just telling
this folder "when we're ready to push code, send it
here." The actual build happens first, and we'll do
the first push together once there's something worth
committing.

I can run the two setup commands for you. All I need
is your GitHub repository URL — you can find it on
your repo page by clicking the green "Code" button
and copying the HTTPS link. It looks like:

  https://github.com/your-username/your-repo-name.git
```

Ask conversationally:

"What's the GitHub URL for your new repository? Once you share it, I'll run the setup commands."

Wait for the URL. Then ask:

"Ready? I'll run `git init` and connect this folder to your GitHub repo."

Use AskUserQuestion:
- Question: "Ready for me to connect this folder to GitHub?"
- Options: ["Yes, run it", "Wait — I have a question"]

**If they have a question:** Answer it, then re-confirm before continuing.

**If yes:** Run:
```bash
git init
git remote add origin THEIR_URL
```

Check the output. If successful, show:

```
✓ GitHub, Vercel, and your local folder are all set.
  Your site is live and connected. Let's build it.
```

**If an error occurs:** Explain what went wrong in plain English and troubleshoot before continuing.

---

## Step 2 — Install the expert skills

The build leans on three free, expert-written skills. Check whether they're installed:

```bash
[ -f "$HOME/.claude/skills/frontend-design/SKILL.md" ] && echo "DESIGN: installed" || echo "DESIGN: missing"
[ -f "$HOME/.claude/skills/seo-aeo-best-practices/SKILL.md" ] && echo "SEO: installed" || echo "SEO: missing"
[ -f "$HOME/.claude/skills/stop-slop/SKILL.md" ] && echo "COPY: installed" || echo "COPY: missing"
```

**If all installed:** Show `✓ Expert skills already installed (design + SEO + copy)` and
continue to Step 3.

**If any is missing:** Show this message (mention only the missing one(s)):

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Three more tools — expert skills for Claude
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before we start, I'd like to install three free
add-on "skills" — expert playbooks that upgrade how
Claude does specific kinds of work:

1. frontend-design (by Anthropic)
   → Without it, AI-built websites tend to look the
     same — generic layouts, predictable colors, the
     "obviously made by AI" look.
   → With it, Claude starts from YOUR firm's identity
     and builds a deliberate visual direction: real
     typography choices, an intentional color system,
     a design with a point of view.
   → Used in Phase 1 (your design system) and Phase 2
     (every page).

2. seo-aeo-best-practices (by Sanity)
   → A maintained, current reference for getting found:
     traditional Google search (SEO), AI answer engines
     like ChatGPT and Perplexity (AEO), and Google's
     authority framework (called EEAT — Experience,
     Expertise, Authoritativeness, Trust).
   → With it, Claude implements your metadata, schema
     markup, and sitemap from an up-to-date expert
     checklist instead of from memory.
   → Used in Phase 2 (content authority), Phase 3
     (all the SEO work), and Phase 4 (the final audit).

3. stop-slop (by Hardik Pandya)
   → Strips the predictable AI tells out of your copy
     — the throat-clearing openers, the "not just X
     but Y" rhythm, the em-dash overuse, the empty
     intensifiers. The stuff that makes readers think
     "this was clearly written by ChatGPT."
   → With it, every line on your site sounds like a
     person — short, direct, distinctively yours.
   → Used in Phase 2 (all page copy + blog) and
     Phase 3 (FAQ answers, meta descriptions).

They're just text files that install into Claude's
skills folder. Takes a few seconds, changes nothing
else on your computer.
```

Use AskUserQuestion:
- Question: "Install the expert skills?"
- Options: ["Yes, install them", "Skip — use Claude's built-in instincts"]

**If yes:** Install whichever is missing:

```bash
# frontend-design (single file)
mkdir -p "$HOME/.claude/skills/frontend-design"
curl -sf "https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md" -o "$HOME/.claude/skills/frontend-design/SKILL.md"

# seo-aeo-best-practices (hub file + four reference docs)
mkdir -p "$HOME/.claude/skills/seo-aeo-best-practices/references"
base="https://raw.githubusercontent.com/sanity-io/agent-toolkit/main/skills/seo-aeo-best-practices"
curl -sf "$base/SKILL.md" -o "$HOME/.claude/skills/seo-aeo-best-practices/SKILL.md"
for ref in eeat-principles structured-data technical-seo aeo-considerations; do
  curl -sf "$base/references/${ref}.md" -o "$HOME/.claude/skills/seo-aeo-best-practices/references/${ref}.md"
done

# stop-slop (hub file + three reference docs)
mkdir -p "$HOME/.claude/skills/stop-slop/references"
slop_base="https://raw.githubusercontent.com/hardikpandya/stop-slop/main"
curl -sf "$slop_base/SKILL.md" -o "$HOME/.claude/skills/stop-slop/SKILL.md"
for ref in phrases structures examples; do
  curl -sf "$slop_base/references/${ref}.md" -o "$HOME/.claude/skills/stop-slop/references/${ref}.md"
done
```

Verify the files downloaded (exist and are non-empty). If it worked, show
`✓ Expert skills installed`. If a download failed (no internet, GitHub down), say so
plainly, note that the build can continue without it, and move on.

**If skip:** Note their choice and continue. Do not ask again.

---

## Step 3 — Project folders

Check if this project already has a FIRM_BRIEF.md:

```bash
[ -f ".planning/FIRM_BRIEF.md" ] && echo "EXISTS" || echo "NEW"
```

**If EXISTS** (but no PROGRESS.md — unusual, probably an old setup): Use AskUserQuestion:
- Question: "A FIRM_BRIEF.md already exists in this project. What would you like to do?"
- Options: ["Keep it — skip the intake questions", "Start fresh — redo the intake"]

If keeping: read the existing brief, then skip ahead to Step 7 (write PROGRESS.md).
If starting fresh: continue.

**If NEW:** Create the folders and continue:

```bash
mkdir -p .planning
mkdir -p .claude
```

---

## Step 4 — Intake questions

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
  💡 Tip: share your existing site or HeyCounsel profile to go faster
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

If you already have a website or a HeyCounsel profile,
share the URL(s) and I'll read them first. I'll
pre-fill everything I can find, then only ask about
the gaps. This usually cuts the intake in half.

Examples of what to share:
  → Your existing firm website (any platform)
  → Your HeyCounsel profile page
  → A LinkedIn page for the firm or its attorneys
  → A practice area page on a previous firm's site

If you don't have any of these, no problem — we'll
just go through the questions together.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Before starting Group 1, ask:

"Do you have an existing website, HeyCounsel profile, or LinkedIn page for the firm I can read first? Share any URLs you have, or just say 'none' and we'll go through the questions together."

**If they share URLs:**
- Use WebFetch to read each URL
- Pull out: firm name, location, practice areas, tagline, attorney names/titles/bios, ideal clients, fee info, existing copy/tone, design references
- Note what was found and what's still missing
- Show the user a brief summary: "I found [X, Y, Z] from your site. I still need to ask about [missing items]."
- Skip questions in the groups below where you already have a confident answer; ask only the remaining ones

**If they say none:** Continue with all five groups as written below.

Ask each group conversationally — output the question as a normal message and wait for the response before moving to the next group. Do not use AskUserQuestion for these — the questions are too detailed for a popup dialog.

---

**Group 1 of 5 — The Firm**

Say (skip any items you already pulled from their URLs):

"Let's start with the basics:

1. What is your firm's full name?
2. What city and state is the firm based in?
3. What are your primary practice areas? List all of them.
   (Examples: Corporate Law, M&A, Contracts, Employment, Real Estate, IP, etc.)

Numbered list or freeform — whichever is easiest."

Wait for the response, then continue.

---

**Group 2 of 5 — The Team**

If you prefilled attorneys from URLs earlier, lead with what you found:
"I found these attorneys on your site: [Name 1], [Name 2]. Anyone else who'll be
featured? Let me know if any of those names should be corrected."

Otherwise, ask the three short questions below:

"A few quick ones about the team:

1. How many attorneys total will be featured on the site? (Just you = 1)
2. Your name and role for the site? (e.g., 'Sarah Smith, Managing Partner')
3. Any non-attorney staff to feature — paralegal, operations, intake? (Names + roles,
   or just say 'none'.)

Don't worry about bar admission, focus areas, or bios right now — I'll ask for those
when we build each attorney's profile page in Phase 2. Easier to do one at a time
than dump everything now."

Wait for the response. Record the attorney count so Phase 2 knows how many profile
pages to create. The lead attorney's name is the only attorney detail strictly needed
for Phase 1. Other attorneys can be placeholders for now (FIRM_BRIEF.md notes this).

---

**Group 3 of 5 — Your Clients**

Say:

"Help me understand who you serve:

1. Who is your ideal client?
   (Be specific: e.g., "Series A and B startups in tech", "founder-owned businesses with $5M–$50M in revenue", "PE-backed companies going through M&A")

2. What is the main legal problem they come to you to solve?

3. What do your clients typically worry about before hiring a lawyer?
   (e.g., cost surprises, slow response times, getting passed to junior associates)"

Wait for the response, then continue.

---

**Group 4 of 5 — Positioning and Pricing**

Say:

"Two quick ones on how you position the firm:

1. Do you offer flat fees, hourly billing, or both?
   If flat fees: what are some examples with prices?
   (e.g., "LLC formation $1,500", "contract review from $750")
   If hourly: what is your rate or range?

2. How would you describe the firm's tone and personality?
   (e.g., "formal and precise", "direct and no-nonsense", "approachable and plain-speaking")"

Wait for the response, then continue.

---

**Group 5 of 5 — Design and Existing Presence**

First, present the two curated style directions. Read
`$HOME/.claude/hc-firm-site/DESIGN_REFERENCES.md` (if installed) so you can speak to
them accurately, then show:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Last group — the look and feel
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You don't have to design your site from scratch.
We've curated two style directions that work for
modern law firms — which one feels like YOUR firm?

  1 · PLAYFUL, SMART
      Warm, human, founder-to-founder energy.
      Serious about the work, not about itself.
      Light pages, one friendly accent color, a
      personal touch — charm that builds trust.

  2 · MODERN, SOPHISTICATED
      Precision and quiet confidence. Reads like a
      top-tier product company that practices law.
      Disciplined typography, generous space, proof
      over ornament.

There's no wrong answer — and if neither fits, you
can point me at any site you admire instead.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Which style direction feels right for your firm?"
- Options:
  - "Playful, smart"
  - "Modern, sophisticated"
  - "Somewhere in between — mix them"
  - "A different direction — I'll describe it"

**If they pick a category (or a mix):** note it for the brief. **If different
direction:** ask them to describe it or share URLs — their preference always wins
over the curated defaults.

Then say:

"Great choice. A few more quick ones:

One last optional one — any other sites you admire visually (any industry — share
URLs or just describe what you like), or a color direction you prefer (e.g. 'dark
and serious', 'navy and gold')? Totally fine to say 'skip' — the style you picked
above is enough to start designing from."

Wait for the response, then continue to Step 5. Headshots will be requested in
Phase 2 when attorney profile pages are built.

---

## Step 5 — Confirm the tech stack

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Let's confirm your tech stack
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You've already set up GitHub and Vercel — two of the
four tools we'll use to build your site.

I'll walk you through all four, explain what each one
does and why we chose it, and confirm each one before
we move on.

One note on the contact form: we'll figure out how
form submissions get stored and emailed to you when
we reach Phase 3 of the build. There are several
good options and the right one depends on what you
already use to manage client intake.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Walk through each tool individually:

---

**Tool 1 of 4 — Astro**

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Tool 1 of 4 — Astro
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What it is:
Astro is the framework that builds your website —
it assembles all your pages, components, and content
into the final HTML that visitors see in their browser.

Think of it as the assembly line that takes everything
Claude writes and turns it into an actual website.

Why Astro for a law firm website:
  → Pages load extremely fast, which matters directly
    for Google rankings. Slow sites rank lower.
  → Purpose-built for content-heavy sites: practice
    area pages, attorney bios, blog posts, service
    descriptions — Astro handles all of this cleanly.
  → The code it produces is organized and predictable,
    which means Claude can reliably pick up where it
    left off in every new session.
  → Free and open source. No license fees, ever.

The most common alternative is WordPress. WordPress
is slower, requires constant plugin updates, gets
hacked more often, and is significantly harder for
Claude to modify reliably. Astro was the right call.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Use Astro to build the site?"
- Options: ["Yes, use Astro", "I have a question about this"]

**If they have a question:** Answer it, then re-confirm before continuing.
**If yes:** Continue to Tool 2.

---

**Tool 2 of 4 — Tailwind CSS**

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Tool 2 of 4 — Tailwind CSS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What it is:
Tailwind is a styling system — it controls everything
visual about your site. Colors, fonts, spacing,
layout, hover effects, how it looks on mobile.
Everything a visitor sees is styled with Tailwind.

If Astro is the structure of your building, Tailwind
is the interior design firm.

Why Tailwind:
  → Works hand-in-hand with Astro. The two tools were
    designed to be used together.
  → Styles live right next to the elements they affect,
    so there's nothing to hunt down when you want to
    make a change.
  → Makes visual changes easy to describe to Claude:
    "make the header darker" or "add more space between
    sections" — Claude can implement those precisely.
  → Your entire design is controlled by one consistent
    set of rules. Nothing looks accidentally different
    from page to page.
  → Free and open source.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Use Tailwind CSS for all the styling?"
- Options: ["Yes, use Tailwind", "I have a question about this"]

**If they have a question:** Answer it, then re-confirm before continuing.
**If yes:** Continue to Tool 3.

---

**Tool 3 of 4 — GitHub**

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Tool 3 of 4 — GitHub  (already set up ✓)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You created your GitHub repository in Step 1 — so
this is already in place. Here's a bit more on what
it actually does once we start building:

GitHub stores every version of your site's code,
going back to the very first file. Think of it as
a permanent undo history for your entire website.

  → Every change Claude makes gets "committed" — that's
    like pressing Save, except it also records what
    changed, when, and why. You can always see the
    full history.
  → If something breaks or you change your mind, you
    can roll back to any previous version. Nothing is
    ever truly lost.
  → Your entire website lives here, safely backed up,
    separate from your laptop. If your computer dies,
    the site is fine.
  → Connects directly to Vercel — every push triggers
    an automatic deployment. No manual uploads, ever.
  → Free for private repositories.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Continue with GitHub for version control?"
- Options: ["Yes, confirmed", "I have a question about this"]

**If they have a question:** Answer it, then re-confirm before continuing.
**If yes:** Continue to Tool 4.

---

**Tool 4 of 4 — Vercel**

Show this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Tool 4 of 4 — Vercel  (already set up ✓)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You created your Vercel project in Step 1 — already
in place. Here's more on what it does throughout
the build:

Vercel is your hosting platform — it's what makes
your site accessible to the public on the internet,
and it handles a lot more than just serving pages.

  → The moment you push a change to GitHub, Vercel
    automatically picks it up and publishes it live.
    Usually within 60 seconds. No manual steps.
  → When you're ready for a real domain (e.g.
    smithlaw.com), you'll point it to Vercel and it
    routes all visitors to your site automatically.
  → Runs on a global network of servers, so your site
    loads fast for visitors anywhere in the world.
  → Handles all the technical infrastructure — SSL
    certificates (the padlock in the browser bar),
    caching, performance optimization — automatically.
  → Vercel is also where you'll store secret API keys
    (passwords for third-party tools like your contact
    form provider). They live here, safely separate
    from your code, so they never end up on GitHub.
  → Free tier covers everything a law firm website
    needs, including custom domains.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Continue with Vercel for hosting and deployment?"
- Options: ["Yes, confirmed", "I have a question about this"]

**If they have a question:** Answer it, then re-confirm before continuing.
**If yes:** Show this and continue to Step 6:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ Tech stack confirmed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Astro        ✓  builds the site
  Tailwind     ✓  styles it
  GitHub       ✓  version control
  Vercel       ✓  hosting and deployment

  Contact form integration will be decided in Phase 3
  — we'll review your options and choose the right one
  for how you manage intake.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Step 6 — Write FIRM_BRIEF.md

Using all the answers collected, write `.planning/FIRM_BRIEF.md` in this format:

```markdown
# Firm Brief — [Firm Name]

*Generated by /hc-firm-site:build. This document is the source of truth for
the website build. Claude reads it automatically at the start of every session.*

---

## The Firm

**Name:** [firm name]
**Location:** [city, state]
**Practice Areas:** [list]

---

## The Team

**Total attorneys on the site:** [number]

### Attorneys

[For each attorney whose details ARE known so far — at minimum, the lead attorney:]
**[Name]** — [Title]
- Bar: [bar admission OR "TBD — collect in Phase 2"]
- Focus: [focus areas OR "TBD"]
- Bio: [background notes OR "TBD"]
- Education: [education OR omit if not provided]

[For placeholder attorneys whose details will be collected in Phase 2:]
**Attorney 2** — *details TBD; collect in Phase 2 when building profile page*
**Attorney 3** — *details TBD; collect in Phase 2 when building profile page*

### Staff

[For each non-attorney staff member, or "None listed":]
**[Name]** — [Title]
- Role: [description]

---

## The Clients

**Ideal client:** [their description]
**Primary problem they solve:** [their answer]
**Client fears / objections:** [their answer]

---

## Positioning

**Fee structure:** [flat / hourly / both + specifics]
**Tone and personality:** [their answer]

---

## Design Direction

**Style category:** [Playful & Smart / Modern & Sophisticated / mix / custom — from
the intake choice. Phase 1 grounds its design proposals in this category's reference
sites (see DESIGN_REFERENCES.md) unless custom.]
**Other visual references:** [URLs or descriptions the attorney shared, or "none"]
**Color direction:** [their answer, or "no preference"]

---

## Additional Context

[Anything from the "anything else" answer, or "None provided."]

---

## Security & Compliance Requirements

*These are non-negotiable for a law firm website. Phase 4 of the build
addresses each of these before launch.*

- **HTTP security headers** — configured in `vercel.json`: Content-Security-Policy,
  X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy
- **Secrets management** — all API keys stored as Vercel environment variables only;
  never hardcoded in source files or committed to git
- **Git hygiene** — `.env` and `.env.local` files excluded from git via `.gitignore`
- **Database security** — if the contact form uses a database (e.g. Supabase),
  Row Level Security must be enabled on all tables
- **Server-side input validation** — contact form validated on the server, not just
  the browser; malformed submissions rejected before reaching storage
- **Spam protection** — honeypot field on the contact form at minimum; rate limiting
  recommended for production
- **No sensitive data in built output** — verify the compiled `dist/` folder contains
  no API keys, service keys, or credentials
- **ABA Formal Opinion 477R compliance** — attorneys have a professional responsibility
  to protect the confidentiality of client communications, including pre-engagement
  inquiries submitted via web forms; the contact form, data storage, and notification
  system must meet this standard
- **Pre-launch security audit** — Phase 4 runs the full `/hc-firm-site:check` audit;
  the Security section must fully pass before launch
```

---

## Step 7 — Copy LAW_FIRM_WEBSITE_GUIDE.md into the project

Read the guide from the skill's own folder and write it into the project:

```bash
cp "$HOME/.claude/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md" ".planning/LAW_FIRM_WEBSITE_GUIDE.md"
```

If the copy fails for any reason, note it but continue — it's not a blocker.

---

## Step 8 — Write .claude/CLAUDE.md

Write `.claude/CLAUDE.md` with the following content, substituting the firm name and practice areas from the brief:

```markdown
# [Firm Name] — Website Project

This project is building a law firm website for [Firm Name], a [practice areas]
firm based in [city, state]. The person working on this project is a practicing
attorney with no coding background.

The build is managed by the `/hc-firm-site:build` command — it runs in four
phases and tracks progress in `.planning/PROGRESS.md`. If the attorney seems
lost or asks "where were we?", tell them to run `/hc-firm-site:build` again —
it resumes automatically.

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

- `.planning/PROGRESS.md` — where the build currently stands
- `.planning/FIRM_BRIEF.md` — the firm's complete profile, team, clients, and positioning
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — best practices for law firm websites (SEO, AEO, conversion, disclaimers, StoryBrand)

Every content, copy, and SEO decision should be consistent with these documents.

---

## Design

When creating or significantly changing visual design, read and apply the
frontend-design skill at `~/.claude/skills/frontend-design/SKILL.md` (if installed).
The site's design direction was chosen with the attorney during Phase 1 — honor it.
Do not introduce new fonts, colors, or visual styles without asking.

---

## Tech Stack — Already Decided

Do not suggest alternatives to the core stack:

- **Astro** — builds the site
- **Tailwind CSS** — styles it
- **GitHub** — version control
- **Vercel** — deployment and hosting

**Contact form integration is decided in Phase 3.** Present the attorney with
their options (e.g. Web3Forms, Formspree, Supabase + Resend, CRM webhook). Ask
what they currently use to manage client intake — the right tool depends on their
existing workflow. Do not assume Supabase or Resend.

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
- One call to action everywhere — don't add competing CTAs

Security requirements (addressed in Phase 4 — but never violated earlier):

- HTTP security headers in `vercel.json` (Content-Security-Policy, X-Frame-Options,
  X-Content-Type-Options, Referrer-Policy, Permissions-Policy)
- All API keys in Vercel environment variables only — never in source code or git
- `.env` files listed in `.gitignore` — never committed
- If a database is used: Row Level Security enabled on all tables
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

**Every line of copy passes through the stop-slop skill at
`~/.claude/skills/stop-slop/` before going on the site.** Read its phrases.md
and structures.md, then strip the AI tells from every draft: throat-clearing
openers ("In today's fast-paced world"), business clichés ("synergy,"
"leverage," "robust"), the "not just X but Y" rhythm, em-dash overuse, empty
intensifiers ("very," "really," "incredibly"), wh-starters. Target the skill's
35+/50 score. If a sentence wouldn't survive in an attorney's actual client
email, rewrite it.

---

## Decision Log

When making significant decisions during the build, add an entry to
`.planning/DECISIONS.md` with: what was decided, why, and the teaching insight.
```

---

## Step 9 — Create PROGRESS.md and save your work

Write `.planning/PROGRESS.md`:

```markdown
# Build Progress — [Firm Name]

*Maintained by /hc-firm-site:build. Claude updates this after every milestone.
If you ever lose your place, run /hc-firm-site:build — it reads this file and
resumes automatically.*

**Live site:** [Vercel URL from setup]
**GitHub repo:** [repo URL from setup]

---

## Milestones

- [x] Setup — accounts connected, firm brief written, project configured
- [ ] Phase 1 — Foundation *(design system + live deployed shell)*
- [ ] Phase 2 — Content *(homepage, practice areas, attorneys, blog)*
- [ ] Phase 3 — Leads + SEO *(contact form, schema, sitemap, AEO)*
- [ ] Phase 4 — Polish + Launch *(accessibility, performance, security, compliance)*

## Phase Notes

*(Claude: when a phase completes, record the date and any decisions that
future sessions need to know — e.g. which contact form provider was chosen.)*

- Setup completed: [date]
```

Then make the first commit. Explain it first:

"I'm going to save everything we just created as the project's first snapshot
and send it to GitHub — this is called a commit and push. Your planning files
will be safely backed up before we write any code."

```bash
git add .planning .claude
git commit -m "Project setup: firm brief, build instructions, progress tracker"
git push -u origin main
```

**Roadblock — if the push is rejected** with a message about the remote containing
work you don't have: this happens because the GitHub repo was created with a README
file that doesn't exist locally yet. Explain it simply ("GitHub has one file we don't
have locally — we'll pull it down first, then push"), then run:

```bash
git pull origin main --no-rebase --allow-unrelated-histories
git push -u origin main
```

---

## Step 10 — Setup complete

Display this message:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ Setup complete — [Firm Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Files created and backed up to GitHub:

  .planning/FIRM_BRIEF.md              ← Your firm's profile
  .planning/LAW_FIRM_WEBSITE_GUIDE.md  ← Best practices reference
  .planning/PROGRESS.md                ← Build progress tracker
  .claude/CLAUDE.md                    ← Claude's project instructions

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  What happens next — the four phases
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Phase 1 — Foundation     your design system + a live site
  Phase 2 — Content        every page, written and styled
  Phase 3 — Leads + SEO    contact form + search optimization
  Phase 4 — Polish+Launch  accessibility, security, compliance

Each phase ends with your site updated LIVE on the
internet, and we don't move on until you've seen it
and approved it.

You can stop at any point — close your laptop, hit a
usage limit, whatever. Run /hc-firm-site:build again
and we pick up exactly where we left off.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Use AskUserQuestion:
- Question: "Ready to start Phase 1 now?"
- Options: ["Yes — let's build", "Not yet — I'll come back later"]

**If later:** Show "No problem. Run /hc-firm-site:build whenever you're ready —
everything is saved." and stop.

**If yes:** Continue to Part Two, Phase 1.

---

# PART TWO — THE FOUR PHASES

## How every phase runs

Each phase follows the same rhythm. Do not deviate from it:

1. **Read first.** Read the phase playbook (`$HOME/.claude/hc-firm-site/phases/PHASE_N.md`),
   `.planning/FIRM_BRIEF.md`, `.planning/PROGRESS.md`, and the guide sections the
   playbook points to. The playbook is the authoritative spec for the phase — follow it.
2. **Announce the phase.** In plain English: what's being built, what it will look
   like when done, roughly how long it takes.
3. **Ask the phase decisions.** Each playbook lists the decisions the attorney must
   make for that phase. Ask them up front — not scattered mid-build.
4. **Build.** Work through the playbook's build steps. Explain as you go, but don't
   ask for permission on things already decided.
5. **Verify.** Check every success criterion in the playbook. Run the build
   (`npm run build`) and confirm zero errors. Fix anything that fails before showing
   the attorney.
6. **Ship it.** Explain, then run:
   ```bash
   git add -A
   git commit -m "[phase]: [plain description of what was built]"
   git push
   ```
   Wait ~60 seconds for Vercel, then verify the live site is serving the new work
   (`curl -s -o /dev/null -w "%{http_code}" THEIR_URL` should return 200; spot-check
   that new content appears). Share the live URL and tell them what to look at.
7. **Get approval.** Use AskUserQuestion: "Does Phase N look right to you?" with
   options ["Yes — mark it complete", "I want changes first"]. If they want changes,
   make them, re-ship, and ask again. Loop until approved.
8. **Record it.** Mark the phase complete in `.planning/PROGRESS.md` with the date
   and any decisions made (e.g. chosen contact form provider). Commit and push that
   update too. Then offer: continue to the next phase now, or stop here (everything
   is saved).

**Context note:** If the conversation is getting very long at a phase boundary,
suggest the attorney start fresh: "This is a clean stopping point. If Claude ever
feels slow or confused, you can clear the conversation and run /hc-firm-site:build —
it resumes from the progress file with a fresh memory."

---

## Phase 1 — Foundation

**Playbook:** `$HOME/.claude/hc-firm-site/phases/PHASE_1.md`

The goal: an Astro + Tailwind project with a real design system — designed using
the frontend-design skill and approved by the attorney — deployed live on their
Vercel URL. The attorney sees their site on the internet today.

Read the playbook and follow the phase rhythm above.

---

## Phase 2 — Content

**Playbook:** `$HOME/.claude/hc-firm-site/phases/PHASE_2.md`

The goal: every page of the site exists with real content — homepage with all
sections, a dedicated page per practice area, attorney profiles, and a working
blog with starter articles. All copy follows StoryBrand.

Read the playbook and follow the phase rhythm above.

---

## Phase 3 — Leads + SEO

**Playbook:** `$HOME/.claude/hc-firm-site/phases/PHASE_3.md`

The goal: visitors can contact the firm from any page (with the required
attorney-client disclaimer), submissions reach the attorney's inbox, and every
page is optimized for Google and AI answer engines (schema, sitemap, FAQ sections).

This phase opens with the contact form decision — the playbook has the options.

Read the playbook and follow the phase rhythm above.

---

## Phase 4 — Polish + Launch

**Playbook:** `$HOME/.claude/hc-firm-site/phases/PHASE_4.md`

The goal: the site is accessible (WCAG 2.1 AA), fast, secure, and bar-compliant.
This phase runs the full 16-point `/hc-firm-site:check` audit and walks the
attorney through connecting their custom domain.

Read the playbook and follow the phase rhythm above.

---

# PART THREE — LAUNCH

When Phase 4 is approved, update PROGRESS.md one final time, then show:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  🎉 Your firm website is launched
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Live at: [their URL]

  What you built:
    ✓ Custom-designed site (no templates)
    ✓ A page for every practice area
    ✓ Attorney profiles + blog
    ✓ Contact form with bar-compliant disclaimers
    ✓ Full SEO + AI-search optimization
    ✓ WCAG accessibility, security headers, fast loads

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Keeping it alive
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /hc-firm-site:page    add a new practice area,
                        attorney, or blog post anytime
  /hc-firm-site:check   re-run the full compliance +
                        SEO audit anytime
  Or just describe any change in plain English —
  Claude knows this codebase.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</process>
