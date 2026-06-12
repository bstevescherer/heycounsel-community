# Phase 2 Playbook — Content

**Goal:** Every page of the site exists with real content. A visitor can navigate
the full site and read everything: homepage with all sections, one dedicated page
per practice area, attorney profiles, and a blog with starter articles.

**Read before building:**
- `.planning/FIRM_BRIEF.md` — the team, clients, positioning, and pricing sections drive everything here
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — Part 1 (StoryBrand), Part 4 (conversion + pricing transparency), Part 5 (disclaimers), Part 6 (business-lawyer messaging)
- `$HOME/.claude/skills/frontend-design/SKILL.md` — apply the established design direction to every new page; do not drift from Phase 1's system
- `$HOME/.claude/skills/seo-aeo-best-practices/references/eeat-principles.md` (if installed) — Google's EEAT framework; this phase is where authority gets built into the content
- `.planning/DECISIONS.md` — the chosen design direction and CTA

---

## Phase decisions (ask up front)

1. **Pricing on the site?** Showing real numbers (flat fees, hourly ranges) converts
   better — clients fear cost surprises more than high costs. Recommend yes, using
   the pricing from the brief. But it's their call. If yes: confirm the exact fees
   and scope language to publish. If no: the pricing section becomes "how we bill"
   without numbers.
2. **Blog topics.** Propose 3–5 starter article topics based on their practice areas
   and what their clients search for (guide Part 6 has patterns like "what should I
   ask before signing X"). Let them adjust the list. Each article must be attributed
   to a named attorney from the brief.
3. **Headshots.** If the brief says headshots are ready, ask the attorney to drop
   them into the project folder (explain where) — compress anything over 200 KB
   before committing. If not ready, use tasteful initial-based placeholders sized
   correctly so real photos can swap in later with zero layout changes.

---

## Build steps

### 1. Single source of truth for firm data

Create `src/data/firm.ts` — name, tagline, address, phone (with tel: href),
email, bar jurisdiction, practice areas, attorneys. Every component imports from
here. When the attorney later says "update my phone number," it changes in ONE place.

### 2. Homepage — one scrollable page, sections in this order

This order is the conversion-tested structure from guide Part 4:

1. **Hero** — StoryBrand headline (the client's problem/aspiration, NOT "Welcome to
   our firm"), one-line subtext on how the firm helps, the CTA button, phone number.
2. **Services** — one card/block per practice area, each linking to its dedicated page.
3. **Pricing** — per the phase decision above. Flat fees with defined scope, filing
   fees broken out separately, plus a short "what affects pricing?" FAQ.
4. **Attorneys** — photo/placeholder, name, title, one-line focus; links to profiles.
5. **About** — short, client-focused ("we built this firm because clients deserve X"),
   not a firm-history essay.
6. **Contact anchor** — final CTA section with the consultation button, phone, and
   address. (The form itself arrives in Phase 3 — for now the CTA can link to
   tel:/mailto: so the button is never dead.)

Nav links anchor-scroll to each section (`/#services` style so they work from inner
pages too).

### 3. Practice area pages — one URL each (non-negotiable)

`src/pages/practice-areas/[slug].astro` or individual files. Never consolidate onto
one page — each area is its own Google landing page. Each page includes:
- StoryBrand opening: the client's problem in their words
- What's included / how the engagement works
- Who it's for (name the client types explicitly — guide Part 6)
- Pricing for that service if public
- The CTA
- The practice-area disclaimer (guide Part 5)

### 4. Attorney profile pages

One page per attorney from the brief: headshot, name, title, bar admission,
education, focus areas, background written in the firm's voice, contact info,
and the CTA. (JSON-LD Person schema is added in Phase 3 — structure the page
so the data is easy to mark up.)

### 5. Blog via Astro Content Collections

- Define the collection schema (`src/content.config.ts`): title, description, date,
  author (must match an attorney name from firm.ts).
- Blog listing page at `/blog` + dynamic post route.
- Write the 3–5 approved starter articles as Markdown. Genuinely useful, plain-English,
  client-facing. 800–1,200 words each.
- **Every post ends with the blog disclaimer** (guide Part 5) and shows its author.

### 6. Copy rules for everything above

- StoryBrand throughout: client is the hero; firm is the guide; every section moves
  toward the CTA.
- Plain English, short sentences. If a paragraph sounds like a retainer agreement,
  rewrite it.
- ONE call to action, everywhere. No "Subscribe," no "Learn more" competing with it.
- Match the tone from the brief.
- **Build in EEAT** (per the seo-aeo skill's eeat-principles reference): attorneys are
  a textbook EEAT case — real credentials, real bar admissions, real experience. Show
  it: every blog post by a named attorney whose profile proves their expertise; bios
  with specifics (years, matters handled, admissions) not adjectives; first-hand
  experience in the writing ("in the formations we handle..." beats generic content).
  Google and AI engines both rank legal content heavily on demonstrated authority.

### 7. Images

- Everything under 200 KB. Compress before committing
  (`npx @squoosh/cli` or `sips` on Mac — explain whichever is used).
- Every image gets descriptive alt text NOW (cheaper than retrofitting in Phase 4).
- No generic stock photos of gavels, columns, or handshakes.

---

## Mid-phase checkpoint

This is the longest phase. After the homepage is done (before practice
area/attorney/blog pages), do a mini ship ritual: commit, push, have the attorney
look at the live homepage. Course-correcting on tone and design NOW is much cheaper
than after 10 more pages exist. Then build the remaining pages and do the full
phase ship at the end.

---

## Success criteria (all must be TRUE before approval)

1. Homepage scrolls through all sections with working anchor nav
2. Every practice area has its own URL with full content and disclaimer
3. Every attorney has a profile page reachable from the homepage
4. Blog listing + all starter posts render; every post has an author and disclaimer
5. Pricing section matches what the attorney approved (numbers or no numbers)
6. All copy is StoryBrand-consistent; exactly one CTA exists site-wide
7. Every image is under 200 KB and has alt text
8. The whole site looks consistent with the Phase 1 design direction on mobile
   and desktop
9. `npm run build` completes with zero errors
