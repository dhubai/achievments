# Research lab — achievement coverage

Use **this repository** (`dhubai/achievments`) as the sandbox. GitHub awards achievements on your **account**, not in this repo automatically—you still run the lab and confirm on [your profile](https://github.com/settings/profile).

## Coverage matrix

| Badge | Max tier (community) | In this repo | Notes |
|-------|----------------------|--------------|--------|
| Pull Shark | Gold (~1024 merged PRs **you** opened) | [workflow](../.github/workflows/research-pull-shark.yml) + [script](../scripts/lab-pull-shark.sh) | You already have **106** via API; gold needs many more merges |
| Starstruck | Gold (~4096★ on one owned repo) | README + [checklist](research/starstruck-checklist.md) | Cannot script stars; polish + share |
| Quickdraw | Default (higher unclear) | [workflow](../.github/workflows/research-quickdraw.yml) | Issue/PR closed &lt; 5 min |
| YOLO | Default | [workflow](../.github/workflows/research-yolo.yml) | Requires **no required PR reviews** on `main` |
| Pair Extraordinaire | Gold (~48) | [workflow](../.github/workflows/research-pair-extraordinaire.yml) | Needs second GitHub account + `COAUTHOR_*` secrets |
| Galaxy Brain | Gold (~32 accepted) | [script](../scripts/lab-galaxy-brain.sh) | Enable Discussions + Q&A category |
| Public Sponsor | Default | [guide](badges/public-sponsor.md) | Paid; no automation |
| Highlights (Pro, Campus, …) | n/a | [highlights.md](highlights.md) | Programs / billing |
| Mars 2020 / Arctic Vault | n/a | — | **Retired** |
| Heart On Your Sleeve / Open Sourcerer | n/a | — | **Unknown / likely retired** |

## One-time repo setup

```bash
./scripts/setup-research-repo.sh
```

This enables Discussions, sets topics, and prints branch-protection checks for YOLO.

**For Actions-based PR workflows** (YOLO, Pull Shark, Pair):  
Repo **Settings → Actions → General → Workflow permissions** → enable  
**Allow GitHub Actions to create and approve pull requests**.  
If that stays off, use the local scripts (`lab-yolo.sh`, `lab-pull-shark.sh`, …) with your `gh auth login` token instead.

## Run everything (local, with `gh`)

```bash
export COAUTHOR_NAME="Your Alt Account"
export COAUTHOR_EMAIL="alt@users.noreply.github.com"   # from github.com/settings/emails
./scripts/run-research-lab.sh quickdraw yolo pair pull-shark
```

Or use **Actions** → run each `research-*` workflow manually (recommended for Quickdraw/YOLO timing).

## GitHub Actions secrets (Pair Extraordinaire)

| Secret | Purpose |
|--------|---------|
| `COAUTHOR_NAME` | Display name on co-author trailer |
| `COAUTHOR_EMAIL` | Must match the **other** account’s verified/noreply email |

## Ethics / ToS

For **research** on your own repo only. Do not mass-spam third-party repositories. Batch Pull Shark runs are capped in workflows to reduce noise.