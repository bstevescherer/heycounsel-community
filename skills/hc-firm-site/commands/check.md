---
name: hc-firm-site:check
description: Pre-launch audit — checks every page for disclaimers, SEO metadata, structured data, image sizes, and other launch blockers
allowed-tools:
  - Read
  - Bash
  - Glob
---

<objective>
Run a pre-launch audit of the law firm website and produce a pass/fail checklist of everything that needs to be fixed before going live.

Checks performed:
- Footer disclaimer present on every page (via shared layout)
- Contact form disclaimer before submit button
- Blog post disclaimers on each post (or injected by blog layout)
- Practice area page disclaimers
- Meta title on every page
- Meta description on every page
- JSON-LD structured data: LegalService on homepage, Person on attorney pages, FAQPage on practice area pages, Article on blog posts
- Images over 200 KB in /public
- Practice area pages with dedicated URLs (one per practice area in FIRM_BRIEF.md)
- Blog posts with author attribution

If FIRM_BRIEF.md does not exist, stop and direct the user to run /hc-firm-site:setup first.
</objective>

<process>

## Step 1 — Verify prerequisites

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
profile, then build your site before using this check.
```

**If EXISTS:** Read `.planning/FIRM_BRIEF.md` for the firm name and practice areas listed. Continue.

---

## Step 2 — Run all audit checks

Run the bash commands below to gather raw data. Do NOT dump the raw output at the user — use it to build the report in Step 3.

---

### Check A — Footer disclaimer

```bash
# Look for the standard disclaimer text in shared layout and component files
grep -rl "does not constitute legal advice" src/ 2>/dev/null
grep -rl "attorney-client relationship" src/layouts/ src/components/ 2>/dev/null
```

**Pass if:** At least one layout or shared component file contains both phrases — meaning every page gets the disclaimer via the shared footer.

**Fail if:** Neither phrase appears in a layout/component file (only in individual pages, meaning some pages may not have it).

---

### Check B — Contact form disclaimer

```bash
# Look for pre-submission warning in contact form files
grep -rl "does not create an attorney-client relationship\|Submitting this form\|confidential" src/ 2>/dev/null | grep -i "contact\|form\|modal"

