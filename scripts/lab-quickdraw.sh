#!/usr/bin/env bash
set -euo pipefail

REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
num=$(gh issue create --repo "$REPO" \
  --title "research: quickdraw local $(date -u +%Y%m%dT%H%M%SZ)" \
  --body "Local Quickdraw lab — closing within 5 minutes.")
echo "Opened #$num; waiting 90s..."
sleep 90
gh issue close "$num" --repo "$REPO" --comment "Closed within 5 minutes (research)."
echo "Done."