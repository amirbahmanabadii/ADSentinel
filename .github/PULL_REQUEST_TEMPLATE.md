# Pull Request

## Summary

Provide a concise description of the changes introduced by this pull request.

## Motivation

Explain why this change is needed and what problem it addresses.

## Type of Change

- [ ] New feature
- [ ] Bug fix
- [ ] Refactoring
- [ ] Documentation
- [ ] Testing
- [ ] Security improvement
- [ ] Performance improvement
- [ ] Build / CI
- [ ] Other

## Components Affected

- [ ] Core
- [ ] Domain Discovery
- [ ] Domain Controllers
- [ ] Replication
- [ ] DNS
- [ ] Computers
- [ ] Users
- [ ] Group Policy
- [ ] Security Audit
- [ ] Event Logs
- [ ] Reporting
- [ ] Configuration
- [ ] Logging
- [ ] Tests
- [ ] Documentation
- [ ] GitHub / CI

## Testing

Describe how the changes were tested.

### Pester

```powershell
Invoke-Pester ./tests/Unit -Output Detailed
```

### PSScriptAnalyzer

```powershell
Invoke-ScriptAnalyzer -Path ./src -Recurse
```

## Validation Environment

- PowerShell version:
- Operating system:
- Active Directory lab used: Yes / No
- Integration testing performed: Yes / No

## Validation Checklist

- [ ] Relevant Pester tests pass.
- [ ] PSScriptAnalyzer reports no unresolved findings.
- [ ] New behavior includes tests where practical.
- [ ] Existing behavior remains compatible.

## Security & Privacy

- [ ] No passwords or credentials are included.
- [ ] No authentication tokens, API keys, or private keys are included.
- [ ] No confidential domain names or usernames are included.
- [ ] No internal server names or private infrastructure addresses are included.
- [ ] No sensitive logs or production configuration files are included.
- [ ] Screenshots and test data have been sanitized.

## Documentation

- [ ] Documentation was updated where required.
- [ ] `README.md` was updated if user-facing behavior changed.
- [ ] `README.fa.md` was updated when applicable.
- [ ] `docs/architecture.md` was updated if architecture changed.
- [ ] `CHANGELOG.md` was updated when appropriate.

## Breaking Changes

- [ ] No
- [ ] Yes

If yes, explain the impact and required migration steps.

## Additional Notes

Add implementation details, known limitations, follow-up work, or other relevant information here.

---

By submitting this pull request, the contributor agrees that the contribution will be distributed under the ADSentinel MIT License.