# Also check all form components in case the contact form has a different name
grep -rl "does not create an attorney-client relationship\|Submitting this form" src/ 2>/dev/null
```

**Pass if:** A contact or form component contains language that:
1. States submitting does not create an attorney-client relationship, AND
2. Warns not to include confidential/privileged information until a relationship is established

**Fail if:** No such language exists near the form submit button.

---

### Check C — Blog post disclaimers

```bash
# Count total blog posts
TOTAL=$(ls src/content/blog/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Total blog posts: $TOTAL"

# Check if the blog layout auto-injects the disclaimer
grep -rl "informational purposes only\|does not constitute legal advice\|Consult a qualified attorney" src/layouts/ src/components/ 2>/dev/null | head -5

# List posts that are MISSING a disclaimer (in case layout doesn't inject it)
echo "--- Posts missing disclaimer ---"
for f in src/content/blog/*.md; do
  [ -f "$f" ] || continue
  if ! grep -q "informational purposes only\|does not constitute legal advice\|Consult a qualified attorney" "$f" 2>/dev/null; then
    echo "MISSING: $f"
  fi
done
echo "--- End ---"
```

**Pass if:** Every blog post has the disclaimer, OR the blog layout file automatically injects it (check layout files first before flagging individual posts).

**Fail if:** Any post is missing the disclaimer and the layout doesn't inject it automatically.

---

### Check D — Practice area page disclaimers

```bash
echo "--- Practice area disclaimer check ---"
for f in src/pages/practice-areas/*.astro; do
  [ -f "$f" ] || continue
  if grep -q "general overview\|Every situation is different\|Contact us to discuss" "$f" 2>/dev/null; then
    echo "OK: $f"
  else
    echo "MISSING: $f"
  fi
done
echo "--- End ---"
```

**Pass if:** Every practice area page contains a disclaimer similar to "This page provides a general overview... Every situation is different."

**Fail if:** Any practice area page is missing it.

---

### Check E — Meta titles

```bash
echo "=== Homepage ==="
grep -o 'title="[^"]*"\|title={`[^`]*`}\|title={"[^"]*"}' src/pages/index.astro 2>/dev/null | head -1

echo "=== Practice area pages ==="
for f in src/pages/practice-areas/*.astro; do
  [ -f "$f" ] || continue
  title=$(grep -o 'title="[^"]*"\|title={`[^`]*`}\|title={"[^"]*"}' "$f" 2>/dev/null | head -1)
  [ -z "$title" ] && echo "MISSING: $f" || echo "OK: $(basename $f) → $title"
done

echo "=== Attorney/staff pages ==="
for f in src/pages/attorneys/*.astro; do
  [ -f "$f" ] || continue
  title=$(grep -o 'title="[^"]*"\|title={`[^`]*`}\|title={"[^"]*"}' "$f" 2>/dev/null | head -1)
  [ -z "$title" ] && echo "MISSING: $f" || echo "OK: $(basename $f) → $title"
done

echo "=== Blog posts ==="
for f in src/content/blog/*.md; do
  [ -f "$f" ] || continue
  title=$(grep "^title:" "$f" 2>/dev/null | head -1)
  [ -z "$title" ] && echo "MISSING: $f" || echo "OK: $(basename $f) → $title"
done
```

---

### Check F — Meta descriptions

```bash
echo "=== Homepage ==="
grep -o 'description="[^"]*"\|description={`[^`]*`}\|description={"[^"]*"}' src/pages/index.astro 2>/dev/null | head -1

echo "=== Practice area pages ==="
for f in src/pages/practice-areas/*.astro; do
  [ -f "$f" ] || continue
  desc=$(grep -o 'description="[^"]*"\|description={`[^`]*`}\|description={"[^"]*"}' "$f" 2>/dev/null | head -1)
  [ -z "$desc" ] && echo "MISSING: $f" || echo "OK: $(basename $f)"
done

echo "=== Attorney/staff pages ==="
for f in src/pages/attorneys/*.astro; do
  [ -f "$f" ] || continue
  desc=$(grep -o 'description="[^"]*"\|description={`[^`]*`}\|description={"[^"]*"}' "$f" 2>/dev/null | head -1)
  [ -z "$desc" ] && echo "MISSING: $f" || echo "OK: $(basename $f)"
done

echo "=== Blog posts ==="
for f in src/content/blog/*.md; do
  [ -f "$f" ] || continue
  desc=$(grep "^description:" "$f" 2>/dev/null | head -1)
  [ -z "$desc" ] && echo "MISSING: $f" || echo "OK: $(basename $f)"
done
```

---

### Check G — JSON-LD structured data

```bash
echo "=== Homepage: LegalService or LocalBusiness schema ==="
grep -l '"LegalService"\|"LocalBusiness"' src/pages/index.astro src/components/*.astro src/layouts/*.astro 2>/dev/null || echo "NOT FOUND"

echo "=== Practice areas: FAQPage schema ==="
for f in src/pages/practice-areas/*.astro; do
  [ -f "$f" ] || continue
  grep -q '"FAQPage"' "$f" 2>/dev/null && echo "OK: $(basename $f)" || echo "MISSING FAQPage: $f"
done

echo "=== Attorney/staff pages: Person schema ==="
for f in src/pages/attorneys/*.astro; do
  [ -f "$f" ] || continue
  grep -q '"Person"' "$f" 2>/dev/null && echo "OK: $(basename $f)" || echo "MISSING Person: $f"
done

echo "=== Blog: Article schema (check layout first) ==="
grep -rl '"Article"\|"BlogPosting"' src/layouts/ src/components/ 2>/dev/null | head -3 || echo "NOT IN LAYOUT"
# Also check individual posts
for f in src/content/blog/*.md; do
  [ -f "$f" ] || continue
  grep -q '"Article"\|"BlogPosting"' "$f" 2>/dev/null && echo "OK (inline): $(basename $f)"
done
```

---

### Check H — Images over 200 KB

```bash
echo "--- Image size check ---"
FOUND_ANY=false
find public/ -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) 2>/dev/null | while read f; do
  size=$(stat -f%z "$f" 2>/dev/null || stat -c%s "$f" 2>/dev/null)
  if [ -n "$size" ] && [ "$size" -gt 204800 ]; then
    size_kb=$((size / 1024))
    echo "OVERSIZED ${size_kb}KB: $f"
    FOUND_ANY=true
  fi
done
echo "--- End ---"
```

**Pass if:** No images over 200 KB.

**Fail if:** Any image exceeds 200 KB. These slow down page load and hurt your Google PageSpeed score. Recommend squoosh.app (free, browser-based) or ImageOptim (free Mac app).

---

### Check I — Practice area pages with dedicated URLs

```bash
echo "=== Practice area pages in codebase ==="
ls src/pages/practice-areas/*.astro 2>/dev/null | xargs -I{} basename {} .astro || echo "No practice area pages found"

echo ""
echo "=== Practice areas in FIRM_BRIEF.md ==="
grep -A 30 -i "practice area\|services offered\|areas of practice" .planning/FIRM_BRIEF.md 2>/dev/null | grep -E "^\s*[-•*]\s|^\s*[0-9]+\.\s" | sed 's/^[[:space:]]*[-•*0-9.]\+[[:space:]]*//' | head -10
```

**Pass if:** There is at least one `.astro` file for each practice area listed in FIRM_BRIEF.md.

**Fail if:** A practice area appears in the brief but has no dedicated page. This matters for SEO — each practice area needs its own URL to rank independently.

---

### Check J — Blog post author attribution

```bash
echo "--- Blog author check ---"
for f in src/content/blog/*.md; do
  [ -f "$f" ] || continue
  author=$(grep "^author:" "$f" 2>/dev/null | head -1 | sed 's/author:[[:space:]]*//')
  if [ -z "$author" ]; then
    echo "MISSING AUTHOR: $f"
  else
    echo "OK: $(basename $f) → $author"
  fi
done
echo "--- End ---"
```

**Pass if:** Every blog post has a non-empty `author:` field in its frontmatter.

**Fail if:** Any post is missing the author field. Search engines and AI engines use author attribution to evaluate content credibility.

---

### Check K — HTTP security headers

```bash
# Check vercel.json for security headers configuration
echo "=== vercel.json headers ==="
cat vercel.json 2>/dev/null | grep -i "headers\|Content-Security\|X-Frame\|X-Content-Type\|Referrer\|Permissions" || echo "NOT FOUND in vercel.json"

# Check vercel.ts as alternative
echo "=== vercel.ts headers ==="
cat vercel.ts 2>/dev/null | grep -i "headers\|Content-Security\|X-Frame\|X-Content-Type" || echo "NOT FOUND in vercel.ts"
```

**Pass if:** A `vercel.json` or `vercel.ts` file exists with at least `X-Frame-Options`, `X-Content-Type-Options`, and `Referrer-Policy` configured.

**Fail if:** No security headers are configured. These are simple to add and protect against clickjacking, MIME sniffing, and information leakage — common low-effort attacks.

**Fix:** Add a `headers` block to `vercel.json`:
```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Frame-Options", "value": "DENY" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" },
        { "key": "Permissions-Policy", "value": "camera=(), microphone=(), geolocation=()" }
      ]
    }
  ]
}
```

---

### Check L — No secrets in source code or git

```bash
# Check for hardcoded API key patterns in source files
echo "=== Checking for hardcoded secrets ==="
grep -rn "re_[a-zA-Z0-9]\{20,\}" src/ api/ 2>/dev/null | grep -v "process\.env\|import\.meta\.env" | head -5 || echo "CLEAN"
grep -rn "eyJh[a-zA-Z0-9_-]\{20,\}" src/ api/ 2>/dev/null | grep -v "process\.env\|import\.meta\.env" | head -5 || echo "CLEAN"

