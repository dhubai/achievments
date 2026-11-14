#!/usr/bin/env bash
set -euo pipefail

count="${1:-1}"
count=$((count > 5 ? 5 : count))
REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

git -C "$ROOT" checkout main
git -C "$ROOT" pull origin main

for i in $(seq 1 "$count"); do
  stamp="$(date -u +%Y%m%dT%H%M%S)-${i}"
  branch="research/pull-shark-$stamp"
  file="$ROOT/research/pull-shark/$stamp.md"
  mkdir -p "$ROOT/research/pull-shark"
  echo "run $stamp" > "$file"
  git -C "$ROOT" checkout -b "$branch"
  git -C "$ROOT" add "research/pull-shark/$stamp.md"
  git -C "$ROOT" commit -m "research: pull-shark $stamp"
  git -C "$ROOT" push -u origin "$branch"
  pr=$(gh pr create --repo "$REPO" --base main --head "$branch" \
    --title "research: pull-shark $stamp" \
    --body "Pull Shark research merge.")
  gh pr merge "$pr" --merge --repo "$REPO"
  git -C "$ROOT" checkout main
  git -C "$ROOT" pull origin main
  echo "Merged PR #$pr"
done