# Changelog

All notable changes to ADSentinel will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project intends to follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial ADSentinel repository structure.
- PowerShell 7.4+ application entry point.
- Application startup banner and development version information.
- Strict PowerShell execution mode.
- Example JSON configuration model.
- Modular project structure for Core, diagnostic, and reporting components.
- Initial Pester unit test suite.
- PSScriptAnalyzer-based static analysis foundation.
- English project documentation.
- Persian project documentation.
- Architecture documentation.
- Security policy.
- MIT License.

### Security

- Added rules for excluding local configuration and common secret or credential files from version control.
- Documented requirements for sanitizing Active Directory and organizational infrastructure information.

### Planned

- Continuous Integration workflow.
- GitHub issue and pull request templates.
- Active Directory domain and forest discovery.
- Windows and Active Directory integration testing.