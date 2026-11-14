#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"

echo "Configuring research lab on: $REPO"

gh api -X PATCH "repos/$REPO" -f has_discussions=true >/dev/null
echo "✓ Discussions enabled"

gh repo edit "$REPO" \
  --add-topic github-achievements \
  --add-topic github-profile \
  --add-topic research \
  --add-topic gh-cli \
  --description "Research sandbox: earn GitHub profile achievements (playbook + Actions lab)"
echo "✓ Topics and description set"

echo ""
echo "Manual checks for YOLO workflow:"
echo "  Settings → Branches → ensure main does NOT require pull request reviews (temporarily)."
echo ""
echo "For Pair Extraordinaire, add repository secrets:"
echo "  COAUTHOR_NAME, COAUTHOR_EMAIL  (second GitHub account)"
echo ""
echo "Run workflows: Actions → research-quickdraw | research-yolo | research-pull-shark | research-pair-extraordinaire"