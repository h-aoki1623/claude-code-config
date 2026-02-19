# CLAUDE.md

This repository is a Claude Code configuration for **Spec-Driven Development**.

## What This Is

A set of agents, commands, rules, and skills that configure Claude Code to follow a design-first development workflow. Specifications (domain models, API contracts, DB schemas, error handling, UI design) are defined before implementation begins.

## Key References

- **Workflow**: [rules/common/workflow.md](rules/common/workflow.md) — The core Spec-Driven Development workflow (Feature, Bugfix, Refactor, DB Change, Docs)
- **Agent orchestration**: [rules/common/agents.md](rules/common/agents.md) — Available agents and when to use them
- **Orchestrate command**: [commands/orchestrate.md](commands/orchestrate.md) — Run full agent workflows via `/orchestrate`

## Project Structure

- `agents/` — Specialized agents (architect, planner, frontend-implementer, mobile-implementer, backend-implementer, tester, code-reviewer, etc.)
- `commands/` — Slash commands that invoke agent workflows
- `rules/` — Coding standards, workflow definitions, and security guidelines (common + language-specific)
- `skills/` — Reference patterns and best practices per language/domain
