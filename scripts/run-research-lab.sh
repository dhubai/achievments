#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

usage() {
  echo "Usage: $0 [quickdraw|yolo|pull-shark|pair|galaxy-brain|setup|all]..."
  exit 1
}

run() {
  case "$1" in
    setup) bash scripts/setup-research-repo.sh ;;
    quickdraw) bash scripts/lab-quickdraw.sh ;;
    yolo) bash scripts/lab-yolo.sh ;;
    pull-shark) bash scripts/lab-pull-shark.sh "${2:-1}" ;;
    pair) bash scripts/lab-pair-extraordinaire.sh ;;
    galaxy-brain) bash scripts/lab-galaxy-brain.sh ;;
    all)
      bash scripts/setup-research-repo.sh
      bash scripts/lab-quickdraw.sh
      bash scripts/lab-yolo.sh
      bash scripts/lab-pull-shark.sh 1
      [ -n "${COAUTHOR_EMAIL:-}" ] && bash scripts/lab-pair-extraordinaire.sh || echo "Skip pair: set COAUTHOR_NAME and COAUTHOR_EMAIL"
      bash scripts/lab-galaxy-brain.sh || true
      ;;
    *) usage ;;
  esac
}

[ $# -eq 0 ] && usage
for arg in "$@"; do
  run "$arg"
done

./scripts/progress.sh