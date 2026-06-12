# Before the Session — Setup Checklist

**Build Your Firm Website with Claude Code · HeyCounsel**

Please complete these four steps before our session. Total time: about 30 minutes.
Nothing technical — just accounts and a few clicks. If anything goes wrong, don't
worry: note where you got stuck and we'll fix it together at the start of the session.

---

## Step 1 — Claude (10 min)

Claude Code is the tool we'll build your entire website with.

1. **Get a paid Claude plan** at [claude.ai](https://claude.ai) — Claude Code requires
   **Pro, Max, or Team**.
   - 💡 **We recommend Max or Team for the build.** The Pro plan works, but its usage
     limits can pause a long building session for a few hours — several members hit
     this in our last cohort. You can always downgrade after your site launches.
2. **Download the Claude Code desktop app** from
   [claude.ai/download](https://claude.ai/download), install it, and sign in with
   your Claude account.

**✓ Verify you're good to go:** Open Claude Code, type "hello" in the message box,
and confirm you get a reply.

---

## Step 2 — GitHub (8 min)

GitHub is where your website's code will live — think of it as a Google Drive for
code, with a full undo history.

1. Go to [github.com](https://github.com) and click **Sign up** (free). Use an email
   you actually check.
2. **Create your website's repository** (the folder on GitHub that will hold your
   site's code):
   - Click the **+** in the top-right corner → **New repository**
   - Name it something like **my-firm-website**
   - Set visibility to **Private**
   - Check **"Add a README file"**
   - Click **Create repository**
3. **Connect GitHub to Claude Code** — this lets Claude save your work to GitHub
   without you ever typing passwords:
   - In Claude Code, click the **plug icon (⚡)** in the bottom-left corner
   - Find **GitHub** in the list and click **Connect**
   - Follow the prompts to authorize

**✓ Verify you're good to go:** You can open your repository's page on github.com,
and clicking the plug icon in Claude Code shows GitHub as **Connected**.

---

## Step 3 — Vercel (7 min)

Vercel is what publishes your site to the internet. Every change you make goes
live automatically, usually within a minute.

1. Go to [vercel.com](https://vercel.com) and click **Sign Up**.
2. Choose **"Continue with GitHub"** — this is important. It links your Vercel and
   GitHub accounts so deployments happen automatically. The free **Hobby** plan is
   all you need.
3. **Create your project:**
   - Click **Add New → Project**
   - Find the repository you just created and click **Import**
   - Leave all the default settings as-is
   - Click **Deploy**

Vercel will "deploy" your site — it's just a README file right now, and that's
exactly right. You'll get a live URL like **my-firm-website.vercel.app**. That's
your website's address; everything we build in the session will appear there.

**✓ Verify you're good to go:** Your Vercel dashboard shows your project with a
live URL you can click.

---

## Step 4 — Install the Website Builder skill (2 min)

This is the HeyCounsel skill that guides the entire build.

1. Open Claude Code (any folder is fine) and paste this message:

   > Please run this command for me:
   > `curl -s https://raw.githubusercontent.com/bstevescherer/heycounsel-community/main/skills/hc-firm-site/install.sh | bash`

   Claude will ask for permission to run it — approve it. You'll see a list of
   checkmarks as everything installs.

2. **Fully quit Claude Code and reopen it.** Just closing the window is not enough —
   Claude needs a full restart to load new commands.
   - **Mac:** press **Cmd+Q**
   - **Windows:** right-click the taskbar icon → **Quit**

**✓ Verify you're good to go:** After reopening, type `/hc-firm` in the message
box. You should see **/hc-firm-site:build** appear in the suggestions. That's the
command we'll run together.

---

## Optional — but it will make your build much better

Have these handy for the session. The skill asks about your firm at the start, and
the more you can share, the better your site will be:

- **Your existing website URL and/or HeyCounsel profile URL** — Claude reads them
  and pre-fills most of the intake questions
- **Attorney details** — names, titles, bar admissions (state + year), education,
  short bios
- **Your fees** — flat-fee examples or hourly rates, if you're open to publishing them
  (transparent pricing converts better, but it's your call)
- **Professional headshots** — if you have them; placeholders work fine if not
- **2–3 websites you admire visually** — any industry, not just law firms

---

## Final checklist

- ☐ Claude paid plan (Pro, Max, or Team) and the Claude Code desktop app, signed in
- ☐ GitHub account created + repository created (Private, with a README)
- ☐ GitHub connected to Claude Code (plug icon shows "Connected")
- ☐ Vercel account created with "Continue with GitHub"
- ☐ Vercel project deployed — you can see your live `.vercel.app` URL
- ☐ Skill installed — typing `/hc-firm` shows `/hc-firm-site:build`
- ☐ Firm details gathered (bios, fees, headshots, URLs)

**Stuck on anything?** Note where you got stuck and bring it to the session —
we'll sort it out in the first few minutes. See you there!
