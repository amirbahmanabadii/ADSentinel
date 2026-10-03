# Security Policy

## Overview

ADSentinel is an Active Directory infrastructure diagnostics and reporting project.

Because Active Directory environments may contain highly sensitive organizational information, security and privacy must be considered when reporting bugs, submitting logs, creating test fixtures, or contributing code.

## Reporting a Vulnerability

Please do not disclose suspected security vulnerabilities through public GitHub issues.

Report security concerns privately to:

**Amir Bahmanabadi**  
**Email:** amirbahmanabadi@outlook.com

Include enough information to reproduce and understand the issue, but remove sensitive infrastructure data before sending it.

## Sensitive Information

Never commit, publish, or include the following in issues, pull requests, examples, screenshots, or test data:

- Active Directory credentials
- Passwords or authentication tokens
- API keys
- Private keys
- Production certificates
- Real internal domain names
- Sensitive usernames
- Internal server names
- Private infrastructure IP addresses
- Organizational topology information
- Confidential Group Policy data
- Sensitive event logs
- Production configuration files

Use sanitized or fictional data whenever examples are required.

## Configuration

Local configuration files containing environment-specific information must remain outside version control.

The repository includes an example configuration file:

`config/config.example.json`

Create local configuration from the example rather than modifying the example with production information.

The default `.gitignore` excludes local configuration and common credential or secret file types.

## Production Environments

ADSentinel is currently under active development and is not considered production-ready.

Review scripts before executing them against an Active Directory environment.

Testing should initially be performed in an isolated lab environment.

## Responsible Disclosure

Please allow reasonable time for investigation and remediation before publicly disclosing a confirmed vulnerability.

## Maintainer

**Amir Bahmanabadi**

GitHub: `amirbahmanabadii`
