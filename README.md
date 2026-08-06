# Individual Software Development — Project Repo Template

This is the standard workflow every student follows for their individual project.
Read this in full before you write a single line of code.

## 1. Set up your repo

**Option A — GitHub Classroom (recommended if the course uses it)**
1. Click the assignment invite link shared on the course page.
2. GitHub Classroom creates a private repo for you automatically, named
   `<assignment>-<your-github-username>`.
3. Clone it: `git clone <your-repo-url>`

**Option B — Manual (if no Classroom link is provided)**
1. Create a new **private** repository on GitHub named `pa1414-<your-name>-<project-short-name>`.
2. Add the course examiner/TA as a collaborator (see course page for GitHub handle).
3. Clone it locally, then copy the contents of this template into it:
   ```
   git clone <your-empty-repo-url>
   cd <your-repo>
   # copy files from this template in, then:
   git add .
   git commit -m "chore: initial project scaffolding"
   git push
   ```

## 2. Project structure

Use this layout (adapt folder names to your language/stack, keep the shape):

```
your-repo/
├── README.md              # project pitch, setup & run instructions
├── docs/
│   └── user_stories.md    # all user stories + acceptance criteria
├── src/                   # application code
├── tests/                 # automated tests
├── .gitignore
└── requirements.txt / package.json / pom.xml  (whatever your stack uses)
```

## 3. Write your user stories BEFORE you code

Add every story to `docs/user_stories.md` using this format:

```
### US<N>: <short title>
As a <role>, I want <capability>, so that <benefit>.

**Acceptance Criteria**
- Given <context>, when <action>, then <expected result>
- Given <context>, when <action>, then <expected result>

**Status:** Not started / In progress / Done
```

Guidelines:
- Each story should be small enough to implement and demo in a day or two (INVEST: Independent,
  Negotiable, Valuable, Estimable, Small, Testable).
- Write acceptance criteria as testable statements, not vague adjectives. "The list loads fast" is
  not testable. "Given 100 items, the list renders in under 1 second" is.
- Aim for 5–8 stories for a course project of this size. Prioritize a thin end-to-end slice first,
  then add depth.

## 4. Development & commit workflow

- **One story (or one clear sub-task) per commit or small commit series.** Don't batch three
  features into one commit.
- **Commit messages** follow: `<type>: <what changed>` where type is one of
  `feat`, `fix`, `test`, `docs`, `refactor`, `chore`. Example: `feat: add habit creation command`.
- **Commit often.** A project with 3 commits at the deadline is a red flag for the examiner — it
  usually means no real iteration happened. Aim for commits that map to visible, working progress.
- **Every story gets at least one test** that checks its acceptance criteria, committed alongside
  the feature (or immediately after, referencing the story).
- Update the story's **Status** in `user_stories.md` in the same commit that finishes it.
- Push regularly — don't keep two weeks of work sitting local and unpushed.

## 5. Definition of done (per story)

A story is Done only when:
- [ ] Code implementing it is committed and pushed
- [ ] All its acceptance criteria pass, and there's a test proving it
- [ ] `user_stories.md` status is updated to Done
- [ ] README's usage/setup instructions still match reality

## 6. Definition of done (whole project)

- [ ] All planned stories are Done, or explicitly marked out-of-scope with a reason
- [ ] `README.md` explains what the project does and how to run it from a clean checkout
- [ ] Commit history tells a coherent story of incremental development (this is graded)
- [ ] Tests run and pass

## 7. Want to see a worked example first?

A complete miniature example project (repo structure, user stories with acceptance criteria,
incrementally-developed code, and a matching commit history) is provided separately as a
reference — look at its `git log` and `docs/user_stories.md` to see the expected granularity
before you start your own.
