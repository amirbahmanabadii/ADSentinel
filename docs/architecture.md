# ADSentinel Architecture

> **Project Status:** Foundation / Pre-release  
> **Maintainer:** Amir Bahmanabadi

## Overview

ADSentinel is designed as a modular PowerShell toolkit for Active Directory infrastructure health assessment, diagnostics, auditing, and reporting.

The architecture separates application orchestration, core services, Active Directory diagnostics, reporting, configuration, and testing into independent components.

This document describes both the **currently implemented foundation** and the **planned architecture**. Components marked as planned should not be considered production-ready or functionally complete.

---

## High-Level Architecture

```text
                         +----------------------+
                         |   ADSentinel.ps1     |
                         |     Entry Point      |
                         +----------+-----------+
                                    |
                    +---------------+---------------+
                    |                               |
                    v                               v
          +-------------------+           +-------------------+
          |       Core        |           |      Modules      |
          +-------------------+           +-------------------+
          | Configuration     |           | DomainDiscovery   |
          | Environment       |           | DomainController  |
          | Logger            |           | Replication       |
          +---------+---------+           | DNS               |
                    |                     | Computers         |
                    |                     | Users             |
                    |                     | GroupPolicy       |
                    |                     | SecurityAudit     |
                    |                     | EventLogs         |
                    |                     +---------+---------+
                    |                               |
                    +---------------+---------------+
                                    |
                                    v
                         +--------------------+
                         |     Reporting      |
                         +--------------------+
                         | HTML               |
                         | CSV                |
                         | JSON               |
                         +--------------------+
```

---

## Repository Layout

```text
ADSentinel/
├── config/
│   └── config.example.json
├── docs/
│   └── architecture.md
├── examples/
├── output/
│   ├── logs/
│   └── reports/
├── scripts/
│   ├── Install.ps1
│   └── Uninstall.ps1
├── src/
│   ├── ADSentinel.ps1
│   ├── Core/
│   │   ├── Configuration.psm1
│   │   ├── Environment.psm1
│   │   └── Logger.psm1
│   ├── Modules/
│   │   ├── Computers.psm1
│   │   ├── DNS.psm1
│   │   ├── DomainController.psm1
│   │   ├── DomainDiscovery.psm1
│   │   ├── EventLogs.psm1
│   │   ├── GroupPolicy.psm1
│   │   ├── Replication.psm1
│   │   ├── SecurityAudit.psm1
│   │   └── Users.psm1
│   └── Reporting/
│       ├── CsvReport.psm1
│       ├── HtmlReport.psm1
│       └── JsonReport.psm1
└── tests/
    ├── Integration/
    └── Unit/
```

---

## Entry Point

### `src/ADSentinel.ps1`

The entry point initializes ADSentinel and will ultimately coordinate the complete execution lifecycle.

### Currently implemented

- PowerShell version requirement
- Strict mode
- Application version information
- CLI banner
- Initial application startup
- Basic failure handling

### Planned

- Command-line parameters
- Configuration loading
- Environment validation
- Module orchestration
- Report selection
- Structured error handling
- Predictable exit codes

---

## Core Layer

Location:

`src/Core/`

The Core layer will provide services shared by the diagnostic modules.

### `Configuration.psm1`

Planned responsibilities:

- Load ADSentinel configuration
- Validate configuration
- Apply defaults
- Reject invalid settings
- Separate local configuration from source-controlled examples

### `Environment.psm1`

Planned responsibilities:

- Detect the operating environment
- Validate PowerShell requirements
- Determine platform capabilities
- Verify required dependencies
- Detect availability of Active Directory tooling

### `Logger.psm1`

Planned responsibilities:

- Structured logging
- Severity levels
- Runtime diagnostics
- File-based logging
- Timestamped events
- Consistent diagnostic context

---

## Diagnostic Modules

Location:

`src/Modules/`

Diagnostic functionality is divided into focused modules.

### `DomainDiscovery.psm1`

Planned to discover fundamental domain and forest information required by other modules.

### `DomainController.psm1`

Planned to collect and evaluate domain controller information.

### `Replication.psm1`

Planned to evaluate Active Directory replication state and expose replication-related diagnostics.

### `DNS.psm1`

Planned to perform DNS checks relevant to Active Directory operation.

### `Computers.psm1`

Planned to collect and evaluate Active Directory computer account information.

