---
description: Write unit tests and integration tests for implemented code. Invokes the tester agent to ensure 80%+ coverage.
---

# Test Writing Command

This command invokes the **tester** agent to write comprehensive unit tests and integration tests for implemented code.

## What This Command Does

1. **Analyze Implementation** - Read modified files to understand what was built
2. **Write Unit Tests** - Test individual functions and components in isolation
3. **Write Integration Tests** - Test API endpoints and DB operations
4. **Cover Edge Cases** - Null, empty, invalid, boundary, error paths
5. **Verify Coverage** - Ensure 80%+ test coverage

## When to Use

Use `/tdd` when:
- After implementing new features (Phase 4)
- After fixing bugs (verify coverage)
- After refactoring (verify behavior preserved)
- When test coverage is below 80%

## How It Works

The tester agent will:

1. **Read implementation files** to understand what was built
2. **Identify test targets** - public functions, API endpoints, DB operations
3. **Write unit tests** with mocks for external dependencies
4. **Write integration tests** for API and DB operations
5. **Cover edge cases** - null, empty, invalid types, boundaries, errors
6. **Run coverage report** and fill gaps until 80%+

## Example Usage

```
User: /tdd Write tests for the user authentication module

Agent (tester):
# Test Writing Session: User Authentication

## Files Analyzed
- src/services/auth.ts
- src/app/api/auth/login/route.ts
- src/app/api/auth/register/route.ts

## Unit Tests Written
- auth.test.ts: 12 tests (hash password, verify token, validate email, ...)

## Integration Tests Written
- login/route.test.ts: 8 tests (success, invalid credentials, rate limit, ...)
- register/route.test.ts: 6 tests (success, duplicate email, validation, ...)

## Coverage: 92%
```

## Test Types

**Unit Tests** (Function-level):
- Happy path scenarios
- Edge cases (empty, null, max values)
- Error conditions
- Boundary values

**Integration Tests** (Component-level):
- API endpoints (all HTTP methods and status codes)
- Database operations (CRUD, constraints, transactions)
- External service calls (with mocks)

**E2E Tests** (use `/e2e` command):
- Critical user flows
- Multi-step processes
- Full stack integration

## Coverage Requirements

- **80% minimum** for all code
- **100% required** for:
  - Financial calculations
  - Authentication logic
  - Security-critical code
  - Core business logic

## Integration with Other Commands

- Use `/plan` first to understand what to build
- Use `/tdd` after implementation to write tests
- Use `/build-fix` if build errors occur
- Use `/code-review` to review implementation
- Use `/test-coverage` to verify coverage
- Use `/e2e` for end-to-end tests

## Related

This command invokes the `tester` agent located at:
`~/.claude/agents/tester.md`

And references the `ts-test-patterns` skill at:
`~/.claude/skills/ts-test-patterns/`
