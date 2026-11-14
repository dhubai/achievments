#!/usr/bin/env bash
set -euo pipefail

COAUTHOR_NAME="${COAUTHOR_NAME:?Set COAUTHOR_NAME}"
COAUTHOR_EMAIL="${COAUTHOR_EMAIL:?Set COAUTHOR_EMAIL (second account noreply email)}"

REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
stamp="$(date -u +%Y%m%dT%H%M%SZ)"
branch="research/pair-$stamp"
file="research/pair/$stamp.md"

mkdir -p "$ROOT/research/pair"
echo "pair $stamp" > "$ROOT/$file"
git -C "$ROOT" checkout main && git -C "$ROOT" pull origin main
git -C "$ROOT" checkout -b "$branch"
git -C "$ROOT" add "$file"
git -C "$ROOT" commit -m "research: pair $stamp" \
  -m "Co-authored-by: $COAUTHOR_NAME <$COAUTHOR_EMAIL>"
git -C "$ROOT" push -u origin "$branch"
pr=$(gh pr create --repo "$REPO" --base main --head "$branch" \
  --title "research: pair $stamp" \
  --body "Pair Extraordinaire research.")
gh pr merge "$pr" --merge --repo "$REPO"
git -C "$ROOT" checkout main && git -C "$ROOT" pull origin main
echo "Merged co-authored PR #$pr"