# Phase 1 Playbook — Foundation

**Goal:** A live, publicly accessible Astro site on the attorney's Vercel URL — with
a custom design system they chose and a layout shell (header, footer, placeholder
homepage) ready to receive content.

**The win to deliver:** "My website is on the internet" — on day one. This is the
single biggest motivation moment of the build. Get there.

**Read before building:**
- `.planning/FIRM_BRIEF.md` — especially the Design Direction section
- `$HOME/.claude/skills/frontend-design/SKILL.md` — the design skill (if installed)
- `$HOME/.claude/hc-firm-site/DESIGN_REFERENCES.md` — the curated style categories
  and reference sites; the brief's chosen style category points into this file
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — Part 4 (conversion: homepage structure, CTA design)

---

## Phase decisions (ask up front)

1. **Design direction** — see the Design System section below. This is the big one.
2. **Primary call to action** — the ONE action every page drives toward. Usually
   "Book a Call" or "Schedule a Consultation." Ask which phrasing fits how they
   actually take new client meetings. There will be exactly one CTA site-wide.

---

## Build steps

### 1. Scaffold the Astro project

Explain: "I'm creating the skeleton of your website — all the folders and
configuration files Astro needs. Like pouring the foundation before framing a house."

```bash
npm create astro@latest . -- --template minimal --typescript strict --no-install --no-git
npm install
```

Notes:
- The project goes in the CURRENT folder (the one already connected to GitHub).
- If the folder has files from setup (`.planning/`, `.claude/`, maybe a README pulled
  from GitHub), that's fine — Astro can scaffold around them. If the scaffolder
  refuses because the directory isn't empty, scaffold into a temp subfolder and move
  the files up, preserving the existing `.planning/` and `.claude/`.
- **Roadblock — Node.js missing or too old:** if `npm` errors mention node versions,
  explain that Node.js is the engine that runs these build tools, and send them to
  https://nodejs.org (LTS download). Then retry.

### 2. Add Tailwind CSS

```bash
npx astro add tailwind --yes
```

This installs Tailwind v4 and wires it into Astro automatically.

### 3. Git hygiene — BEFORE anything else

Verify `.gitignore` exists and includes at minimum:

```
node_modules/
dist/
.env
.env.local
.env.production
.vercel
```

This is a non-negotiable: `.env` files hold secret keys and must never reach GitHub.

### 4. Design the design system  ← the frontend-design skill moment

This is where the site stops being a template and becomes THEIR site.

1. **Read the frontend-design skill** (`$HOME/.claude/skills/frontend-design/SKILL.md`)
   if installed, and follow its process: develop a visual thesis grounded in the
   firm's identity, then make deliberate decisions about typography, color, and
   layout. Avoid the recognizable AI-default looks the skill warns about.
2. **Start from the chosen style category.** The brief's Design Direction section
   names a style category from `$HOME/.claude/hc-firm-site/DESIGN_REFERENCES.md`
   (Playful & Smart, Modern & Sophisticated, a mix, or custom). Read that category's
   section, then use WebFetch to visit 1–2 of its reference sites for fresh detail.
   Borrow principles — the typographic attitude, palette logic, layout moves — never
   pixels: no copied copy, no recognizable clone of a reference homepage. If the
   attorney chose a custom direction, their references replace the curated ones.
3. **Ground it in the brief.** The Design Direction section of FIRM_BRIEF.md has
   their color preferences, admired sites, and the firm's tone ("formal and precise"
   vs "approachable and plain-speaking" should produce visibly different designs —
   even within the same category). If they shared their own admired-site URLs, fetch
   and study those too.
4. **Present 2–3 named design directions** to the attorney in plain English, each a
   distinct interpretation of their chosen category for THEIR firm. For each: the
   overall feel, the heading + body font pairing, the color palette (with hex
   swatches described in words — e.g. "deep navy, warm off-white, brass accent"),
   and what kind of firm it signals. Make a recommendation and say why.
5. Use AskUserQuestion to let them pick (or mix — "direction A but with B's colors"
   is a fine answer).
6. **Record the chosen direction** in `.planning/DECISIONS.md` — future sessions must
   honor it.

Then implement it in `src/styles/global.css` using Tailwind v4's `@theme` block:
color tokens, font families (loaded via Google Fonts in the layout), a type scale,
and spacing. Comment every token in plain English — the attorney will read this file.

### 5. Build the layout shell

Create:
- `src/layouts/BaseLayout.astro` — wraps every page: `<head>` with charset/viewport/
  title/description props, Google Fonts links, global CSS import, skip-to-content
  link (accessibility — do it now, not in Phase 4), Header, `<main>` slot, Footer.
- `src/components/Header.astro` — sticky nav: firm name/logo left, nav links, phone
  number, and the ONE CTA button. Mobile hamburger menu that actually works.
- `src/components/Footer.astro` — firm name, address placeholder, and the required
  legal text: the general disclaimer ("The information on this website is for general
  informational purposes only...") and **"Attorney Advertising"** — required on every
  page in many states. See guide Part 5 for exact language. This goes in NOW so it's
  impossible to launch without it.
- `src/pages/index.astro` — a real-looking placeholder: the firm name set in the new
  display font, the tagline, and the CTA button. Enough that the deploy moment feels
  like *their* site, not "Hello World."

### 6. Verify locally

```bash
npm run build
```

Must complete with zero errors. If a dev server preview is available, check the
shell renders correctly on mobile and desktop widths before shipping.

### 7. Ship it (first code push)

Follow the standard ship ritual from build.md. For this first push, explain what's
about to happen: "I'm sending your code to GitHub. The moment it lands, Vercel will
notice, build the site, and publish it to your live URL — usually within a minute."

**Roadblock — push rejected (remote has README):** if not already resolved during
setup, run `git pull origin main --no-rebase --allow-unrelated-histories`, then push.

**Roadblock — Vercel build fails:** read the failure from the attorney (have them
paste the Vercel error, or check the deploy status page). Most common cause: Vercel's
framework preset. It should auto-detect Astro; if not, tell them to set Framework
Preset to "Astro" in Vercel → Project → Settings → Build & Development and redeploy.

Then send them to their live URL. Let them have the moment.

---

## Success criteria (all must be TRUE before approval)

1. Visiting the Vercel URL loads the site over HTTPS with no errors
2. The header, footer, and placeholder homepage render correctly on mobile AND desktop
3. The footer contains the general disclaimer and "Attorney Advertising"
4. The design system (colors, fonts, spacing) is defined in `global.css` and visibly
   applied — this does not look like a default template
5. `npm run build` completes with zero errors
6. `.gitignore` excludes `.env` files; nothing sensitive is in the repo
7. The attorney picked the design direction and it's logged in DECISIONS.md
