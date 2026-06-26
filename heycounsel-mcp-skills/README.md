# HeyCounsel MCP Skills

A home for skills that turn the **HeyCounsel MCP server** into focused, repeatable
workflows for community members. Each skill packages a multi-step task — research,
analysis, drafting — so you can invoke it with a short request instead of
re-explaining the process every time.

## What's in here

Each subfolder is a self-contained skill: a `SKILL.md` (instructions + a
`description` that controls when it triggers) plus any bundled resources.

| Skill | What it does |
|-------|--------------|
| [`heycounsel-practice-coach/`](./heycounsel-practice-coach/SKILL.md) | A business coach for your practice. Researches your profile, **both** Pulse surveys, and the community Slack, then returns a prioritized, evidence-cited set of recommendations with working links. |

## Requirements

These skills assume:

- You're an **active HeyCounsel lawyer member**.
- The **HeyCounsel MCP server** is connected: `https://api.heycounsel.com/mcp`

They draw on the HeyCounsel MCP tools, including:

- `get_my_heycounsel_profile` — your professional profile, completion status, links
- `get_pulse_status` / `get_pulse_results` — Pulse benchmarking (firm + tech-stack surveys, with peer-group scoping)
- `search_slack_conversations` / `list_top_slack_threads` / `list_slack_channels` — the community Slack
- `find_a_lawyer` — the member directory

## Using a skill

A skill can be used a few ways:

1. **As a skill file** — drop the skill's folder into your Claude skills directory; it triggers automatically when a request matches its `description`.
2. **As Project instructions** — paste the body of `SKILL.md` into a Claude Project's custom instructions.
3. **By hand** — copy the body into a chat as a system/setup prompt.

In every case, members only need a short request (e.g., "coach me on my practice
for the next quarter") — the skill body carries the research protocol.

## Adding a skill

Conventions to keep this folder clean and reliable:

- **One folder per skill.** The folder name should match the `name` in the
  `SKILL.md` frontmatter.
- **Lead with a strong `description`.** It's the trigger. Say both what the skill
  does and *when* to use it, including casual phrasings members might actually type.
- **Keep `SKILL.md` focused** (ideally under ~500 lines); push long reference
  material into a `references/` subfolder and point to it.
- **Cite data sources.** Skills that read Pulse or Slack should require inline
  links and attribution, and should never fabricate statistics or quotes.
- **No secrets.** Never commit API keys, tokens, member PII, or anything that
  shouldn't be public.
- **Add a row** to the table above when you contribute a new skill.
