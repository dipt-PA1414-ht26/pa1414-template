# Staff Setup Notes (replaces GitHub Classroom)

GitHub Classroom stopped accepting new users in May 2026 and is being fully retired on
August 28, 2026, so this course uses a plain GitHub Organization instead.

## One-time setup
1. Create an org: github.com/account/organizations → New organization (free tier is fine).
2. Create a team called `teaching-staff`, add all colleagues who should see student repos.
3. Push this template's contents to a new repo in the org, e.g. `pa1414-template`, and
   mark it as a **Template repository** in its Settings.

## Per-term setup
1. Share the template repo link with students. Each student clicks "Use this template" →
   creates a private repo *inside the org* named `pa1414-<studentid>`.
2. Run `scripts/sync_team_access.sh <org> teaching-staff pull` once students have created
   their repos (and again periodically as stragglers create theirs) to give all staff
   read access automatically, without touching each repo by hand.

## During the course
- `scripts/commit_activity_report.sh <org> [deadline]` clones every repo in the org and
  produces a CSV with total commits, active days, first/last commit date, and flags for
  repos with very few commits or a suspicious last-minute commit cluster before a deadline.
- Each repo's GitHub "Insights → Pulse / Commits" tab gives a quick visual per-student view.

## Requirements
Both scripts need the GitHub CLI (`gh`) installed and authenticated (`gh auth login`) with
an account that's an owner or has team-management rights in the org.
