---
name: hc-firm-site:page
description: Create a firm website page — practice area, attorney profile, staff profile, or blog post — with SEO, schema, and disclaimers baked in
argument-hint: "[practice-area | attorney | staff | blog]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - AskUserQuestion
---

<objective>
Create a fully structured page for a law firm website — with correct SEO metadata, JSON-LD structured data, legal disclaimers, and StoryBrand-informed copy — specific to the firm in FIRM_BRIEF.md.

Supported page types:
- `practice-area` — Service page with FAQ schema, SEO meta, disclaimer, CTA
- `attorney` — Attorney profile with Person schema, bar admission, areas of focus
- `staff` — Non-attorney staff profile with appropriate structure (no bar/practice areas)
- `blog` — Blog post with Article schema, author attribution, disclaimer

This skill runs DURING the build, after the site foundation exists. It reads the project's existing pages to match the established design system — it does not impose a fixed template.

If FIRM_BRIEF.md does not exist, stop and tell the user to run /hc-firm-site:setup first.
</objective>

<process>

## Step 1 — Verify prerequisites

Check that the firm brief exists:

```bash
[ -f ".planning/FIRM_BRIEF.md" ] && echo "EXISTS" || echo "MISSING"
```

**If MISSING:** Stop and show:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Setup required first
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

No FIRM_BRIEF.md found in this project.

