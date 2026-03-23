# HeyCounsel Skills Registry

**Open-source legal AI skills — built by attorneys, for attorneys.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Multi-LLM](https://img.shields.io/badge/Platform-Multi--LLM-green.svg)](#platform-compatibility)
[![Community: HeyCounsel](https://img.shields.io/badge/Community-HeyCounsel-purple.svg)](https://www.heycounsel.com)

---

## The Idea

HeyCounsel was founded on a simple belief: independent lawyers shouldn't have to go it alone. The platform gives solo practitioners, fractional GCs, and boutique firms the collective power of a large firm — shared knowledge, peer support, and the tools to compete at any level.

This repository extends that same philosophy into AI. Every attorney has workflows they've refined over years of practice — how they review title commitments, triage NDAs, structure discovery responses, or onboard new clients. That hard-won expertise usually lives in someone's head or scattered across templates and checklists. A **skill file** captures it in a portable, reusable format that any AI assistant can follow.

The HeyCounsel Skills Registry is a growing collection of these skill files, contributed by practicing attorneys and legal professionals. Use them as-is, customize them for your practice, or build your own from scratch and share it back.

No coding required. If you can write a standard operating procedure, you can build a skill file.

---

## What Is a Skill File?

A skill file is a structured text document — written in plain Markdown — that encodes a legal standard operating procedure so that an AI model can execute it. Step-by-step workflows, decision logic for edge cases, reference materials, output templates, and quality checks all bundled into a single portable format.

Instead of re-prompting an AI from scratch every time you sit down to work, you load a skill file once and the model already knows your methodology.
```
my-legal-skill/
├── SKILL.md              # Core instructions — the SOP (required)
├── reference/            # Checklists, statutes, institutional knowledge
│   ├── checklist.md
│   └── examples/
└── templates/            # Output format templates
    └── opinion-letter.md
```

Every skill file contains:

- **Workflow Logic** — Step-by-step procedures mirroring how an experienced attorney approaches the work
- **Decision Trees** — Conditional logic for exceptions, edge cases, and jurisdictional variations
- **Reference Materials** — Checklists, statutory citations, form templates, and institutional knowledge
- **Output Templates** — Standardized formats for deliverables (opinion letters, memos, checklists)
- **Quality Checks** — Built-in verification steps so the AI reviews its own work before you do

---

## The Structure Legal Work Already Has

Every legal workflow follows a natural four-part structure — and it always has. Every contract clause, every regulatory provision, every compliance workflow, and every AI pipeline stage follows this pattern:

| Component | What It Means | Legal Example |
|-----------|--------------|---------------|
| **Trigger** | What activates this process? | "Client uploads an NDA for review" or "New title commitment received" |
| **Input** | What information flows in? | The NDA document, counterparty name, deal context |
| **Requirements** | What rules, logic, and standards apply? | Firm standard positions, jurisdiction-specific rules, risk classification criteria |
| **Output** | What gets delivered? | A risk-classified review memo with recommended positions |

When you write a skill file, you're mapping directly to this structure. The Trigger becomes your skill's `description` field — when should the AI activate this workflow? The Input section defines what the attorney provides. The Requirements section is the heart of the skill — your workflow steps, decision logic, and quality checks. The Output section defines what the finished work product looks like.

This isn't a new way of thinking about legal work. It's a precise way of describing what experienced attorneys already do instinctively. A skill file just makes it explicit and portable.

---

## Why This Matters for Legal Practice

Most attorneys already have AI access. The gap isn't the technology — it's the methodology. General-purpose AI doesn't know your firm's standard operating procedures, your jurisdiction's quirks, or the difference between a standard Schedule B exception and one that needs immediate attention.

Skill files close that gap. They encode the kind of institutional knowledge that takes years to develop and make it instantly available to any AI platform you use. For solo and small firm attorneys — the lawyers HeyCounsel serves — this is a force multiplier. You get the consistency and depth of a large firm's knowledge management system without the overhead.

**For the attorney who builds a skill:** You think through your own process with new clarity. Writing a skill file forces you to articulate the decision logic you've internalized over years of practice. That exercise alone has value, even before an AI ever reads it.

**For the attorney who uses a skill:** You get a head start. Instead of prompting from scratch, you're building on a colleague's tested workflow. Customize it, improve it, make it your own.

**For the community:** Every skill contributed makes the registry more valuable. This is how independent lawyers build shared infrastructure — the same way HeyCounsel members already share templates, referrals, and expertise.

---

## Skills Registry

### Available Skills

<!-- SKILLS_REGISTRY_START -->
| Skill | Practice Area | Jurisdiction | Version |
|-------|--------------|-------------|---------|
| [Matter Journal](skills/matter-journal/) | Practice Management | Multi | v1.0 |
| [Redline Emailer](skills/redline-emailer/) | Contracts | Multi | v1.0 |
| [TX Title Analysis](skills/tx-title-analysis/) | Real Estate | Texas | v2.1 |

**Matter Journal** — Manages client matter journals — persistent case files that give AI full context on every client and matter. Creates, loads, and logs to per-matter markdown journals for seamless context across sessions.

**Redline Emailer** — Translates contract redlines into client-ready or opposing-counsel emails. Accepts tracked-changes .docx, redlined PDFs, or verbal descriptions of changes and produces tone-matched, copy-paste-ready cover emails.

**TX Title Analysis** — Residential and commercial title examination — analyzes commitments, recorded instruments, surveys, HOA documents, and searches. Outputs draft title opinion letters, requirements checklists, and exception cure guidance for attorney review.

<!-- SKILLS_REGISTRY_END -->

### Wanted: Your Practice Area

We are actively seeking skill file contributions across all practice areas. If you have a repeatable workflow — contract review, discovery management, regulatory compliance, entity formation, immigration checklists, IP prosecution — it belongs here. See the [Contributing Guide](CONTRIBUTING.md) or the [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md) to get started.

---

## Getting Started

### Use an Existing Skill

**Claude (Cowork or Claude Code):**

1. Clone this repo:
   ```bash
   git clone https://github.com/HeyCounsel/legal-ai-skills.git
   ```
2. Copy the skill folder you want to your Claude skills directory:
   - Personal: `~/.claude/skills/`
   - Project: `.claude/skills/` in your project root
3. Claude will automatically detect and apply the skill when relevant.

**ChatGPT, Gemini, or Other Platforms:**

1. Download the `SKILL.md` file from the skill you want.
2. Paste its contents into your platform's system prompt or custom instructions.
3. Upload any supporting reference files as needed.
4. Start working — the AI will follow the skill's methodology.

### Build Your Own Skill

The fastest path from idea to working skill:

1. **Pick one workflow** you do repeatedly — the more specific, the better.
2. **Map your workflow** — What triggers this work? What comes in? What rules and logic apply? What gets delivered?
3. **Write it out** as a `SKILL.md` file using the [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md).
4. **Test it** with a real document or matter.
5. **Share it** by submitting a pull request to this repository.

For a deeper dive, see our [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md) or Anthropic's [Complete Guide to Building Skills](References/The-Complete-Guide-to-Building-Skill-for-Claude%20(1).pdf) included in this repository.

---

## Platform Compatibility

Skill files are **platform-agnostic**. They work with any AI that accepts structured instructions:

| Platform | How to Use |
|----------|-----------|
| **Claude** (Cowork & Code) | Native `SKILL.md` support — drop into skills directory |
| **ChatGPT / OpenAI** | Paste as system instructions or build a custom GPT |
| **Google Gemini** | Use as context or system prompt |
| **Any LLM** | Load into the system prompt or context window |

You are not locked into any single vendor. Build a skill once, use it everywhere.

---

## The HeyCounsel Hackathon

HeyCounsel is building toward a hands-on hackathon where legal professionals and technologists collaborate to create skill files for real practice areas. Whether you're an attorney who wants AI to follow your specific workflow or a developer who wants to encode legal expertise, this is an opportunity to build something immediately useful — and contribute it to a community that will put it to work.

The hackathon reflects a core HeyCounsel principle: independent lawyers are stronger together. Instead of everyone solving the same problems in isolation, we build shared tools and lift the whole community.

Stay connected through [HeyCounsel](https://www.heycounsel.com) for hackathon details as they develop.

---

## Testing and Improving Your Skills

Claude's built-in **Skill Creator** provides an evaluation system for iterating on your skills with real feedback:

1. **Create** — Generate a skill file from a natural language description of your workflow.
2. **Eval** — Run test cases against your skill to measure output quality.
3. **Improve** — Refine the skill automatically based on evaluation results.
4. **Benchmark** — Compare versions side-by-side with statistical analysis.

The feedback loop is simple: write your skill → run evals → review results → refine → repeat. This is especially valuable for legal skills where precision matters — you can objectively test whether your contract review skill catches the issues your SOP requires, or whether your NDA triage correctly classifies risk levels.

---

## Contributing

This registry grows through contributions from practicing attorneys and legal professionals. Every skill you share makes the community stronger.

### Option 1: Submit via GitHub (Technical)

1. Fork this repository.
2. Create a new skill directory following the standard structure (see [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md)).
3. Include a `SKILL.md` with clear workflow logic, decision criteria, and quality checks.
4. Add supporting reference materials and templates as needed.
5. Submit a pull request describing the practice area, jurisdiction, and use case.

See the full [Contributing Guide](CONTRIBUTING.md) for detailed submission standards.

### Option 2: Submit via Form (Non-Technical)

Not comfortable with GitHub? No problem. Use the **[HeyCounsel Skill Submission Form](https://www.heycounsel.com)** to contribute without touching any code. Describe your workflow, upload your SKILL.md (or even a rough draft), and the HeyCounsel team will handle the formatting, review, and publication to the registry on your behalf.

You can also email your skill file or workflow description directly to the HeyCounsel team through the community platform. The goal is to capture your expertise — we'll take care of the technical details.

---

## Who This Is For

- **Solo practitioners and small firms** — Leverage AI with your methodology, not a generic template. Get large-firm consistency without large-firm overhead.
- **Fractional and in-house counsel** — Standardize the workflows you bring to every client engagement. Build once, reuse across matters.
- **Legal operations professionals** — Create scalable, auditable AI tooling for your organization.
- **Law students and new attorneys** — Learn from experienced practitioners' workflows while building practical AI skills.
- **Legal technologists** — Encode domain expertise into portable, platform-agnostic instruction sets.

---

## Disclaimer

Skill files are **tools for legal professionals**, not substitutes for legal judgment. All AI-generated output is draft work product intended for review, revision, and approval by a licensed attorney. Skill files encode general workflows and may not account for every jurisdictional variation or factual nuance. HeyCounsel provides these resources for educational and professional development purposes only. Nothing in this repository constitutes legal advice.

---

## Resources

- [HeyCounsel](https://www.heycounsel.com) — Big firm power for small firm lawyers
- [Quick Start Guide: Building Skill Files](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md) — Step-by-step guide in this repo
- [The Complete Guide to Building Skills for Claude](References/The-Complete-Guide-to-Building-Skill-for-Claude%20(1).pdf) — Anthropic's comprehensive reference
- [Claude Skills Documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/skills) — Official technical reference
- [Anthropic Skills Examples](https://github.com/anthropics/skills) — Public skills repository from Anthropic

---

**Built by the [HeyCounsel](https://www.heycounsel.com) community** — independent lawyers building shared tools for modern practice.

*Curated by Code & Counsel, PLLC*