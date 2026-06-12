# Design References — Starting Points, Not Blank Pages

Most attorneys can't articulate a design direction from scratch — and shouldn't have
to. This file curates two proven style directions for modern law firm websites, each
anchored by real reference sites. The attorney picks the direction that fits their
firm during intake; Phase 1 grounds its design proposals in that direction.

**How Claude uses this file:**

1. **During intake (Group 5):** present the two categories below and ask which fits
   the firm. If the attorney names their own reference sites or a different
   direction entirely, THEIR preference wins — this file is the default, not a cage.
2. **During Phase 1 (design system):** read this file, then use WebFetch to visit
   1–2 reference sites from the chosen category for fresh detail. Ground the 2–3
   design directions you present in the category's traits — but adapted to THIS
   firm's brief (practice area, tone, clientele). A trusts-and-estates firm and a
   startup law firm should not get the same design even within the same category.
3. **Borrow principles, never pixels.** These are real, operating law firms. Take
   the typographic attitude, the palette logic, the layout moves — never their copy,
   their logo treatments, or a recognizable clone of their homepage. The output must
   be distinctly the attorney's firm.

---

## Category 1 — Playful, Smart

**The feel:** A firm that takes the work seriously but not itself. Warm, human,
founder-to-founder energy. Breaks law-firm convention on purpose — and the
unstuffiness IS the trust signal: "we're like you, not like BigLaw."

**Best fit:** solo and small firms serving startups and founders; attorneys whose
brief says "approachable," "plain-speaking," or "direct"; firms whose clients are
younger companies that distrust corporate polish.

### Reference sites