Run /hc-firm-site:setup first to set up your firm's
profile — that file tells Claude everything about
your firm, team, and clients so the pages it creates
are specific to you, not generic.
```

**If EXISTS:** Read `.planning/FIRM_BRIEF.md` and `.planning/LAW_FIRM_WEBSITE_GUIDE.md` into context. Continue.

---

## Step 2 — Determine page type

**If a page type was passed as an argument** (`$ARGUMENTS` is one of: `practice-area`, `attorney`, `staff`, `blog`):
Use it and skip the question.

**If no argument was provided:**
Use AskUserQuestion:
- Question: "What type of page would you like to create?"
- Options:
  - "Practice area page (e.g., M&A, Employment, Contracts)"
  - "Attorney profile"
  - "Staff profile (non-attorney — ops, intake, paralegal, etc.)"
  - "Blog post"

Map the selection to the type: `practice-area`, `attorney`, `staff`, or `blog`.

---

## Step 3 — Read existing pages for design reference

Before generating anything, look at what's already been built so the new page matches the existing design system:

```bash
# Check for existing pages to use as style reference
ls src/pages/practice-areas/ 2>/dev/null | head -3
ls src/pages/attorneys/ 2>/dev/null | head -3
ls src/content/blog/ 2>/dev/null | head -3
```

Read one existing page of the same type if available. If none exist yet, read any existing `.astro` page in `src/pages/` to understand the project's layout, component imports, and Tailwind classes. The new page must be visually and structurally consistent with what's already there.

---

## Step 4 — Intake questions (type-specific)

Ask the relevant group below. Use AskUserQuestion. Remind the user they can use dictation to answer faster.

---

### If type is `practice-area`:

Use AskUserQuestion:
- Question: """
Tell me about this practice area:

1. Name of the practice area
   (e.g., "Mergers & Acquisitions", "Employment Law", "Commercial Contracts")

2. In 2-3 sentences, what does the firm do in this area?
   Focus on the client's outcome, not the legal process.

3. Who is the typical client for this practice area?
   (pull from FIRM_BRIEF.md if applicable, or describe)

4. What are the 3-5 most common specific services or matters in this area?
   (e.g., "LOI drafting", "asset purchase agreements", "due diligence review")

5. What are 3-5 questions clients frequently ask about this area?
   These will become the FAQ section — write them as a client would ask them,
   not as a lawyer would frame them.
   (e.g., "How long does an acquisition typically take?" not "What is the M&A timeline?")

6. Any specific results, deal sizes, or client types you want to mention?
   (optional — leave blank if you prefer not to)

💡 Tip: use dictation (Fn Fn on Mac) to talk through these — it's much faster.
"""

---

### If type is `attorney`:

Use AskUserQuestion:
- Question: """
Tell me about this attorney. If they're already in your FIRM_BRIEF.md,
you can just say their name and I'll pull the details from there — or add
anything that's missing.

If not in the brief yet, please share:

1. Full name and title (e.g., "Managing Partner", "Senior Associate")
2. Bar admission — state(s) and year(s)
3. Areas of focus at the firm
4. Law school and undergraduate education (if you want it on the site)
5. A few sentences about their background — how they got here,
   what kinds of clients or matters they're known for
6. Do you have a professional headshot for them? (Yes / No)
7. Email address and/or phone number to display on their profile (optional)

💡 Tip: use dictation (Fn Fn on Mac) to talk through these.
"""

---

### If type is `staff`:

Use AskUserQuestion:
- Question: """
Tell me about this team member. If they're in your FIRM_BRIEF.md already,
just say their name.

If not yet in the brief:

1. Full name and title (e.g., "Head of Operations", "Intake Specialist")
2. What do they actually do day-to-day? 
   (describe their role in plain terms — no need to make it sound formal)
3. What are their main responsibilities? 
   (3-5 bullet points is fine)
4. Brief background — where did they come from, what do they bring?
5. Do you have a professional photo for them? (Yes / No)
6. Email address to display on their profile (optional)

💡 Tip: use dictation (Fn Fn on Mac) to talk through these.
"""

---

### If type is `blog`:

Use AskUserQuestion:
- Question: """
Tell me about this blog post:

1. What is the topic or question this post answers?
   Write it as the question a client would actually type into Google.
   (e.g., "What should be in a founder's employment agreement?"
    not "Employment Agreement Best Practices")

2. What are the 3-5 main points or takeaways?
   Bullet points are fine — I'll turn these into proper prose.

3. Who is the author?
   (If there's only one attorney at the firm, I'll use them automatically.
    Otherwise, whose name should appear on this post?)

4. Are there any specific examples, deal types, or client scenarios
   you want to reference? (optional)

5. Roughly how long should this be?
   - Short (400–600 words) — quick, punchy answer
   - Medium (700–1,000 words) — thorough answer with context
   - Long (1,200+ words) — comprehensive guide, good for AEO

💡 Tip: use dictation (Fn Fn on Mac) — especially for the main points.
   Just talk through what you'd tell a client who asked this question.
"""

---

## Step 5 — Generate the page

Using the intake answers, FIRM_BRIEF.md context, and the existing page design as a reference, create the page file.

### File locations:

| Type | Location |
|---|---|
| `practice-area` | `src/pages/practice-areas/[slug].astro` |
| `attorney` | `src/pages/attorneys/[slug].astro` |
| `staff` | `src/pages/attorneys/[slug].astro` |
| `blog` | `src/content/blog/[slug].md` |

The slug should be the name in lowercase with spaces replaced by hyphens.
Examples: `mergers-and-acquisitions`, `jane-smith`, `what-is-a-fractional-gc`

---

### Requirements for every page type:

**SEO metadata (all pages):**
- Unique `title` — format: `[Page Topic] — [City] | [Firm Name]` (under 60 characters)
- Unique `description` — one sentence, under 155 characters, written for a human scanning search results

**Copy principles (all pages):**
- Follow StoryBrand: lead with the client's situation or problem, not the firm's credentials
- Use plain, direct language — no jargon unless unavoidable
- One primary CTA per page: "Schedule a Consultation" or "Get in Touch"

---

### Additional requirements by type:

**`practice-area`:**
- JSON-LD schema: `FAQPage` (from the FAQ questions provided) + `BreadcrumbList`
- FAQ section: each question as a subheading (`<h2>` or `<h3>`), answer immediately below in 2-4 sentences. Direct, complete answers — do not tease the answer to force a call.
- Disclaimer at the bottom of the page:
  > "This page provides a general overview of [practice area] matters. Every situation is different. Contact us to discuss the specifics of your matter."
- "← Back to services" link at top
- CTA button at bottom

**`attorney`:**
- JSON-LD schema: `Person` with `name`, `jobTitle`, `worksFor`, `url`, `knowsAbout` (areas of focus), `address`
- Sections: photo/avatar, name + title, contact info (if provided), bio, bar admission, areas of focus, education
- If no photo: show initials in a circular avatar (match existing pattern in the project)
- CTA button: "Work with [First Name]" or "Get in Touch"
- "← Meet the team" link at top

**`staff`:**
- JSON-LD schema: `Person` with `name`, `jobTitle`, `worksFor`, `url`, `address`
- Do NOT include bar admission or practice area sections — these are for attorneys only
- Sections: photo/avatar, name + title, contact info (if provided), bio, responsibilities (as tags/pills), background
- CTA button: "Get in Touch"
- "← Meet the team" link at top

**`blog`:**
- Frontmatter: `title`, `description`, `pubDate` (today's date), `author` (attorney name from brief), `tags` (2-3 relevant tags)
- Disclaimer at the top or bottom of each post:
  > "This article is for informational purposes only and does not constitute legal advice. Laws vary by jurisdiction. Consult a qualified attorney for advice specific to your situation."
- JSON-LD schema is handled by the blog post layout automatically (Article schema) — no manual schema needed in the Markdown file
- Write the post as a complete, useful answer — not a partial tease. AI engines cite pages that answer questions fully.

---

## Step 6 — Confirm creation

After writing the file, show:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ Page created
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  [file path]

  Title:    [page title]
  URL:      /[url path]
  Schema:   [schema types applied]
  Disclaimer: ✓ included

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Next steps
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  • Run `npm run build` to check for errors
  • Preview at localhost to verify it looks right
  • Run /hc-firm-site:page again to create another page
  • Run /hc-firm-site:check when all pages are done
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

</process>
