# Orchestrate Command

Agent workflow execution aligned with [workflow.md](../rules/common/workflow.md).

## Usage

`/orchestrate [workflow-type] [task-description]`

## Workflow Types

### feature (Web)
Spec-Driven feature implementation (Web frontend):
```
architect -> planner -> frontend-implementer ‖ backend-implementer -> build-error-resolver -> tester -> code-reviewer ‖ security-reviewer ‖ database-reviewer ‖ python-reviewer -> web-e2e-tester -> doc-updater
```

### feature-mobile
Spec-Driven feature implementation (React Native mobile):
```
architect -> planner -> mobile-implementer ‖ backend-implementer -> build-error-resolver -> tester -> code-reviewer ‖ security-reviewer ‖ database-reviewer ‖ python-reviewer -> mobile-e2e-tester -> doc-updater
```

### bugfix
Reproduce-First bug fix:
```
explorer -> [reproduce + fix] -> code-reviewer ‖ security-reviewer ‖ python-reviewer
```

### refactor
Safety-Net-First refactoring:
```
refactor-cleaner -> architect -> [refactor] -> code-reviewer ‖ security-reviewer ‖ python-reviewer ‖ build-error-resolver
```

### db-change
Schema-First database change:
```
architect -> database-reviewer -> [implement] -> code-reviewer ‖ security-reviewer ‖ python-reviewer
```

### security
Security-focused review:
```
security-reviewer -> code-reviewer -> architect
```

`->` = sequential, `‖` = parallel

## Execution Pattern

For each agent in the workflow:

1. **Invoke agent** with context from previous agent
2. **Collect output** as structured handoff document
3. **Pass to next agent** in chain (or launch parallel agents)
4. **Aggregate results** into final report

## Handoff Document Format

Between agents, create handoff document:

```markdown
## HANDOFF: [previous-agent] -> [next-agent]

### Context
[Summary of what was done]

### Findings
[Key discoveries or decisions]

### Files Modified
[List of files touched]

### Open Questions
[Unresolved items for next agent]

### Recommendations
[Suggested next steps]
```

## Example: Feature Workflow

```
/orchestrate feature "Add user authentication"
```

Executes:

1. **Architect Agent**
   - Designs system architecture and trade-offs
   - Documents key decisions
   - Output: `HANDOFF: architect -> planner`

2. **Planner Agent**
   - Creates step-by-step implementation plan
   - Breaks down into phases with dependencies
   - Output: `HANDOFF: planner -> [implement]`

3. **Implementation Phase** (parallel where applicable)
   - **frontend-implementer** (Web): UI components, state, API integration (based on API contracts + UI design)
   - **mobile-implementer** (Mobile): Screens, navigation, platform-specific code (based on API contracts + UI design)
   - **backend-implementer**: API endpoints, DB operations, business logic (based on API contracts + DB design)
   - Output: `HANDOFF: [implement] -> build-error-resolver`

4. **Build Verification**
   - **build-error-resolver**: Fix any build/type errors
   - Output: `HANDOFF: build-error-resolver -> tester`

5. **Tester Agent**
   - Writes unit tests and integration tests
   - Ensures 80%+ coverage
   - Output: `HANDOFF: tester -> [review]`

6. **Review Phase** (parallel)
   - **code-reviewer**: quality, patterns, maintainability
   - **security-reviewer**: vulnerabilities, secrets
   - **python-reviewer**: PEP 8, Pythonic idioms (Python projects)
   - Output: Combined review report

7. **E2E Tester Agent**
   - Tests critical user flows
   - Output: E2E test report

8. **Doc Updater Agent**
   - Updates codemaps and documentation
   - Output: Final Report

## Final Report Format

```
ORCHESTRATION REPORT
====================
Workflow: [type]
Task: [description]
Agents: [agent chain]

SUMMARY
-------
[One paragraph summary]

AGENT OUTPUTS
-------------
[Agent name]: [summary] (per agent used)

FILES CHANGED
-------------
[List all files modified]

TEST RESULTS
------------
[Test pass/fail summary]

REVIEW STATUS
-------------
[Review findings by severity]

RECOMMENDATION
--------------
[SHIP / NEEDS WORK / BLOCKED]
```

## Arguments

$ARGUMENTS:
- `feature <description>` - Spec-Driven feature workflow (Web)
- `feature-mobile <description>` - Spec-Driven feature workflow (Mobile/React Native)
- `bugfix <description>` - Reproduce-First bug fix workflow
- `refactor <description>` - Safety-Net-First refactoring workflow
- `db-change <description>` - Schema-First database change workflow
- `security <description>` - Security review workflow
- `custom <agents> <description>` - Custom agent sequence

## Custom Workflow Example

```
/orchestrate custom "architect,database-reviewer,code-reviewer" "Redesign caching layer"
```

## Tips

1. **Start with architect** for complex features and DB changes
2. **Always include code-reviewer** before merge
3. **Use security-reviewer** for auth/payment/PII
4. **Run review agents in parallel** for faster feedback
5. **Keep handoffs concise** - focus on what next agent needs
