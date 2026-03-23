#!/usr/bin/env python3
"""
Scans skills/*/skill.yml for metadata and rebuilds the Skills Registry
table in README.md between marker comments.
"""

import os
import re
import yaml

SKILLS_DIR = "skills"
README_PATH = "README.md"

START_MARKER = "<!-- SKILLS_REGISTRY_START -->"
END_MARKER = "<!-- SKILLS_REGISTRY_END -->"


def load_skills():
    """Load all skill.yml files from the skills directory."""
    skills = []
    if not os.path.isdir(SKILLS_DIR):
        return skills

    for entry in sorted(os.listdir(SKILLS_DIR)):
        skill_dir = os.path.join(SKILLS_DIR, entry)
        yml_path = os.path.join(skill_dir, "skill.yml")
        skill_md = os.path.join(skill_dir, "SKILL.md")
        if not os.path.isdir(skill_dir):
            continue
        if entry.startswith("SKILL_TEMPLATE") or entry.startswith("."):
            continue
        if not os.path.isfile(skill_md):
            continue

        # Load metadata from skill.yml if it exists
        meta = {}
        if os.path.isfile(yml_path):
            with open(yml_path, "r") as f:
                meta = yaml.safe_load(f) or {}

        # Build skill record with defaults
        skill = {
            "folder": entry,
            "name": meta.get("name", entry.replace("-", " ").title()),
            "practice_area": meta.get("practice_area", "General"),
            "jurisdiction": meta.get("jurisdiction", "Multi"),
            "version": meta.get("version", "1.0"),
            "description": meta.get("description", "").strip(),
        }
        skills.append(skill)

    return skills


def build_table(skills):
    """Build the Markdown table and description blocks."""
    if not skills:
        return "_No skills registered yet. Be the first to contribute!_"

    lines = []
    lines.append("| Skill | Practice Area | Jurisdiction | Version |")
    lines.append("|-------|--------------|-------------|---------|")

    for s in skills:
        link = f"[{s['name']}](skills/{s['folder']}/)"
        lines.append(
            f"| {link} | {s['practice_area']} | {s['jurisdiction']} | v{s['version']} |"
        )

    lines.append("")

    # Add description blocks for each skill
    for s in skills:
        if s["description"]:
            desc = " ".join(s["description"].split())
            lines.append(f"**{s['name']}** — {desc}")
            lines.append("")

    return "\n".join(lines)


def update_readme(table_content):
    """Replace content between markers in README.md."""
    with open(README_PATH, "r") as f:
        readme = f.read()

    pattern = re.compile(
        re.escape(START_MARKER) + r".*?" + re.escape(END_MARKER),
        re.DOTALL,
    )

    replacement = f"{START_MARKER}\n{table_content}\n{END_MARKER}"
    if pattern.search(readme):
        new_readme = pattern.sub(replacement, readme)
    else:
        print("WARNING: Markers not found in README.md. No changes made.")
        return False

    with open(README_PATH, "w") as f:
        f.write(new_readme)

    return True


if __name__ == "__main__":
    skills = load_skills()
    print(f"Found {len(skills)} skill(s):")
    for s in skills:
        print(f"  - {s['name']} (v{s['version']}) [{s['practice_area']} / {s['jurisdiction']}]")

    table = build_table(skills)
    if update_readme(table):
        print("README.md updated successfully.")
    else:
        print("README.md was not updated.")