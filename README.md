# Claude Code Config

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) configuration for **Spec-Driven Development** — a methodology where specifications (domain models, API contracts, DB schemas, error handling, and UI design) are defined before writing implementation code.

## Methodology

The core workflow follows a **design-first** approach across five phases:

1. **Requirements** — Clarify scope, constraints, and acceptance criteria
2. **Design** — Define domain model, API contracts, DB schema, error handling, and UI design using the **architect** agent
3. **Implement** — Build frontend and backend in parallel using **frontend-implementer** and **backend-implementer** agents
4. **Verify** — Write tests (**tester**), run reviews (**code-reviewer**, **security-reviewer**, etc.), and execute E2E tests (**e2e-tester**)
5. **Finalize** — Commit, push, and update documentation

Additional workflows exist for bugfixes (Reproduce-First), refactoring (Safety-Net-First), DB changes (Schema-First), and documentation.

See [rules/common/workflow.md](rules/common/workflow.md) for details.

## Structure

```
├── agents/          # 14 specialized agents (architect, planner, tester, etc.)
├── commands/        # 13 slash commands (/orchestrate, /plan, /tdd, etc.)
├── rules/           # Coding standards and workflow definitions
│   ├── common/      #   Language-agnostic rules
│   ├── python/      #   Python-specific rules
│   └── typescript/  #   TypeScript-specific rules
└── skills/          # 10 reference skills (patterns, testing, security, etc.)
```

### Key Components

| Component | Description |
|---|---|
| **Agents** | Specialized AI agents for each phase (architect, frontend-implementer, backend-implementer, tester, code-reviewer, etc.) |
| **Commands** | User-invocable slash commands that orchestrate agent workflows |
| **Rules** | Coding standards, workflow definitions, and security guidelines |
| **Skills** | Reference patterns and best practices per language/domain |

## Tech Stack

This configuration is designed for projects using:

- **Frontend**: TypeScript, React, Next.js
- **Backend**: Python, FastAPI
- **Database**: PostgreSQL (Supabase)

## Installation

Copy the contents of this repository into your `~/.claude/` directory:

```bash
cp -r agents/ commands/ rules/ skills/ ~/.claude/
```

## Usage

Use the `/orchestrate` command to run a full workflow:

```
/orchestrate feature "Add user authentication"
/orchestrate bugfix "Fix login timeout issue"
/orchestrate refactor "Extract payment module"
/orchestrate db-change "Add user preferences table"
```

Or invoke individual commands:

```
/plan           # Create implementation plan
/tdd            # Write tests
/code-review    # Review code quality
/e2e            # Run E2E tests
```
