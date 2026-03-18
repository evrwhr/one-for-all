#!/usr/bin/env bash
# install-global.sh
# Installs Antigravity globally for Claude Code and Gemini CLI.
# Usage: ./scripts/install-global.sh
#
# Installs to:
#   ~/.claude/CLAUDE.md                          → Claude Code global config (inline rules)
#   ~/.claude/skills/<name>/SKILL.md             → Claude Code skills (invoked with /name)
#   ~/.gemini/GEMINI.md                          → Gemini CLI global config
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing Antigravity from: ${REPO_DIR}"
echo ""

# Claude Code — global config
echo "Installing Claude Code config..."
mkdir -p "${HOME}/.claude"
cp "${REPO_DIR}/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
echo "  ✓ CLAUDE.md → ~/.claude/CLAUDE.md"

# Claude Code — skills
echo ""
echo "Installing Claude Code skills..."
SKILLS_SRC="${REPO_DIR}/claude/skills"
SKILLS_DEST="${HOME}/.claude/skills"
mkdir -p "${SKILLS_DEST}"

for skill_dir in "${SKILLS_SRC}"/*/; do
  skill_name="$(basename "${skill_dir}")"
  dest="${SKILLS_DEST}/${skill_name}"
  mkdir -p "${dest}"
  cp "${skill_dir}/SKILL.md" "${dest}/SKILL.md"
  echo "  ✓ /$(echo "${skill_name}")"
done

# Gemini CLI — global config
echo ""
echo "Installing Gemini CLI config..."
mkdir -p "${HOME}/.gemini"
cp "${REPO_DIR}/GEMINI.md" "${HOME}/.gemini/GEMINI.md"
echo "  ✓ GEMINI.md → ~/.gemini/GEMINI.md"

# Summary
echo ""
echo "Done."
echo "  Claude Code skills: $(ls "${SKILLS_DEST}" | wc -l | tr -d ' ')"
echo ""
echo "Paths:"
echo "  ~/.claude/CLAUDE.md"
echo "  ~/.claude/skills/"
echo "  ~/.gemini/GEMINI.md"
