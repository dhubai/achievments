#!/usr/bin/env bash
set -euo pipefail

REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
branch="research/yolo-$(date -u +%Y%m%dT%H%M%SZ)"
file="$ROOT/research/yolo-log.txt"
mkdir -p "$ROOT/research"
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$file"

git -C "$ROOT" checkout main 2>/dev/null || true
git -C "$ROOT" pull origin main
git -C "$ROOT" checkout -b "$branch"
git -C "$ROOT" add research/yolo-log.txt
git -C "$ROOT" commit -m "research: YOLO $(date -u +%Y%m%dT%H%M%SZ)"
git -C "$ROOT" push -u origin "$branch"

pr=$(gh pr create --repo "$REPO" --base main --head "$branch" \
  --title "research: YOLO $(date -u +%H%M%S)" \
  --body "Merge without review for YOLO research.")
gh pr merge "$pr" --merge --repo "$REPO"
git -C "$ROOT" checkout main
git -C "$ROOT" pull origin main
echo "Merged PR #$pr"