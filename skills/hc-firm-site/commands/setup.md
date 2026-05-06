---
name: hc-firm-site:setup
description: Set up a new firm website project — installs GSD if needed, gathers firm info, and configures Claude for a non-technical attorney
allowed-tools:
  - Bash
  - Read
  - Write
  - WebFetch
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

## Step 2 — Check if GSD is installed

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

## Step 3 — Install GSD (only if not installed)

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

One more step: fully quit and reopen Claude Code so
it picks up the new GSD commands.

  → Fully quit Claude Code
    Mac: press Cmd+Q
    Windows: right-click the taskbar icon → Quit
    (just closing the window is not enough)
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

## Step 4 — Check project state

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
If start fresh: continue to Step 5.

**If NEW:** Continue to Step 5.

---

## Step 5 — Create project folders

```bash
mkdir -p .planning
mkdir -p .claude
```

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

## Step 7 — Confirm the tech stack

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
GSD reaches that phase of the build. There are several
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
**If yes:** Show this and continue to Step 8:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ Tech stack confirmed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Astro        ✓  builds the site
  Tailwind     ✓  styles it
  GitHub       ✓  version control
  Vercel       ✓  hosting and deployment

  Contact form integration will be decided when GSD
  reaches that phase — we'll review your options and
  choose the right one for how you manage intake.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Step 8 — Write FIRM_BRIEF.md

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

## Step 9 — Copy LAW_FIRM_WEBSITE_GUIDE.md into the project

Read the guide from the skill's own folder and write it into the project:

```bash
cp "$HOME/.claude/hc-firm-site/LAW_FIRM_WEBSITE_GUIDE.md" ".planning/LAW_FIRM_WEBSITE_GUIDE.md"
```

If the copy fails for any reason, note it but continue — it's not a blocker.

---

## Step 10 — Write .claude/CLAUDE.md

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

Do not suggest alternatives to the core stack:

- **Astro 6** — builds the site
- **Tailwind CSS v4** — styles it
- **GitHub** — version control
- **Vercel** — deployment and hosting

**Contact form integration is TBD.** When GSD reaches
the contact form phase, present the attorney with their
options (e.g. Supabase + Resend, Formspree, Netlify Forms,
direct email via SMTP, CRM webhook). Ask what they currently
use to manage client intake — the right tool depends on their
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

## Step 11 — Show completion summary

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
