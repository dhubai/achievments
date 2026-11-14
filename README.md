# GitHub Achievements Playbook

Practical, **honest** guide to earning [GitHub profile achievements](https://docs.github.com/en/account-and-profile/reference/profile-reference#earning-achievements)—with tier notes from the community (GitHub does not publish exact numbers), per-badge how-tos, and a CLI progress helper.

> Achievements are in public preview and can change. The source of truth is your profile: hover each badge for GitHub’s hint.

## Badges covered

| Achievement | Guide |
|-------------|-------|
| Pull Shark | [docs/badges/pull-shark.md](docs/badges/pull-shark.md) |
| Starstruck | [docs/badges/starstruck.md](docs/badges/starstruck.md) |
| Quickdraw | [docs/badges/quickdraw.md](docs/badges/quickdraw.md) |
| YOLO | [docs/badges/yolo.md](docs/badges/yolo.md) |
| Pair Extraordinaire | [docs/badges/pair-extraordinaire.md](docs/badges/pair-extraordinaire.md) |
| Galaxy Brain | [docs/badges/galaxy-brain.md](docs/badges/galaxy-brain.md) |
| Public Sponsor | [docs/badges/public-sponsor.md](docs/badges/public-sponsor.md) |
| Profile highlights (Pro, Campus, etc.) | [docs/highlights.md](docs/highlights.md) |

**Unclear or likely retired:** Heart On Your Sleeve, Open Sourcerer—no reliable public criteria; skip unless GitHub adds official docs.

## Research lab (this repo)

Automated + manual runs to trigger **every still-earnable achievement** GitHub allows on your own account. Full matrix: [docs/RESEARCH.md](docs/RESEARCH.md).

```bash
chmod +x scripts/*.sh
./scripts/setup-research-repo.sh
# Actions tab: run research-quickdraw, research-yolo, research-pull-shark, research-pair-extraordinaire
# Or locally:
./scripts/run-research-lab.sh quickdraw yolo pull-shark
```

**You still cannot script:** highest **Starstruck** (needs real stars), **Public Sponsor** (payment), retired badges, or profile **highlights**.

## Quick start

1. Install [GitHub CLI](https://cli.github.com/) and run `gh auth login`.
2. Check stats that map to **Pull Shark** and **Starstruck**:

```bash
./scripts/progress.sh
# or: ./scripts/progress.sh Octocat
```

3. Follow the [7-day sandbox playbook](docs/playbook.md) or the [research lab](docs/RESEARCH.md).

## Principles

- **No star-for-star or PR spam rings**—they violate the spirit of GitHub’s ToS and rarely help Starstruck anyway.
- **Own repos and consenting collaborators** for Quickdraw, YOLO, and co-author practice.
- **Tier tables** in this repo match common community lists (e.g. [drknzz/GitHub-Achievements](https://github.com/drknzz/GitHub-Achievements)); treat them as hints, not guarantees.

## Repo layout

```text
docs/badges/     One file per achievement
docs/RESEARCH.md Achievement matrix + secrets
.github/workflows/ research-* lab workflows
scripts/         progress.sh, lab-*.sh, run-research-lab.sh
```

## Contribute

Open a PR with corrections backed by profile screenshots or official GitHub docs/changelog links.