#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

DIRS=(agents commands rules skills)

mkdir -p "$CLAUDE_DIR"

for dir in "${DIRS[@]}"; do
  target="$CLAUDE_DIR/$dir"
  source="$PROJECT_DIR/$dir"

  if [ -e "$target" ]; then
    echo "skip: $target already exists"
  else
    ln -s "$source" "$target"
    echo "created: $target -> $source"
  fi
done
