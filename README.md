# ADSentinel

**Active Directory Infrastructure Health, Audit, Diagnostics & Reporting Toolkit**

> A modular PowerShell project for inspecting, diagnosing, auditing, and reporting on Microsoft Active Directory environments.

[فارسی](README.fa.md) · [Architecture](docs/architecture.md) · [Security](SECURITY.md) · [Contributing](CONTRIBUTING.md)

---

## Project Status

> **Pre-release / Active Development**

ADSentinel is currently under active development.

The repository foundation, configuration model, command-line entry point, testing infrastructure, and development standards are being established before Active Directory diagnostic capabilities are introduced.

**ADSentinel is not currently considered production-ready.**

---

## Overview

Active Directory environments depend on multiple interconnected services and configuration layers.

Domain controllers, DNS, replication, Group Policy, directory objects, security configuration, and Windows event data can all contribute to infrastructure problems.

ADSentinel is being built to provide a structured PowerShell-based toolkit for examining these areas through a common diagnostic and reporting framework.

The project is designed around four goals:

- **Discover** relevant Active Directory infrastructure information.
- **Diagnose** common infrastructure and configuration problems.
- **Audit** selected operational and security-related conditions.
- **Report** findings through reusable structured output.

---

## Why ADSentinel?

Active Directory troubleshooting often requires administrators to combine information from multiple tools, commands, consoles, logs, and PowerShell cmdlets.

ADSentinel aims to provide a modular framework that can eventually coordinate those checks while keeping the underlying diagnostic logic independently testable.

The project emphasizes:

- modular PowerShell architecture
- structured diagnostic results
- repeatable checks
- clear failure reporting
- testable components
- safe handling of infrastructure information
- multiple report formats
- automation-friendly behavior

---

## Current Capabilities

The current foundation includes:

- PowerShell 7.4+ entry point
- strict execution mode
- application version information
- command-line startup banner
- example JSON configuration
- repository security policy
- modular source structure
- Pester unit-testing foundation
- PSScriptAnalyzer validation
- cross-platform development foundation

The existing unit tests validate:

- project entry-point availability
- example configuration availability
- JSON configuration validity
- application identity
- PowerShell version requirement
- strict mode enforcement
- successful entry-point execution

---

## Planned Capabilities

ADSentinel is planned to include modules for:

- Active Directory domain and forest discovery
- domain controller inventory and diagnostics
- replication health analysis
- DNS diagnostics
- computer account analysis
- user account analysis
- Group Policy inspection
- selected security auditing
- Windows event-log diagnostics
- HTML reporting
- CSV reporting
- JSON reporting
- Windows and Active Directory integration testing

Planned functionality is introduced incrementally and should not be considered implemented until the corresponding code and tests are available.

---

## Architecture

ADSentinel uses a modular architecture:

```text
                    ADSentinel.ps1
                          |
             +------------+------------+
             |                         |
            Core                     Modules
             |                         |
             +------------+------------+
                          |
                       Reporting
```

The main components are:

- **Entry Point** — application initialization and orchestration
- **Core** — configuration, environment validation, and logging
- **Modules** — Active Directory diagnostic components
- **Reporting** — HTML, CSV, and JSON output
- **Tests** — unit and future integration testing

For the complete architecture:

[Read the Architecture Documentation](docs/architecture.md)

---

## Repository Structure

```text
ADSentinel/
├── config/
├── docs/
├── examples/
├── output/
│   ├── logs/
│   └── reports/
├── scripts/
├── src/
│   ├── Core/
│   ├── Modules/
│   └── Reporting/
└── tests/
    ├── Integration/
    └── Unit/
```

---

## Requirements

### Development

Current foundation development requires:

- PowerShell 7.4 or later
- Git

Recommended:

- Visual Studio Code
- PowerShell extension for Visual Studio Code
- Pester
- PSScriptAnalyzer

### Future Active Directory Functionality

Active Directory-specific functionality will require an appropriate Windows environment and relevant Microsoft management tooling.

Some future capabilities will depend on components such as:

