# HeyCounsel: Legal AI Skills Repository

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Multi-LLM](https://img.shields.io/badge/Platform-Multi--LLM-green.svg)](#platform-support)
[![Skills: Legal](https://img.shields.io/badge/Skills-Legal_AI-purple.svg)](#available-skills)

---

## What Is This?

HeyCounsel maintains a growing library of **AI skills files** — structured documents that transform general-purpose language models into specialized legal assistants by equipining the model with the actual knowledge it needs to get the task done. Each skill file encodes the workflow logic, decision frameworks, reference materials, and quality checks that experienced attorneys who are members of HeyCounsel use in their tech stack for different legal tasks every day.

Think of a skill file as a form of **Legal Ops for AI**. Instead of prompting from scratch each time, you load a skill file and the AI already knows how to handle title commitments, triage NDAs, draft discovery responses, or review contracts — following the same methodology you would use, not some generic template.

## How Skill Files Work

A skill file is a structured text document (typically `SKILL.md`) that lives in a simple directory. At its core, every skill file contains:

- **Workflow Logic** — Step-by-step procedures that mirror how experienced attorneys approach the work
- **Decision Trees** — Conditional logic for handling exceptions, edge cases, and jurisdictional variations
- **Reference Materials** — Checklists, statutory references, form templates, and institutional knowledge
- **Output Templates** — Standardized formats for deliverables (opinion letters, checklists, memos)
- **Quality Review Criteria** — Built-in verification steps so the AI checks its own work

```
my-legal-skill/
├── SKILL.md              # Main skill file with instructions & logic
├── reference/            # Supporting materials
│   ├── checklist.md      # Checklists, forms, templates
│   ├── statutes.md       # Relevant statutory references
│   └── examples/         # Sample inputs and outputs
└── templates/            # Output format templates
```
## Available Skills

### TX Title Analysis
**Status:** Production-ready | **Jurisdiction:** Texas

Performs residential and commercial title examination — analyzes commitments, recorded instruments, surveys, HOA documents, and searches. Outputs draft title opinion letters, requirements checklists, and exception cure guidance for attorney review.

- Schedule B exception analysis with cure recommendations
- Homestead, community property, and mineral rights evaluation
- T-1, T-7, T-19 form guidance and lender endorsements
- Automated requirements checklist generation

### More Skills Coming Soon
We are actively developing skill files for additional practice areas. Check back for updates or contribute your own.

## Platform Support

Skill files are **platform-agnostic** — they work with any LLM that accepts system-level instructions:

| Platform | Status | Notes |
|----------|--------|-------|
| **Claude** (Cowork & Code) | ✅ Full Support | Native SKILL.md support with frontmatter |
| **ChatGPT / OpenAI** | ✅ Compatible | Load as system instructions or custom GPT |
| **Google Gemini** | ✅ Compatible | Use as context or system prompt |
| **Other LLMs** | ✅ Compatible | Any model accepting structured instructions |

## Getting Started
### Quick Start (Claude Cowork or Claude Code)

1. **Clone this repo** into your project or skills directory:
   ```bash
   git clone https://github.com/HeyCounsel/legal-ai-skills.git
   ```
2. **Copy a skill folder** to your Claude skills location:
   - Enterprise: Managed by your organization
   - Personal: `~/.claude/skills/`
   - Project: `.claude/skills/` in your project root
3. **Use the skill** — Claude will automatically detect and apply it when relevant, or you can invoke it directly.

### Quick Start (Other Platforms)

1. **Download the SKILL.md** file for the skill you want
2. **Paste the contents** into your platform's system prompt, custom instructions, or context window
3. **Upload supporting files** (reference materials, templates) as needed
4. **Start working** — the AI will follow the skill's workflow

## Who Is This For?

- **Solo practitioners** looking to leverage AI without building prompts from scratch
- **Legal teams** wanting consistent, repeatable AI-assisted workflows
- **Legal operations** professionals building scalable AI tooling
- **Law firms** exploring AI augmentation for associate-level tasks
- **Legal tech developers** building AI-powered products

## Key Advantages

- **Expert Knowledge, Encoded** — Captures institutional knowledge that would take years to develop
- **Consistent Quality** — Every analysis follows the same rigorous methodology- **Platform Flexible** — Not locked into any single AI vendor or tool
- **Transparent Logic** — All reasoning steps are visible and auditable in plain text
- **Community Driven** — Open source means continuous improvement from practitioners

## Hackathon: Build Your Own Legal AI Skill

HeyCounsel is hosting a hands-on hackathon where legal professionals and technologists collaborate to **build custom skill files** for real practice areas. Whether you're an attorney who wants AI to handle your specific workflow or a developer who wants to encode legal expertise, this is your chance to create something immediately useful.

📅 **When:** TBD (Early–Mid April 2025)  

- [Claude Skills Documentation](https://code.claude.com/docs/en/skills)
- [HeyCounsel Website](https://www.heycounsel.com)

## Evals: Test and Improve Your Skills

Claude's Skill Creator now includes a built-in **evaluation system** with four modes:

1. **Create** — Generate a new skill from a description
2. **Eval** — Run test cases against your skill to measure quality
3. **Improve** — Automatically refine your skill based on eval results
4. **Benchmark** — Compare skill versions with statistical analysis

The eval pipeline uses specialized sub-agents (executor, grader, comparator, analyzer) to provide a tight feedback loop: write your skill → run evals → inspect results → refine → repeat. This means you can iterate on a legal skill file with objective measurements rather than guesswork.

## Contributing

If you are a HeyCounsell member, to contribute a skill:

1. Fork this repository
2. Create a new skill directory following the structure above
3. Include a SKILL.md with clear workflow logic, decision criteria, and quality checks4. Add supporting reference materials and templates
5. Submit a pull request with a description of the practice area and use case

## Disclaimer

These skill files are **tools for legal professionals**, not substitutes for legal judgment. All AI-generated output should be reviewed by a licensed attorney before use. Skill files encode general workflows and may not account for every jurisdictional variation or factual nuance. HeyCounsel provides these resources for educational and professional development purposes.

---

**Built by [HeyCounsel](https://www.heycounsel.com)** — AI-powered legal workflows for solo and small firm modern practice.