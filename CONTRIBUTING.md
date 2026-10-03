# Contributing to ADSentinel

Thank you for your interest in contributing to ADSentinel.

ADSentinel is developed as a modular PowerShell project for Active Directory infrastructure diagnostics, auditing, and reporting. Contributions should preserve reliability, security, testability, and clear separation between diagnostic components.

> ADSentinel is currently in pre-release development. Interfaces and internal architecture may evolve as the project progresses.

---

## Development Requirements

The current development environment requires:

- Git
- PowerShell 7.4 or later
- Pester
- PSScriptAnalyzer

Recommended:

- Visual Studio Code
- PowerShell extension for Visual Studio Code

Verify PowerShell:

```powershell
pwsh --version
```

Check installed development modules:

```powershell
Get-Module Pester -ListAvailable
Get-Module PSScriptAnalyzer -ListAvailable
```

---

## Getting the Source

Fork ADSentinel on GitHub and clone your fork:

```bash
git clone https://github.com/YOUR-USERNAME/ADSentinel.git
cd ADSentinel
```

Create a branch for your change:

```bash
git switch -c feature/short-description
```

Avoid developing directly on `main`.

---

## Branch Naming

Use descriptive branch names.

Examples:

```text
feature/domain-discovery
feature/json-reporting
fix/config-validation
fix/replication-parser
docs/architecture-update
test/domain-discovery
refactor/logger
```

Recommended prefixes:

- `feature/`
- `fix/`
- `docs/`
- `test/`
- `refactor/`
- `chore/`

---

## Commit Messages

ADSentinel uses the principles of Conventional Commits.

Recommended formats:

```text
feat: add domain discovery
fix: handle missing configuration file
docs: update architecture documentation
test: add configuration validation tests
refactor: simplify logging pipeline
chore: update development tooling
```

Keep commits focused on a logical change.

Avoid combining unrelated modifications into a single commit.

---

## PowerShell Standards

PowerShell contributions should:

- support the project's declared PowerShell version
- use `Set-StrictMode` where appropriate
- use approved PowerShell verbs for exported functions
- use descriptive function and parameter names
- avoid unnecessary global state
- avoid silently suppressing errors
- return structured objects where practical
- separate diagnostic logic from presentation
- avoid unnecessary environment modifications
- remain read-only by default for diagnostic operations
- include comment-based help for public functions when appropriate

Code should remain understandable without relying on undocumented environment assumptions.

---

## Formatting

Repository formatting is controlled in part through `.editorconfig`.

PowerShell files use four-space indentation.

Do not introduce unrelated formatting changes when submitting a focused contribution.

---

## Static Analysis

PowerShell changes must pass PSScriptAnalyzer.

Run:

```powershell
Invoke-ScriptAnalyzer -Path ./src -Recurse
```

When modifying tests or PowerShell tooling, analyze the relevant PowerShell files as well.

New unresolved analyzer findings should not be introduced without a documented technical reason.

---

## Testing

ADSentinel uses Pester.

Run the current unit tests with:

```powershell
Invoke-Pester ./tests/Unit -Output Detailed
```

Contributions that introduce new behavior should include appropriate tests whenever practical.

A pull request should not intentionally leave existing tests failing.

---

## Active Directory Integration Testing

Functionality that interacts with Active Directory must be tested against a controlled lab environment before it is considered validated.

Do not use production infrastructure as the only test environment.

Integration tests must not depend on confidential organizational information.

Test fixtures should use fictional or sanitized values.

---

## Security and Sensitive Data

Never commit or publish:

- passwords
- credentials
- authentication tokens
- API keys
- private keys
- production certificates
- confidential domain names
- sensitive usernames
- internal server names
- private infrastructure addresses
- sensitive event logs
- production configuration files
- confidential organizational topology
- proprietary Group Policy data

Do not paste unsanitized infrastructure information into:

- source code
- tests
- documentation
- GitHub issues
- pull requests
- screenshots
- examples

Use fictional or sanitized values.

For security vulnerabilities, follow [SECURITY.md](SECURITY.md).

---

## Pull Requests

Before submitting a pull request:

1. Rebase or synchronize your branch with the current target branch when appropriate.
2. Review your own diff.
3. Run the relevant Pester tests.
4. Run PSScriptAnalyzer.
5. Remove debugging code and temporary files.
6. Confirm no credentials or sensitive infrastructure data are present.
7. Update documentation when behavior changes.
8. Keep the pull request focused on one logical area.

A pull request description should explain:

- what changed
- why the change is needed
- how it was tested
- any known limitations
- whether Active Directory lab validation was performed

---

## Documentation

Changes that affect user-facing behavior should update the relevant documentation.

When appropriate, keep the English and Persian README files aligned:

- `README.md`
- `README.fa.md`

Architecture changes should also update:

`docs/architecture.md`

---

## Generated Output

Runtime reports and logs belong under:

```text
output/reports/
output/logs/
```

Generated runtime data should not normally be committed.

---

## Reporting Bugs

When reporting a bug, include:

- ADSentinel version or commit
- PowerShell version
- Windows version when relevant
- steps to reproduce
- expected behavior
- actual behavior
- sanitized error information

Never include credentials or unsanitized organizational infrastructure data.

---

## Feature Proposals

Feature proposals should explain:

- the problem being addressed
- the proposed behavior
- expected Active Directory or PowerShell dependencies
- security implications
- testing requirements
- expected output or reporting impact

---

## License

By contributing to ADSentinel, you agree that your contributions will be distributed under the project's [MIT License](LICENSE).

---

## Maintainer

**Amir Bahmanabadi**

GitHub: `amirbahmanabadii`  
Email: `amirbahmanabadi@outlook.com`