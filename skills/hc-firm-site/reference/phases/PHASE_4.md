# Phase 4 Playbook — Polish + Launch

**Goal:** The site is accessible (WCAG 2.1 AA), fast, secure, and bar-compliant —
verified by the full audit — and live on the firm's real domain.

**Read before building:**
- `.planning/LAW_FIRM_WEBSITE_GUIDE.md` — Part 5 (disclaimers) and the accessibility standards section
- `.planning/FIRM_BRIEF.md` — Security & Compliance Requirements (this phase closes every item)
- `$HOME/.claude/commands/hc-firm-site/check.md` — the audit this phase must pass
- `$HOME/.claude/skills/seo-aeo-best-practices/references/technical-seo.md` (if
  installed) — cross-check its checklist during step 6; it covers current technical
  details the static audit may not (canonical URLs, redirect hygiene, crawlability)

---

## Phase decisions (ask up front)

1. **Custom domain.** Do they own a domain (e.g. smithlaw.com)? If yes, we connect
   it at the end of this phase. If no, ask if they want one — recommend buying
   through Vercel (simplest: zero DNS configuration) or their registrar of choice;
   the .vercel.app URL also works fine until they decide.
2. **Privacy policy.** The contact form collects personal data, so the site needs a
   privacy policy page. Offer to draft a standard one for their review — they're
   the lawyer; they approve the final text.

---

## Build steps

### 1. Accessibility pass (WCAG 2.1 AA)

Accessibility is built into the code — never an overlay widget (they create legal
exposure rather than reducing it). Verify and fix:

- **Keyboard:** every interactive element reachable and usable with Tab/Enter/Escape.
  The contact modal must trap focus while open and close on Escape.
- **Focus visibility:** a clear `:focus-visible` outline on all interactive elements.
- **Skip link:** the skip-to-content link from Phase 1 still works.
- **Contrast:** all text meets 4.5:1 against its background (3:1 for large text).
  Check the design system tokens, especially muted/secondary text colors.
- **Alt text:** every image — verify nothing slipped through Phase 2.
- **Semantics:** one `<h1>` per page, logical heading order, `<nav>`/`<main>`/`<footer>`
  landmarks, form inputs with real `<label>`s.
- **Reduced motion:** any animation respects `prefers-reduced-motion`.

### 2. Performance pass

Target: every page interactive in under 2.5 seconds.

- Astro ships zero JS by default — verify nothing added unnecessary client-side JS.
- Fonts: `preconnect` to the font host, `display=swap`, only the weights actually used.
- Images: all under 200 KB, width/height attributes set (prevents layout shift),
  `loading="lazy"` below the fold.
- Run a Lighthouse or PageSpeed check (https://pagespeed.web.dev with their live
  URL) and share the scores with the attorney. Target 90+ on performance,
  accessibility, SEO.

### 3. Security headers

Create or update `vercel.json` with headers served on every response:

- `Strict-Transport-Security` — forces HTTPS
- `Content-Security-Policy` — restricts where scripts/styles/frames can load from
  (build the policy from what the site actually uses: Google Fonts, the form
  provider, Calendly if present)
- `X-Frame-Options: DENY`, `X-Content-Type-Options: nosniff`,
  `Referrer-Policy: strict-origin-when-cross-origin`, `Permissions-Policy`
  (disable camera/mic/geolocation)

After deploy, verify at https://securityheaders.com — target grade A. Show the
attorney the result; it's a satisfying proof point.

### 4. Secrets sweep

- Grep the source for any hardcoded keys (`sk-`, `key=`, provider key patterns)
- Confirm `.env*` files are gitignored and untracked
- Build the site and grep `dist/` for the same patterns — the compiled output is
  what the public can actually see
- If a database is used (Supabase path): confirm Row Level Security is enabled on
  every table

### 5. Bar compliance review

Walk the attorney through each item and confirm together:

- "Attorney Advertising" in the footer of every page (required in NY and several
  other states — confirm their state's exact requirement, guide Part 5)
- General disclaimer in footer; blog disclaimer on every post; practice area
  disclaimer on every practice page; attorney-client disclaimer on the form
- No outcome guarantees anywhere in the copy ("we win," "guaranteed results");
  no "expert/specialist" claims unless their state certification allows it
- Every blog post attributed to a named attorney
- Privacy policy page is live and linked in the footer
- Bar admission jurisdictions accurate on every attorney profile

This is THEIR review — Claude prepares the checklist and the evidence; the attorney
confirms each item as the responsible lawyer.

### 6. Run the full audit

Run every check in `/hc-firm-site:check` (read
`$HOME/.claude/commands/hc-firm-site/check.md` and execute all of it). Every check
must pass. Fix anything that fails and re-run until clean. Show the attorney the
final all-green report.

### 7. Custom domain (if they have one)

Walk them through Vercel → Project → Settings → Domains → Add. Two paths:
- **Bought through Vercel:** automatic, nothing to configure.
- **Existing registrar:** Vercel shows the exact DNS records to add (an A record
  and/or CNAME). Explain DNS simply: "the phone book of the internet — we're adding
  an entry that says your domain points to your Vercel site." Records can take
  minutes to a few hours to propagate; HTTPS certificate is automatic once it does.

Verify https://www and the bare domain both load the site.

### 8. Launch

Final ship ritual. Update PROGRESS.md to all-complete. Hand back to build.md's
launch message.

---

## Success criteria (all must be TRUE before approval)

1. Keyboard-only walkthrough of the whole site works, including the contact modal
2. PageSpeed/Lighthouse: 90+ performance and accessibility on the live site
3. securityheaders.com grade A (or the attorney has seen and accepted any exception)
4. No secrets in source, git history, or `dist/` output
5. The attorney personally confirmed every bar-compliance checklist item
6. The full /hc-firm-site:check audit passes — all checks green
7. Privacy policy live and linked in the footer
8. If a custom domain was connected: it loads with HTTPS on www and bare domain
