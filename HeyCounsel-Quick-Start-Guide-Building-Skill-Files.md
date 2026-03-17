# Quick Start Guide: Building Your First Legal AI Skill File

**A HeyCounsel Guide for Legal Professionals**

---

## What Is a Skill File?

A skill file is a structured document that teaches an AI model how to perform a specific task — a legal standard operating procedure written so that both a human and an AI can follow it. Instead of writing a new prompt every time, you create a skill file once and reuse it across every matter.

For legal work, a skill file might encode how you analyze a title commitment, triage an NDA, draft discovery responses, or review a contract against your firm's standard positions.

**One skill file. Consistent results. Every time.**

---

## The 5-Minute Version

If you just want to get something working fast:

1. Create a folder: `my-skill/`
2. Create a file inside it: `SKILL.md`
3. Write your instructions in plain Markdown
4. Place the folder in your Claude skills directory (or paste into any LLM's system prompt)
5. Start using it

That's it. Everything below makes your skill file *better*, but the above is all you need to start.

---

## Before You Write Anything: Think Through Your Process
This is the most valuable step, and it has nothing to do with technology. Before you open a text editor, sit with these questions:

**Pick one workflow.** Not "contract review" broadly — something specific. "Reviewing vendor SaaS agreements against our standard positions." "Triaging incoming NDAs by risk level." "Analyzing Texas title commitments for residential closings."

**Walk through it mentally.** If you were handing this task to a sharp new associate on their first day, what would you tell them?

- What do they look at first?
- What are the decision points? ("If X, do this. If Y, do that.")
- What are the red flags that change everything?
- What does a good finished product look like?
- What are the common mistakes?

**Write it down in plain language.** No special formatting yet. Just write it the way you'd explain it over coffee. That narrative *is* your skill file — everything else is just structure.

This exercise has value on its own. Many attorneys who go through it discover blind spots in their own process or find steps they'd been doing on autopilot that they can now delegate with confidence.

---

## TIRO: The Structure Your Workflow Already Has

You don't need to learn a new framework. TIRO simply names what legal work has always looked like:

| Component | What It Means | Your Skill File |
|-----------|--------------|-----------------|
| **Trigger** | What activates this process? | Your `description` field — when should the AI start this workflow? |
| **Input** | What information flows in? | What the attorney provides: documents, context, parameters |
| **Requirements** | What rules, logic, and standards apply? | The heart of your skill: workflow steps, decision logic, quality checks |
| **Output** | What gets delivered? | The finished work product: memo, checklist, opinion letter, classification |
Every contract clause follows this pattern. Every regulatory provision. Every compliance workflow. TIRO isn't a framework imposed on legal operations — it's a formal description of the structure legal operations already have and always have had. When you write a skill file, you're writing a TIRO specification for your workflow.

---

## Skill File Structure

A skill file lives in a simple directory:

```
contract-review/
├── SKILL.md                 # Your main instructions (required)
├── reference/               # Supporting materials (optional)
│   ├── standard-positions.md # Your firm's negotiation positions
│   └── red-flags.md         # Common issues to watch for
└── templates/               # Output formats (optional)
    └── review-memo.md       # How the output should look
```

The only required file is `SKILL.md`. Everything else is optional but makes your skill more powerful.

---

## Writing Your SKILL.md

### Frontmatter (Optional but Recommended)

The frontmatter is a short header that tells AI platforms when to activate your skill — this is your **Trigger**:

```yaml
---
name: contract-review
description: Reviews vendor SaaS contracts against firm standard positions. Use when user uploads a vendor agreement, asks for "contract review", or mentions SaaS terms.
allowed-tools:
  - Read
  - Write
  - Bash
---
```
| Field | What It Does |
|-------|-------------|
| `name` | Display name for the skill (use kebab-case: `nda-triage`, not `NDA Triage`) |
| `description` | The **Trigger** — when and how the skill gets activated. Include specific phrases users might say |
| `allowed-tools` | Which tools the skill can use |

### The Six Sections of an Effective Skill

Map these to TIRO and you'll see the structure is natural:

**1. Role and Context** — Who is the AI acting as? What's the scope?

> You are an experienced commercial attorney reviewing vendor SaaS agreements. You analyze contracts against the firm's standard positions and flag deviations for attorney review.

**2. Input — What the AI Receives** *(TIRO: Input)*

> The user will provide a vendor SaaS agreement (PDF or text), and optionally the firm's standard positions document.

**3. Workflow Steps** *(TIRO: Requirements)*

> Step 1: Identify the agreement type and parties.
> Step 2: Extract key commercial terms (pricing, term, renewal, termination).
> Step 3: Compare each material provision against the firm's standard positions.
> Step 4: Flag deviations as Accept / Negotiate / Reject with reasoning.
> Step 5: Generate a review memo with a summary and detailed findings.

**4. Decision Logic** *(TIRO: Requirements)*

> If indemnification is uncapped: classify as Reject, note standard position is mutual cap at 12 months fees.
> If governing law is not [preferred jurisdiction]: classify as Negotiate, note preference.
> If auto-renewal with no termination for convenience: classify as Reject.
**5. Output Format** *(TIRO: Output)*

> Produce a review memo with: (1) deal summary, (2) key terms table, (3) deviation analysis with Accept/Negotiate/Reject classifications, (4) recommended redline positions, (5) open items requiring partner review.

**6. Quality Checks** *(TIRO: Requirements — verification layer)*

> Before finalizing, verify: all material provisions are addressed, every deviation has a specific recommendation, the summary accurately reflects the detailed findings, and no provisions were skipped.

---

## A Complete Example: NDA Triage

Here's a condensed but functional skill file you could use today. Notice how TIRO maps naturally:

```markdown
---
name: nda-triage
description: Screens incoming NDAs and classifies risk level. Use when user uploads an NDA, mentions "NDA review", or asks to "triage" a confidentiality agreement.
---

# NDA Triage Skill

## Role
You are an experienced commercial attorney triaging incoming NDAs for a startup legal team.

## Classification Framework
- **GREEN** (Approve): Mutual NDA, standard terms, 2-year term, standard carve-outs present → Recommend approval
- **YELLOW** (Flag for Review): One-way NDA, broad CI definition, non-standard jurisdiction, or missing carve-outs → Flag specific concerns
- **RED** (Escalate): No carve-outs, perpetual term, injunctive relief clause, non-compete or non-solicit provisions, IP assignment language → Escalate immediately
## Workflow
1. Identify NDA type (mutual vs. one-way)
2. Check definition of Confidential Information (broad vs. narrow)
3. Verify standard carve-outs exist (public info, independent development, prior knowledge, compelled disclosure)
4. Review term and survival period
5. Check governing law and dispute resolution
6. Look for non-standard provisions (non-compete, non-solicit, IP assignment)
7. Classify as GREEN / YELLOW / RED with reasoning for each material provision

## Output
Provide: risk classification color, key terms summary table, specific flags identified with clause references, and recommended next action (approve / review with notes / escalate to partner).

## Quality Check
Before delivering: confirm every section of the NDA was reviewed, verify the classification matches the most serious flag found, and ensure the recommendation is actionable.
```

**TIRO breakdown of this skill:**
| Component | Where It Lives |
|-----------|---------------|
| **Trigger** | `description:` field — "Screens incoming NDAs..." |
| **Input** | Implied — user uploads an NDA document |
| **Requirements** | Classification Framework + Workflow steps + Quality Check |
| **Output** | Output section — risk color, summary table, flags, next action |

---

## Where to Put Your Skill

| Location | Path | Who Can Use It |
|----------|------|---------------|
| Personal | `~/.claude/skills/` | Just you, across all projects |
| Project | `.claude/skills/` in your project root | Anyone working in that project |
| Enterprise | Managed by your org admin | Your whole organization |
| Other LLMs | System prompt / custom instructions | Copy-paste SKILL.md contents |
---

## Testing Your Skill

The best test is a real document. Load your skill, hand the AI something from your files, and see if the output matches what you'd produce yourself.

**Quick validation checklist:**

- [ ] Does the AI follow your workflow steps in order?
- [ ] Does it catch the issues you'd catch?
- [ ] Does the output format match what you specified?
- [ ] Does it handle an edge case correctly?
- [ ] Would you be comfortable using this as a first draft?

**Using Claude's Skill Creator for iteration:**

Claude includes a built-in Skill Creator tool that can help you generate, evaluate, and refine skill files. Use it by saying: *"Help me build a skill using skill-creator."* It supports four modes — Create, Eval, Improve, and Benchmark — giving you an objective feedback loop instead of guesswork.

---

## Making Your Skill Better Over Time

A skill file is a living document. After using it on a few matters, you'll notice patterns:

- **Gaps:** The AI missed something you always check for → Add it to the workflow steps.
- **Wrong emphasis:** The AI spent time on minor issues and skimmed major ones → Reorder your steps or add priority guidance.
- **Edge cases:** A specific fact pattern broke the logic → Add a decision branch.
- **Output issues:** The deliverable format wasn't quite right → Refine the output template.

Each refinement makes the skill more reliable. This is exactly how institutional knowledge gets built — one iteration at a time.
---

## Tips From Attorneys Who've Done This

**Start small.** Your first skill file doesn't need to cover every scenario. Pick the 80% case and get that right. You can always add complexity later.

**Be specific, not comprehensive.** "Review Texas residential title commitments" is better than "Review title commitments." Jurisdiction and context matter enormously in legal work — let them matter in your skill files too.

**Write for the literal-minded associate.** AI follows instructions precisely. If you'd normally say "use good judgment here," you need to spell out what good judgment looks like in that specific context.

**Include what good looks like.** A sample output in your reference materials gives the AI a concrete target. Show, don't just tell.

**Test with adversarial documents.** Don't just test with clean, standard agreements. Throw your skill a messy document and see where it breaks. That's where the real improvements come from.

---

## Platform Compatibility

Skill files work with any AI platform that accepts structured instructions:

- **Claude (Cowork & Code)** — Native support. Drop the skill folder into your skills directory.
- **ChatGPT / OpenAI** — Paste SKILL.md contents as system instructions or build a custom GPT.
- **Google Gemini** — Use as context or system prompt.
- **Any LLM** — If it takes a system prompt, it can use a skill file.

---

## Contributing Your Skill

### If You're Comfortable with GitHub

Fork the [HeyCounsel Skills Registry](https://github.com/HeyCounsel/legal-ai-skills), add your skill directory, and submit a pull request. See the [Contributing Guide](CONTRIBUTING.md) for detailed standards.
### If You're Not

No problem — the goal is to capture your expertise, not test your Git skills. Use the **[HeyCounsel Skill Submission Form](https://www.heycounsel.com)** to upload your SKILL.md or even a rough workflow description. You can also email it directly through the HeyCounsel community platform. The team will handle formatting and publication.

---

## Next Steps

1. **Use an existing skill** from the [HeyCounsel Skills Registry](https://github.com/HeyCounsel/legal-ai-skills) to see how it works in practice.
2. **Pick one workflow** from your own practice.
3. **Map it to TIRO** — What's the trigger? What comes in? What are the requirements? What goes out?
4. **Write your SKILL.md** following the structure in this guide.
5. **Test it** with a real document.
6. **Share it** — contribute back to the registry and help build the community.

---

## Resources

- [HeyCounsel Skills Registry](https://github.com/HeyCounsel/legal-ai-skills) — The community skill library
- [HeyCounsel](https://www.heycounsel.com) — Big firm power for small firm lawyers
- [The Complete Guide to Building Skills for Claude](../References/The-Complete-Guide-to-Building-Skill-for-Claude%20(1).pdf) — Anthropic's comprehensive reference
- [Claude Skills Documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/skills) — Official technical reference

---

*This guide is provided by HeyCounsel for educational and professional development purposes. All AI-generated legal work product should be reviewed by a licensed attorney before use.*