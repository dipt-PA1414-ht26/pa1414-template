#!/usr/bin/env bash
#
# commit_activity_report.sh
#
# Generates a per-repo commit-activity summary across an entire GitHub
# organization: total commits, number of active days, first/last commit
# date, and a warning flag for repos with suspiciously few commits or
# commits clustered right before a deadline.
#
# Requirements:
#   - GitHub CLI (gh) installed and authenticated: `gh auth login`
#   - git
#
# Usage:
#   ./commit_activity_report.sh <org-name> [deadline YYYY-MM-DD]
#
# Example:
#   ./commit_activity_report.sh bth-pa1414-2026 2026-10-15
#
# Output: a CSV written to commit_activity_report.csv in the current dir,
# plus a printed summary table.

set -euo pipefail

ORG="${1:?Usage: $0 <org-name> [deadline YYYY-MM-DD]}"
DEADLINE="${2:-}"

WORKDIR=$(mktemp -d)
OUTFILE="$(pwd)/commit_activity_report.csv"
echo "repo,total_commits,active_days,first_commit,last_commit,commits_last_48h_before_deadline,flag" > "$OUTFILE"

echo "Fetching repo list for org '$ORG'..."
repos=$(gh repo list "$ORG" --limit 500 --json name --jq '.[].name')

for repo in $repos; do
  echo "Processing $repo..."
  target="$WORKDIR/$repo"
  gh repo clone "$ORG/$repo" "$target" -- -q 2>/dev/null || { echo "  skip (clone failed)"; continue; }

  cd "$target"

  total_commits=$(git log --oneline | wc -l | tr -d ' ')
  active_days=$(git log --format="%ad" --date=short | sort -u | wc -l | tr -d ' ')
  first_commit=$(git log --reverse --format="%ad" --date=short | head -1)
  last_commit=$(git log -1 --format="%ad" --date=short)

  last48=0
  if [ -n "$DEADLINE" ]; then
    since=$(date -d "$DEADLINE -2 days" +%Y-%m-%d 2>/dev/null || date -v-2d -j -f "%Y-%m-%d" "$DEADLINE" +%Y-%m-%d)
    last48=$(git log --oneline --since="$since" --until="$DEADLINE 23:59" | wc -l | tr -d ' ')
  fi

  flag=""
  if [ "$total_commits" -lt 5 ]; then
    flag="LOW_COMMIT_COUNT"
  elif [ -n "$DEADLINE" ] && [ "$total_commits" -gt 0 ] && [ "$last48" -ge $((total_commits * 70 / 100)) ]; then
    flag="LAST_MINUTE_CLUSTER"
  fi

  echo "$repo,$total_commits,$active_days,$first_commit,$last_commit,$last48,$flag" >> "$OUTFILE"

  cd - > /dev/null
done

rm -rf "$WORKDIR"

echo
echo "Report written to $OUTFILE"
echo
column -s, -t "$OUTFILE"
