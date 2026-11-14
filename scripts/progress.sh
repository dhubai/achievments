#!/usr/bin/env bash
# Estimate progress toward GitHub profile achievements using public stats.
# Requires: gh auth login (read:user, repo scopes are enough for your own data)

set -euo pipefail

USER="${1:-$(gh api user -q .login)}"

echo "GitHub user: $USER"
echo "Source: community-reported tiers (not official). Verify on your profile."
echo ""

gh api graphql -f query='
  query($login: String!) {
    user(login: $login) {
      pullRequests(states: MERGED) {
        totalCount
      }
      repositories(
        first: 100
        ownerAffiliations: OWNER
        orderBy: { field: STARGAZERS, direction: DESC }
      ) {
        totalCount
        nodes {
          nameWithOwner
          stargazerCount
          isFork
        }
      }
      repositoriesContributedTo(
        contributionTypes: [COMMIT, PULL_REQUEST, ISSUE, REPOSITORY]
        first: 1
      ) {
        totalCount
      }
    }
  }
' -f login="$USER" --jq '
  .data.user as $u |
  ($u.repositories.nodes | map(select(.isFork == false)) | map(.stargazerCount) | max // 0) as $maxStars |
  ($u.repositories.nodes | map(select(.isFork == false)) | map(.stargazerCount) | add // 0) as $sumStars |
  {
    pull_shark_merged_prs_opened: $u.pullRequests.totalCount,
    starstruck_max_stars_on_owned_repo: $maxStars,
    starstruck_sum_stars_owned_nonfork: $sumStars,
    owned_repos: $u.repositories.totalCount,
    contributed_repos: $u.repositoriesContributedTo.totalCount
  }
'

echo ""
echo "Community tier hints (Pull Shark merged PRs you opened): 2 → 16 → 128 → 1024"
echo "Community tier hints (Starstruck stars on one owned repo): 16 → 128 → 512 → 4096"
echo ""
echo "Not available via API: Quickdraw, YOLO, Galaxy Brain, Pair Extraordinaire, Public Sponsor."