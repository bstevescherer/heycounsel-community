# Phase 3 Playbook — Leads + SEO

**Goal:** Visitors can contact the firm from any page, submissions reach the
attorney's inbox, and every page is optimized for Google AND for AI answer engines
(ChatGPT, Claude, Perplexity) that increasingly answer "find me a lawyer for X."

**Read before building:**
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — Part 2 (SEO), Part 3 (AEO), Part 5 (contact form disclaimer — exact required language)
- `$HOME/.claude/skills/seo-aeo-best-practices/` (if installed) — read `SKILL.md`,
  then `references/structured-data.md` before the JSON-LD work, `references/technical-seo.md`
  before metadata/sitemap work, and `references/aeo-considerations.md` before the FAQ
  sections. **How the two references divide the work:** the Law Firm Website Guide says
  what a LAW FIRM site needs (which schema types, disclaimer placement, what clients
  search for); the seo-aeo skill says how to implement it correctly and currently
  (metadata patterns, schema syntax, sitemap mechanics, what AI engines actually cite).
  Where they conflict on technical implementation, the seo-aeo skill wins; where they
  conflict on law-firm requirements, the guide wins.
- `$HOME/.claude/skills/stop-slop/references/phrases.md` (if installed) — every
  FAQ answer and meta description is a piece of copy too; run them through the
  same AI-tell filter as Phase 2 content
- `.planning/FIRM_BRIEF.md` — Security & Compliance Requirements section

---

## Phase decisions (ask up front)

### Decision 1 — How the contact form delivers leads (the big one)

First ask: **"How do you currently manage new client inquiries? Email inbox? A CRM?
Practice management software like Clio?"** The right tool depends on their answer.

Then present the options in plain English:

| Option | What it is | Best for | Cost |
|--------|-----------|----------|------|
| **Web3Forms** (recommended default) | Form submissions arrive as emails. One API key, no database, no account for visitors. | "Just email me the leads" — most solo/small firms | Free tier is plenty |
| **Formspree** | Same idea, slightly different features (dashboard of submissions) | Wanting a web dashboard of past leads | Free tier available |
| **Supabase + Resend** | A real database storing every lead + email notifications | Firms that want to build on the data later (CRM-ish, dashboards) | Free tiers; more moving parts |
| **CRM/practice-management webhook** | Submissions go straight into the tool they already use | Firms already living in Clio/HubSpot/etc. | Depends on their tool |

Recommend Web3Forms unless their intake workflow says otherwise. Whatever they pick,
**record it in DECISIONS.md and PROGRESS.md's Phase Notes** — future sessions need
to know.

### Decision 2 — Booking link

Do they use Calendly (or similar) for scheduling consultations? If yes, the form's
success message includes their booking link ("Want to skip the back-and-forth?
Book directly here"). Get the URL.

---

## Build steps — Lead generation

### 1. Contact modal

A popup form (`<dialog>`-based) available from every page — the CTA button opens it.
Fields: name, email, phone (optional), "briefly, what do you need help with?"
Keep it short; every extra field costs conversions.

### 2. The attorney-client disclaimer — NON-NEGOTIABLE

Directly above the submit button, the disclaimer from guide Part 5: submitting the
form does not create an attorney-client relationship, and the visitor should not
send confidential or time-sensitive information. This is a bar compliance
requirement, not a style choice.

### 3. Wire up the chosen provider

- API keys go in **Vercel environment variables only** — walk the attorney through
  adding them in Vercel → Project → Settings → Environment Variables. Local `.env`
  for development, which is gitignored. NEVER in source code.
- **Server-side validation** of submissions (not just browser-side) wherever the
  chosen option allows it.
- **Honeypot field** for spam protection: an invisible field humans never fill but
  bots do; submissions with it filled are silently discarded.
- Success state: confirmation message + Calendly link if they have one.
- **Test it end-to-end:** submit a real test lead and confirm the attorney receives
  it before calling this done. Do not skip this.

### 4. ABA 477R note

Pre-engagement inquiries are confidential communications. The chosen delivery chain
(form → provider → inbox) must be HTTPS end-to-end and the disclaimer must warn
against sending confidential details. Mention this to the attorney — it's their
professional obligation and they should understand how their site meets it.

---

## Build steps — SEO + AEO

### 5. Meta tags on every page

BaseLayout accepts `title` and `description` props; every page sets unique,
genuinely descriptive values (not keyword stuffing). Add Open Graph + Twitter card
tags so shared links look right on LinkedIn (where lawyers actually share).

### 6. JSON-LD structured data

Structured data is machine-readable labeling that tells Google and AI engines
exactly what each page is. Add via a `schema` prop on BaseLayout:

- **LegalService** — each practice area page (with areaServed, the firm's address)
- **Person** — each attorney page (jobTitle, worksFor, alumniOf, knowsAbout)
- **LocalBusiness/LegalService** — homepage (name, address, phone, geo, hours)
- **FAQPage** — any page with an FAQ section
- **Article** — each blog post (headline, author → the attorney's Person, datePublished)

Validate at least one page of each type with Google's Rich Results Test
(share the URL with the attorney so they can see it pass).

### 7. Sitemap + robots.txt

```bash
npx astro add sitemap --yes
```

Set the `site` URL in `astro.config.mjs` (their live URL). Add `public/robots.txt`
pointing to the sitemap. Both must be reachable at /sitemap-index.xml and /robots.txt.

### 8. FAQ sections (the AEO play)

AI answer engines lift direct question-and-answer content. Add an FAQ section to
each practice area page: 3–5 real questions clients actually ask (pull from the
brief's "client fears" answers), each answered in 2–4 plain sentences, marked up
with FAQPage schema. Questions phrased the way clients say them ("How much does
it cost to form an LLC in New York?"), not lawyer-speak.

### 9. Local SEO

Firm name, address, phone (NAP) consistent everywhere — footer, contact section,
schema. City/state named naturally in page copy (e.g. "New York business formation").
Suggest the attorney claim their free Google Business Profile (external task —
give them the 3-step version).

---

## Success criteria (all must be TRUE before approval)

1. The CTA on any page opens the contact form; a test submission reached the
   attorney's actual inbox (or CRM)
2. The attorney-client disclaimer appears above the submit button
3. API keys exist only in Vercel env vars + gitignored `.env` — verified absent
   from the repo
4. Honeypot spam protection is active
5. Every page has a unique title + description; OG/Twitter tags present
6. JSON-LD validates for each page type (LegalService, Person, LocalBusiness,
   FAQPage, Article)
7. Sitemap and robots.txt are live at their URLs
8. Every practice area page has an FAQ section with schema
9. `npm run build` completes with zero errors