# Check that .env files are in .gitignore
echo "=== .gitignore check ==="
grep "\.env" .gitignore 2>/dev/null || echo "WARNING: no .env entries in .gitignore"

# Check that no .env files are tracked in git
echo "=== .env files tracked in git ==="
git ls-files | grep "^\.env" | grep -v "\.env\.example" || echo "CLEAN — no .env files tracked"
```

**Pass if:** No hardcoded keys found in source files, `.env` is in `.gitignore`, and no `.env` files (other than `.env.example`) are tracked by git.

**Fail if:** Any hardcoded key patterns found, or `.env` files are tracked by git. This is a critical failure — API keys in git history remain accessible even after deletion and must be rotated immediately.

---

### Check M — Supabase Row Level Security

```bash
# Check for RLS in setup documentation or SQL files
echo "=== RLS in setup files ==="
grep -rl "row level security\|enable row level security\|alter table.*enable" . 2>/dev/null | grep -v "node_modules\|dist\|\.git" | head -5

# Check api/contact.ts comments for service_role key usage note
echo "=== Service role key usage ==="
grep -n "service.role\|service_role\|bypass\|RLS" api/contact.ts 2>/dev/null | head -5 || echo "Not mentioned in api/contact.ts"
```

**Pass if:** Evidence of RLS being enabled (SQL file, comment in api/contact.ts, or setup documentation).

**Fail if:** No evidence of RLS configuration. Without RLS, anyone who guesses your Supabase project URL and anon key can read all your leads. Note: the service_role key bypasses RLS intentionally on the server side — this is correct behavior — but RLS must be enabled so the anon key cannot be used to read data.

**Fix:** Run in Supabase SQL Editor: `alter table leads enable row level security;`

---

### Check N — Server-side input validation

```bash
# Check that the contact API validates inputs before processing
echo "=== Input validation in api/contact.ts ==="
grep -n "validate\|required\|trim\|typeof\|length\|includes\|@" api/contact.ts 2>/dev/null | head -10 || echo "No api/contact.ts found"
```

**Pass if:** The contact API function validates required fields, checks types, and rejects malformed submissions before writing to the database.

**Fail if:** No validation found — the function accepts and stores anything submitted.

---

### Check O — No credentials in built output

```bash
# Verify the compiled dist/ folder doesn't contain any exposed keys
echo "=== Scanning dist/ for exposed credentials ==="
grep -rl "SUPABASE_SERVICE_KEY\|re_[a-zA-Z0-9]\{20,\}\|eyJh[a-zA-Z0-9_-]\{30,\}" dist/ 2>/dev/null | head -5 || echo "CLEAN"
```

**Pass if:** No credential patterns found in the built output. Credentials in `dist/` would be served directly to any visitor who views page source.

**Fail if:** Any key patterns found. Investigate immediately — identify where in the source the credential is leaking into client-side code.

---

### Check P — Spam protection on contact form

```bash
# Check for honeypot field or rate limiting in contact form and API
echo "=== Spam protection ==="
grep -rl "honeypot\|bot-field\|_gotcha\|rateLimit\|rate.limit\|x-forwarded-for" src/ api/ 2>/dev/null | head -5 || echo "NOT FOUND"
```

**Pass if:** A honeypot field exists in the contact form, or rate limiting is implemented in the API.

**Fail if:** No spam protection found. Without it, automated bots can flood your leads table and inbox. A honeypot is a hidden field that humans leave blank but bots fill in — the API rejects any submission where it's filled. Takes about 10 minutes to add.

---

## Step 3 — Produce the audit report

After running all checks, interpret every result and produce a clean report in this format. Never show raw bash output — only interpreted findings.

**If there are issues to fix:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Pre-Launch Audit — [Firm Name]
  [today's date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

LEGAL DISCLAIMERS

  ✓  Footer disclaimer                all pages (via [layout file])
  ✗  Contact form disclaimer          not found
     → Add this above your form's submit button:
       "Submitting this form does not create an
       attorney-client relationship. Do not include
       confidential information until a relationship
       has been formally established."
  ✓  Blog post disclaimers            5 of 5 posts (via layout)
  ✗  Practice area disclaimers        1 page missing
     → Add disclaimer to the bottom of:
       src/pages/practice-areas/[name].astro

SEO METADATA

  ✓  Meta titles                      all pages
  ✗  Meta descriptions                1 page missing
     → src/pages/practice-areas/[name].astro
       has no meta description. Add one under 155 characters.

STRUCTURED DATA (JSON-LD)

  ✓  LegalService schema              homepage
  ✓  FAQPage schema                   all practice area pages
  ✗  Person schema                    missing on 1 page
     → src/pages/attorneys/[name].astro
       has no Person schema. Run /hc-firm-site:page attorney
       to regenerate, or add the schema block manually.
  ✓  Article schema                   blog (via layout)

IMAGES

  ✗  Images over 200 KB               2 files found
     → public/images/brian.jpg        412 KB
     → public/images/hero-bg.jpg      318 KB
     Compress at squoosh.app (free) — aim for under 150 KB each.

PAGES & CONTENT

  ✓  Practice area URLs               3 pages, 3 in brief — all covered
  ✓  Blog post author attribution     all 5 posts have an author

SECURITY

  ✗  HTTP security headers            not configured
     → Add a headers block to vercel.json (see check output for exact code)
  ✓  No secrets in source code
  ✓  .env files excluded from git
  ✓  Supabase RLS enabled
  ✓  Server-side input validation
  ✓  No credentials in built output
  ✗  Spam protection                  no honeypot found
     → Add a hidden honeypot field to the contact form

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  6 issues to fix before launch
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  1. Contact form — add pre-submission disclaimer
  2. Practice area page — add disclaimer to [name]
  3. Meta description — add to [name] practice area page
  4. Person schema — add to [name] attorney page
  5. Images — compress brian.jpg and hero-bg.jpg
  6. Security — HTTP headers not configured
  7. Security — no spam protection on contact form

  Fix these, then run /hc-firm-site:check again.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If everything passes:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Pre-Launch Audit — [Firm Name]
  [today's date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ✓  Footer disclaimer
  ✓  Contact form disclaimer
  ✓  Blog post disclaimers
  ✓  Practice area disclaimers
  ✓  Meta titles
  ✓  Meta descriptions
  ✓  LegalService schema (homepage)
  ✓  FAQPage schema (practice areas)
  ✓  Person schema (attorney pages)
  ✓  Article schema (blog)
  ✓  Images under 200 KB
  ✓  Practice area URLs
  ✓  Blog post author attribution
  ✓  HTTP security headers
  ✓  No secrets in source code or git
  ✓  Supabase Row Level Security
  ✓  Server-side input validation
  ✓  No credentials in built output
  ✓  Spam protection

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ All checks passed — ready to launch
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Next steps:
  • Run `npm run build` one final time to confirm no errors
  • Preview locally with `npm run preview`
  • Run /gsd:verify-work for a final overall code review
  • Deploy to Vercel when ready
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Report rules:
- Use ✓ for pass, ✗ for fail
- For each failure: name the exact file, quote the text that should be added if relevant, and give one clear action to fix it
- For image failures: list each oversized file with its size in KB and recommend squoosh.app (free, browser-based)
- If a folder doesn't exist at all (e.g., no `/practice-areas/` folder yet), note "no pages found" — don't treat it as a failure if the user simply hasn't built that section yet
- If the blog Article schema is handled by the layout file, that counts as a pass for every blog post — do not mark individual posts as failing
- Keep the tone matter-of-fact and helpful — these are fixable things, not catastrophes

</process>
