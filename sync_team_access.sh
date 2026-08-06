#!/usr/bin/env bash
#
# sync_team_access.sh
#
# Grants a GitHub team access to every repo in an organization.
# Run this periodically (e.g. weekly via cron, or manually whenever
# students create new repos) so staff never have to add access by hand.
#
# Requirements:
#   - GitHub CLI (gh) installed and authenticated: `gh auth login`
#   - Your account must be an org owner or have permission to manage teams
#
# Usage:
#   ./sync_team_access.sh <org-name> <team-slug> [permission]
#
# Example:
#   ./sync_team_access.sh bth-pa1414-2026 teaching-staff pull
#
# Permission levels: pull (read), push (write), admin

set -euo pipefail

ORG="${1:?Usage: $0 <org-name> <team-slug> [permission]}"
TEAM="${2:?Usage: $0 <org-name> <team-slug> [permission]}"
PERMISSION="${3:-pull}"

echo "Syncing team '$TEAM' access (${PERMISSION}) across all repos in org '$ORG'..."
echo

repos=$(gh repo list "$ORG" --limit 500 --json name --jq '.[].name')

count=0
for repo in $repos; do
  echo "  -> $ORG/$repo"
  gh api \
    --method PUT \
    "orgs/$ORG/teams/$TEAM/repos/$ORG/$repo" \
    -f permission="$PERMISSION" \
    --silent || echo "     (failed - check team slug / permissions)"
  count=$((count + 1))
done

echo
echo "Done. Processed $count repositories."