**[Darwin Legal](https://darwinlegal.com/)** — startup-focused firm with
evolutionary-theme whimsy. What works (visually verified):
- Palette: white/cream page, deep navy text and footer, post-it yellow and pink
  sticky notes, soft sky-blue rounded cards, pastel orange/yellow/blue plan cards
- Visual playfulness with a system: sticky notes carrying hand-doodled stick
  figures, handwritten margin annotations with arrows ("Is legal an expensive
  distraction?"), even emoji in the footer nav — charm that never undermines
  credibility
- Typography with personality: a handwriting accent font + monospace/small-caps
  nav layered over a clean base — three distinct type voices, each with a job
- Benefit-led, conversational headlines ("Make legal a competitive advantage");
  pill-shaped outline buttons; soft, educational CTAs and transparent flat-fee plans

**[Likewise Law](https://www.likewise.law/)** — "built for founders, by founders."
What works (visually verified):
- Stark white page, big black Inter headlines, ONE bright green accent doing all
  the work: the "Hey," in the hero, the underlines beneath section labels, the
  "Let's chat" pill button. Pale mint cards (#ebfaf1) for testimonials and logo tiles.
- Radically personal: leads with the founder's own startup journey, not
  institutional credentials; founder photo with his pug. Personality as positioning.
- Credibility displayed HUGE: "$3B in Client Exits" / "$5B in Client Fundraises"
  as giant numerals, plus quiet gray logo grids (past firms, clients)
- A single hand-drawn squiggle under the hero — one playful gesture on an
  otherwise disciplined page
- Streamlined one-narrative homepage: intro → proof → founder bio → clients →
  contact. Friction-free conversational CTA ("Let's chat") repeated throughout.

### Design vocabulary for this category
- **Type:** a clean geometric/neutral sans for everything, PLUS one personality
  accent — handwritten, serif italic, or monospace — used sparingly (labels,
  annotations, pull-quotes)
- **Color:** light backgrounds, near-black or navy text, one saturated friendly
  accent (bright green, blue, coral); soft pastel cards or post-it tones for
  section variety
- **Copy posture:** first person, contractions, short sentences, the occasional
  joke; headlines talk to the client like a smart friend; big bold numbers for
  credibility (deals closed, years, dollars)
- **Layout:** generous but not austere; ONE or TWO hand-drawn touches (a squiggle,
  a doodle, a sticky note) give warmth — restraint keeps it smart rather than
  childish; motion can be bouncy

---

## Category 2 — Modern, Sophisticated

**The feel:** Precision, speed, quiet confidence. Reads like a top-tier product
company that happens to practice law. Minimal, typographically disciplined,
credibility through restraint and proof rather than ornament.

**Best fit:** corporate/transactional practices serving funded companies and
executives; attorneys whose brief says "formal and precise," "elite," or "modern";
firms competing against BigLaw on quality and against legal-tech on speed.

### Reference sites

**[Crosby](https://crosby.ai/)** — "Big Law Quality at AI Speed." What works
(visually verified):
- EDITORIAL, not SaaS: a giant high-contrast serif wordmark spanning the full page
  width like a newspaper masthead, serif display headlines throughout, on a warm
  cream/ivory ground with black ink and ONE red accent (buttons, blocks)
- An abstract black ink/smoke art object in the hero — a single piece of art
  instead of a stock photo or illustration clutter
- Proof done quietly: a large wall of client logos in muted gray tiles; an
  index-style list of team first names set large in serif, like a book's table
  of contents
- Structure: masthead → claim → logo wall → testimonial → team index → CTA.
  Emotional hook first, logical reassurance second.

**[Optimal Counsel](https://www.optimalcounsel.com/)** — the disruptor posture.
What works (visually verified):
- Dark, moody palette confirmed: deep charcoal-navy (#201E27) with pale blue-gray
  alternate sections — premium without being corporate
- A type-contrast headline move: "LEAN. MODERN." in grotesque caps followed by
  "ELITE LEGAL COUNSEL." in serif caps — two voices in one hero
- Angular, chamfered section edges (notched corners) give it a precise, technical
  character
- Social proof with teeth: candid client testimonials that name the BigLaw firms
  they left; restrained single CTA ("Get in touch")
- Build-time note: the site reveals content on scroll, so a static fetch or
  screenshot shows mostly empty dark space — don't mistake that for the design

**[General Counsel](https://general.legal/)** — warm-minimal, metrics-forward.
What works (visually verified):
- The warm-neutral palette: cream background (#F4F0EC) with near-black ink
  (#211F1C) — softer and more distinctive than pure white/black
- Fine bronze/gold contour-line generative art flowing across the hero — texture
  and motion without imagery; the headline's key phrase ("scales like software")
  highlighted in the same bronze
- Disciplined two-font system: a modern grotesque (Geist) + its matching
  monospace for labels and data; dark pill-shaped CTAs
- A spec-table hero: turnaround, pricing model, and team quality listed like
  product specs next to the headline — transparency AS the sophistication
- Outcome-first headlines ("Outside counsel that scales like software")

**[Manifest Law](https://manifestlaw.com/)** — polished modern brand. Note: this
site blocks automated readers (Cloudflare); attempt WebFetch at build time, and
if it fails, lean on the other three references in this category.

### Design vocabulary for this category
- **Type:** two proven flavors — (a) PRODUCT-MODERN: one excellent grotesque
  (Geist, Inter, Söhne-alikes) across a strong size scale, optional matching
  monospace for eyebrows/data; or (b) EDITORIAL: a high-contrast serif for
  masthead-scale display (Crosby-style), grotesque for everything else. Type
  contrast between serif and sans in the same lockup is a legitimate signature
  move (Optimal).
- **Color:** either warm-minimal (cream + ink + one accent — red or bronze both
  proven) or dark-premium (charcoal + off-white + one cool accent). Never more
  than one accent.
- **Copy posture:** short declarative sentences; specifics over adjectives
  (metrics, fees, turnaround — even formatted as a spec table); zero exclamation
  marks
- **Layout:** strict grid, generous whitespace, restrained motion (fades and
  scroll-reveals, not bounces); logos/testimonials as quiet proof blocks; one
  piece of abstract art or generative texture beats any stock photo

---

## Guardrails (both categories)

- The HC non-negotiables always win: ONE call to action, required disclaimers,
  "Attorney Advertising," WCAG AA contrast — even when a reference site does
  otherwise.
- These references skew startup/corporate law. For other practice areas (family,
  immigration, estates, litigation), keep the category's design vocabulary but
  recalibrate the copy posture to the clientele — a person hiring an immigration
  lawyer needs reassurance, not velocity metrics.
- If the attorney's brief or admired-sites answer points somewhere else entirely,
  follow the attorney. Record whatever direction is chosen in DECISIONS.md.
