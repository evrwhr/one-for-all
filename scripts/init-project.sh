#!/bin/bash
# init-project.sh
# Initializes Antigravity configuration in any project directory.
# Usage: init-project.sh [target-directory]
# Example: init-project.sh ~/Projects/my-infra
#          init-project.sh  (uses current directory)
#
# Global config (already installed, applies to all projects):
#   ~/.gemini/GEMINI.md                          → global rules
#   ~/.gemini/antigravity/skills/                → global skills
#   ~/.gemini/antigravity/global_workflows/      → global workflows
#
# Per-project config (copied by this script):
#   <project>/GEMINI.md   → workspace-specific Antigravity overrides
#   <project>/AGENTS.md   → cross-tool rules (Cursor, Claude Code, etc.)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="${1:-$(pwd)}"

GEMINI_MD="$SOURCE_DIR/GEMINI.md"
AGENTS_MD="$SOURCE_DIR/AGENTS.md"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}Antigravity project init${RESET}"
echo "Target: $TARGET_DIR"
echo ""

if [ ! -d "$TARGET_DIR" ]; then
  echo "Directory not found: $TARGET_DIR"
  exit 1
fi

copy_if_missing() {
  local src="$1"
  local dest="$2"
  local name="$(basename "$src")"

  if [ -f "$dest" ]; then
    echo -e "${YELLOW}  skipped${RESET}  $name (already exists)"
  else
    cp "$src" "$dest"
    echo -e "${GREEN}  copied${RESET}   $name"
  fi
}

copy_if_missing "$GEMINI_MD" "$TARGET_DIR/GEMINI.md"
copy_if_missing "$AGENTS_MD" "$TARGET_DIR/AGENTS.md"

echo ""
echo -e "${GREEN}Done.${RESET} Open $TARGET_DIR in Antigravity and start building."
