# Contributing to the HeyCounsel Skills Registry

Thank you for contributing to the HeyCounsel Skills Registry. Every skill you share strengthens the community of independent lawyers building with AI.

---

## Who Can Contribute

Anyone — HeyCounsel members, attorneys, legal operations professionals, law students, and legal technologists. You don't need to be a developer. If you can describe your workflow clearly, you can build a skill file.

---

## Two Ways to Contribute

### Option 1: GitHub Pull Request (Technical)

If you're comfortable with Git and GitHub:

1. **Fork** this repository.
2. **Create a skill directory** inside the `skills/` folder using kebab-case naming: `skills/ca-purchase-agreement-review/`, not `CA Purchase Agreement Review/`.
3. **Add your files** following this structure:

```
skills/
└── your-skill-name/
    ├── SKILL.md              # Required — core instructions
    ├── skill.yml             # Required — registry metadata (see template)
    ├── reference/            # Optional — checklists, statutes, examples
    └── templates/            # Optional — output format templates
```

A `skill.yml` template is available at [`skills/SKILL_TEMPLATE/skill.yml`](skills/SKILL_TEMPLATE/skill.yml). Copy it into your skill folder and fill in the fields. The GitHub Action uses this file to automatically add your skill to the registry table when your PR is merged.

4. **Submit a pull request** with a clear description including:
   - Practice area and jurisdiction (if applicable)
   - What workflow the skill automates
   - What platforms you've tested it on
   - Any limitations or known gaps
### Option 2: Submit Through HeyCounsel (Non-Technical)

Not comfortable with GitHub? No problem. The goal is to capture your expertise — we'll handle the technical details.

**Drop your new SKILL.md file in [the #vibecode_lab Slack channel](https://heycounsel.slack.com/archives/C0AFC9ASL2D) and tag Christian Brown and Victor Wang:**

1. Write your SKILL.md file (or even a rough draft of your workflow — bullet points are fine to start).
2. Upload it through the form, or email it directly through the HeyCounsel community platform.
3. Include a brief description of the practice area, jurisdiction, and what the skill does.
4. The HeyCounsel team will review, format if needed, and publish it to the registry on your behalf.

You'll be credited as the author, and you can iterate on the skill after publication. The point is to get your workflow into the registry — polish comes later.

---

## What Makes a Good Skill Contribution

**Specificity over breadth.** A skill that handles "California residential purchase agreement review" is more valuable than one that handles "contract review." Narrow, well-defined workflows produce better results.

**Real-world tested.** Before submitting, test your skill with actual documents from your practice (redacted as needed). Does the AI follow your methodology? Does it catch what you'd catch?

**Attorney-ready output.** The skill should produce draft work product that a licensed attorney can meaningfully review, revise, and approve — not raw data dumps.

**Clear four-part structure.** The best skills clearly define their Trigger (when to activate), Input (what's provided), Requirements (workflow logic and decision criteria), and Output (what gets delivered). See the [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md) for details.

---

## Required Files

### SKILL.md (Core Instructions)

Your `SKILL.md` must include:
- **YAML frontmatter** with `name` and `description` fields (see [Quick Start Guide](HeyCounsel-Quick-Start-Guide-Building-Skill-Files.md))
- **Workflow steps** — clear, sequential instructions
- **Decision logic** — how to handle variations and edge cases
- **Output format** — what the finished product should look like
- **Quality checks** — self-review criteria before delivering output

Your `description` field must include both what the skill does and when to use it (trigger phrases). This is how AI platforms decide when to activate your skill.

### skill.yml (Registry Metadata)

Every skill must include a `skill.yml` file with these fields: `name`, `practice_area`, `jurisdiction`, `version`, `author`, and `description`. When your PR is merged, a GitHub Action reads this file and automatically updates the Skills Registry table in the README. See the [template](skills/SKILL_TEMPLATE/skill.yml) for the exact format.

---

## Naming Conventions

- **Skill folder:** kebab-case (`tx-title-analysis`, `nda-triage`, `ca-entity-formation`)
- **SKILL.md:** Exactly `SKILL.md` — case-sensitive, no variations
- **Name field in frontmatter:** Must match the folder name

---

## Ethical and Professional Standards

All contributions must comply with these standards:

- **No confidential client information.** Redact or use hypothetical examples. Never include real client data, even in sample outputs.
- **Draft work product only.** All skill outputs must be clearly identified as drafts requiring attorney review. Include appropriate disclaimers.
- **No unauthorized practice of law.** Skills should assist licensed attorneys, not replace professional judgment.
- **Jurisdiction awareness.** Clearly identify the jurisdictions your skill covers. Do not present jurisdiction-specific guidance as universally applicable.
- **Attribution.** If your skill builds on another contributor's work, credit them.

---

## Understanding the MIT License
This repository uses the **MIT License** — one of the most permissive and widely used open-source licenses. Here's what that means in plain terms for anyone contributing or using skills from this registry:

### What the MIT License Allows

**Anyone can use, copy, modify, merge, publish, distribute, sublicense, or sell** copies of the skill files in this repository. This applies to individuals, firms, companies, and organizations of any size. There are no restrictions on commercial use — a solo practitioner, an Am Law 100 firm, and a legal tech startup all have the same rights.

### What the MIT License Requires

**One thing:** any copy or substantial portion of the work must include the original copyright notice and the license text. That's it. If you fork this repo, copy a skill into your own project, or redistribute a modified version, include the LICENSE file.

### What the MIT License Does NOT Do

- It does **not** require you to share your modifications back. If you customize a skill for your practice, you are not obligated to contribute those changes to this repository (though we encourage it).
- It does **not** require attribution beyond including the license text. You don't need to credit HeyCounsel in your work product.
- It does **not** include any warranty. The skills are provided "as is" — which aligns with the disclaimer that all AI-generated output is draft work product requiring attorney review.
- It does **not** prevent you from using skills in proprietary or commercial products.

### What This Means for Contributors

By contributing a skill to this repository, you agree to license your contribution under the MIT License. This means other attorneys, developers, and organizations can freely use, modify, and build on your work. That is the point — shared infrastructure for the legal community. If you have concerns about contributing work under these terms, feel free to reach out through [HeyCounsel](https://www.heycounsel.com) before submitting.

### What This Means for Users

You can use any skill from this registry in your practice, modify it for your needs, and incorporate it into paid services or products. The only obligation is to include the license text when you redistribute the files themselves.
---

## Questions?

If you're unsure whether your skill idea fits, open a GitHub Issue describing the workflow and we'll help you scope it. You can also reach out through [HeyCounsel](https://www.heycounsel.com).

We'd rather help you refine an imperfect contribution than never see it at all. Start somewhere and iterate.

---

*All contributions to this repository are for educational and professional development purposes. Contributors are responsible for ensuring their submissions do not contain confidential or privileged information.*