- Active Directory Domain Services
- ActiveDirectory PowerShell module
- Group Policy tooling
- Windows Event Logs
- DNS management capabilities

---

## Getting Started

Clone the repository:

```bash
git clone https://github.com/amirbahmanabadii/ADSentinel.git
cd ADSentinel
```

Verify PowerShell:

```powershell
pwsh --version
```

Run ADSentinel:

```powershell
pwsh ./src/ADSentinel.ps1
```

Current startup output resembles:

```text
Active Directory Infrastructure Toolkit

Version : 0.1.0-dev
Author  : Amir Bahmanabadi

[+] ADSentinel initialized successfully.
[i] Active Directory discovery engine is not loaded yet.
[i] Current milestone: Foundation
```

This output represents the current foundation only. Active Directory discovery has not yet been implemented.

---

## Configuration

The repository provides:

```text
config/config.example.json
```

Environment-specific configuration is intended to use:

```text
config/config.json
```

The local configuration file is excluded from version control.

Never place production credentials, passwords, tokens, private keys, sensitive logs, or real confidential infrastructure information in the example configuration.

---

## Testing

ADSentinel uses **Pester** for PowerShell testing.

Run the current unit tests:

```powershell
Invoke-Pester ./tests/Unit/ADSentinel.Tests.ps1 -Output Detailed
```

The foundation currently contains **7 unit tests**.

Static analysis can be performed with:

```powershell
Invoke-ScriptAnalyzer -Path ./src -Recurse
```

Development changes should not introduce Pester failures or unresolved PSScriptAnalyzer findings.

---

## Security & Privacy

Active Directory diagnostic data can contain sensitive organizational information.

Do not publish:

- credentials
- passwords
- authentication tokens
- private keys
- production certificates
- confidential domain names
- sensitive usernames
- internal server information
- private infrastructure addresses
- confidential logs
- organizational topology information

Use sanitized or fictional information in public issues, screenshots, examples, and test fixtures.

See [SECURITY.md](SECURITY.md) for the security policy.

---

## Development Philosophy

ADSentinel is being developed around several engineering principles:

- modular design
- separation of concerns
- structured output
- testability
- explicit error handling
- safe infrastructure diagnostics
- read-only diagnostics by default
- incremental implementation
- documentation alongside code

---

## Roadmap

### Foundation

- [x] Repository structure
- [x] PowerShell entry point
- [x] Example configuration
- [x] Initial unit tests
- [x] Static-analysis foundation
- [x] Security policy
- [x] Architecture documentation
- [ ] Continuous Integration workflow
- [ ] GitHub contribution templates

### Domain Discovery

- [ ] Domain discovery engine
- [ ] Forest discovery
- [ ] Domain metadata collection
- [ ] Environment capability detection
- [ ] Domain discovery unit tests
- [ ] Windows/AD lab validation

### Infrastructure Diagnostics

- [ ] Domain controller diagnostics
- [ ] Replication diagnostics
- [ ] DNS diagnostics
- [ ] Computer analysis
- [ ] User analysis
- [ ] Group Policy inspection
- [ ] Security auditing
- [ ] Event-log diagnostics

### Reporting

- [ ] Normalized diagnostic result model
- [ ] HTML reports
- [ ] CSV reports
- [ ] JSON reports

### Validation & Release

- [ ] Integration test suite
- [ ] Windows lab validation
- [ ] Documentation review
- [ ] Pre-release packaging
- [ ] First tagged release

---

## Contributing

Contributions will be accepted through GitHub issues and pull requests.

Before contributing, review:

[CONTRIBUTING.md](CONTRIBUTING.md)

Changes should follow the project's PowerShell standards and should pass both Pester tests and PSScriptAnalyzer validation.

---

## License

ADSentinel is released under the **MIT License**.

See [LICENSE](LICENSE).

---

## Author

**Amir Bahmanabadi**

GitHub: `amirbahmanabadii`  
Email: `amirbahmanabadi@outlook.com`

---

## Disclaimer

ADSentinel is currently a pre-release project.

Review and test the source code in a controlled lab environment before using future diagnostic functionality against operational Active Directory infrastructure.