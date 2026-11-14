#!/usr/bin/env bash
# Creates a Q&A discussion; accept the answer in the GitHub UI for Galaxy Brain credit.
set -euo pipefail

REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
owner="${REPO%%/*}"
name="${REPO##*/}"

gh api -X PATCH "repos/$REPO" -f has_discussions=true >/dev/null 2>&1 || true

category_id=$(gh api graphql -f query='
  query($owner: String!, $name: String!) {
    repository(owner: $owner, name: $name) {
      discussionCategories(first: 20) {
        nodes { id name }
      }
    }
  }
' -f owner="$owner" -f name="$name" \
  --jq '.data.repository.discussionCategories.nodes[] | select(.name=="Q&A") | .id' | head -1)

if [ -z "$category_id" ]; then
  echo "No Q&A category yet. On GitHub: Discussions → gear → add Q&A category, then re-run."
  exit 1
fi

repo_id=$(gh api "repos/$REPO" -q .node_id)
title="research: galaxy brain $(date -u +%Y%m%dT%H%M%SZ)"
body="Research question: how do I verify achievement progress for this lab?"

read -r num url < <(gh api graphql -f query='
  mutation($repoId: ID!, $categoryId: ID!, $title: String!, $body: String!) {
    createDiscussion(input: {repositoryId: $repoId, categoryId: $categoryId, title: $title, body: $body}) {
      discussion { number url }
    }
  }
' -f repoId="$repo_id" \
  -f categoryId="$category_id" \
  -f title="$title" \
  -f body="$body" \
  --jq '.data.createDiscussion.discussion | "\(.number) \(.url)"')

discussion_id=$(gh api graphql -f query='
  query($owner: String!, $name: String!, $number: Int!) {
    repository(owner: $owner, name: $name) {
      discussion(number: $number) { id }
    }
  }
' -f owner="$owner" -f name="$name" -F number="$num" \
  --jq '.data.repository.discussion.id')

comment_url=$(gh api graphql -f query='
  mutation($discussionId: ID!, $body: String!) {
    addDiscussionComment(input: {discussionId: $discussionId, body: $body}) {
      comment { url }
    }
  }
' -f discussionId="$discussion_id" \
  -f body="Answer: run ./scripts/progress.sh and confirm badges on your profile after each lab workflow." \
  --jq '.data.addDiscussionComment.comment.url')

echo "Discussion #$num: $url"
echo "Comment: $comment_url"
echo "Mark that comment as Accepted in the UI for Galaxy Brain."