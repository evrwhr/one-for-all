#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANTIGRAVITY_DIR="${HOME}/.gemini/antigravity"
SKILLS_SRC="${REPO_DIR}/skills"
SKILLS_DEST="${ANTIGRAVITY_DIR}/skills"

echo "Setting up Antigravity from: ${REPO_DIR}"

# Skills
echo "Installing skills..."
mkdir -p "${SKILLS_DEST}"
for skill_dir in "${SKILLS_SRC}"/*/; do
  skill_name="$(basename "${skill_dir}")"
  dest="${SKILLS_DEST}/${skill_name}"
  mkdir -p "${dest}"
  cp "${skill_dir}/SKILL.md" "${dest}/SKILL.md"
  echo "  ✓ ${skill_name}"
done

# Global agent config
echo "Installing GEMINI.md..."
cp "${REPO_DIR}/GEMINI.md" "${HOME}/.gemini/GEMINI.md"
echo "  ✓ GEMINI.md"

echo "Installing CLAUDE.md..."
cp "${REPO_DIR}/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
echo "  ✓ CLAUDE.md"

echo ""
echo "Antigravity setup complete."
echo "Skills installed: $(ls "${SKILLS_DEST}" | wc -l | tr -d ' ')"