### `Users.psm1`

Planned to collect and evaluate Active Directory user account information.

### `GroupPolicy.psm1`

Planned to provide Group Policy inspection and diagnostic capabilities.

### `SecurityAudit.psm1`

Planned to perform selected security-oriented Active Directory configuration checks.

### `EventLogs.psm1`

Planned to collect relevant Windows event information for supported diagnostic scenarios.

> These module files currently form part of the project structure. Their production diagnostic functionality will be implemented and tested incrementally.

---

## Reporting Layer

Location:

`src/Reporting/`

ADSentinel is designed to separate infrastructure diagnostics from presentation.

Planned output formats:

- HTML
- CSV
- JSON

Diagnostic modules should return structured data. Reporting components will consume that data and transform it into the requested output format.

This design allows the same diagnostic result to be reused by multiple reporting mechanisms.

---

## Configuration Model

Example configuration:

`config/config.example.json`

Local environment configuration is intended to use:

`config/config.json`

The local configuration file is excluded from Git through `.gitignore`.

Real credentials, secrets, production domain information, and sensitive infrastructure data must never be added to the example configuration.

---

## Testing Architecture

### Unit Tests

Location:

`tests/Unit/`

Unit tests are intended to run without requiring a live Active Directory environment.

The current foundation test suite validates:

- ADSentinel entry-point existence
- Example configuration existence
- JSON configuration validity
- Application identity
- Required PowerShell version declaration
- Strict mode enforcement
- Successful entry-point execution

### Integration Tests

Location:

`tests/Integration/`

Integration testing will validate Windows and Active Directory-specific behavior.

These tests will be introduced as functional modules are implemented.

Integration tests should use controlled lab environments rather than production infrastructure.

---

## Development Model

Cross-platform development environments can be used for:

- Source development
- Git workflows
- Documentation
- Static analysis
- Configuration validation
- Platform-independent unit tests

Windows-based environments will be required for functionality that depends on:

- Active Directory Domain Services
- Windows-specific management interfaces
- ActiveDirectory PowerShell module
- Group Policy tooling
- Windows Event Logs
- AD-integrated DNS functionality
- Domain controller diagnostics

---

## Planned Execution Flow

```text
Start
  |
  v
Load Configuration
  |
  v
Validate Runtime Environment
  |
  v
Discover Active Directory Environment
  |
  v
Execute Selected Diagnostic Modules
  |
  v
Normalize Diagnostic Results
  |
  v
Generate Selected Reports
  |
  v
Write Runtime Logs
  |
  v
Return Exit Status
```

---

## Design Principles

ADSentinel is intended to follow these principles:

1. **Modularity**  
   Infrastructure checks should remain isolated and independently testable.

2. **Separation of concerns**  
   Discovery, diagnostics, logging, configuration, and reporting should remain distinct.

3. **Safe handling of infrastructure data**  
   Sensitive organizational information must not be exposed through source control, examples, tests, or public reports.

4. **Structured output**  
   Diagnostic modules should produce predictable objects rather than presentation-specific text.

5. **Testability**  
   Logic should be designed so that as much behavior as possible can be tested without a production domain.

6. **Read-only diagnostics by default**  
   Health and audit operations should avoid modifying Active Directory unless a future operation explicitly requires and documents a change.

7. **Explicit failure behavior**  
   Errors should be observable and actionable rather than silently ignored.

8. **Incremental implementation**  
   Functionality should be introduced through independently testable milestones.

---

## Current Implementation Status

### Available now

- Repository structure
- PowerShell entry point
- Example configuration
- Initial CLI startup
- PowerShell strict mode
- Unit-testing foundation
- PSScriptAnalyzer validation
- Security policy

### Planned

- Active Directory discovery
- Domain controller diagnostics
- Replication diagnostics
- DNS diagnostics
- Computer and user analysis
- Group Policy inspection
- Security auditing
- Event-log diagnostics
- HTML reporting
- CSV reporting
- JSON reporting
- Windows/AD integration testing

---

## Current Project Phase

**Foundation / Pre-release**

ADSentinel is not currently considered production-ready.

The immediate next engineering milestone after completion of the repository foundation is the **Active Directory Domain Discovery Engine**.

---

## Maintainer

**Amir Bahmanabadi**

GitHub: `amirbahmanabadii`  
Email: `amirbahmanabadi@outlook.com`