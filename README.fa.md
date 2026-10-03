# ADSentinel

**ابزار سلامت‌سنجی، ممیزی، عیب‌یابی و گزارش‌گیری زیرساخت Active Directory**

> یک پروژه ماژولار مبتنی بر PowerShell برای بررسی، عیب‌یابی، ممیزی و گزارش‌گیری از محیط‌های Microsoft Active Directory.

[English](README.md) · [معماری پروژه](docs/architecture.md) · [سیاست امنیتی](SECURITY.md) · [راهنمای مشارکت](CONTRIBUTING.md)

---

## وضعیت پروژه

> **پیش‌انتشار / در حال توسعه فعال**

ADSentinel در حال حاضر در مرحله توسعه قرار دارد.

در این مرحله، ساختار اصلی Repository، مدل پیکربندی، نقطه ورود برنامه، زیرساخت تست و استانداردهای توسعه در حال تکمیل هستند تا قابلیت‌های عملیاتی Active Directory روی یک پایه فنی قابل‌اعتماد توسعه داده شوند.

**نسخه فعلی ADSentinel هنوز برای استفاده در محیط Production آماده نیست.**

---

## معرفی

زیرساخت Active Directory از چندین سرویس و لایه پیکربندی مرتبط با یکدیگر تشکیل شده است.

Domain Controllerها، DNS، Replication، Group Policy، اشیای دایرکتوری، تنظیمات امنیتی و Windows Event Logs همگی می‌توانند در بروز مشکلات زیرساختی نقش داشته باشند.

ADSentinel با هدف ایجاد یک Toolkit ساختاریافته مبتنی بر PowerShell طراحی شده است تا این بخش‌ها را در قالب یک چارچوب مشترک برای عیب‌یابی و گزارش‌گیری بررسی کند.

پروژه بر چهار هدف اصلی بنا شده است:

- **Discovery** — شناسایی اطلاعات مرتبط با زیرساخت Active Directory
- **Diagnostics** — عیب‌یابی مشکلات متداول زیرساخت و پیکربندی
- **Audit** — بررسی شرایط منتخب عملیاتی و امنیتی
- **Reporting** — ارائه نتایج در قالب خروجی‌های ساختاریافته و قابل استفاده مجدد

---

## چرا ADSentinel؟

عیب‌یابی Active Directory معمولاً نیازمند جمع‌آوری و تطبیق اطلاعات از ابزارها، Commandها، Consoleها، Logها و PowerShell Cmdletهای مختلف است.

هدف ADSentinel ایجاد یک چارچوب ماژولار است که در آینده بتواند این بررسی‌ها را هماهنگ کند، در حالی که منطق هر بخش همچنان مستقل و قابل تست باقی بماند.

اصول مورد توجه پروژه عبارت‌اند از:

- معماری ماژولار PowerShell
- نتایج عیب‌یابی ساختاریافته
- بررسی‌های تکرارپذیر
- گزارش واضح خطاها
- اجزای قابل تست
- مدیریت امن اطلاعات زیرساخت
- پشتیبانی از چند قالب گزارش
- قابلیت استفاده در Automation

---

## قابلیت‌های فعلی

Foundation فعلی پروژه شامل موارد زیر است:

- Entry Point مبتنی بر PowerShell 7.4+
- فعال‌سازی Strict Mode
- اطلاعات نسخه برنامه
- CLI Startup Banner
- فایل نمونه پیکربندی JSON
- Security Policy پروژه
- ساختار ماژولار Source Code
- زیرساخت Unit Test مبتنی بر Pester
- اعتبارسنجی با PSScriptAnalyzer
- زیرساخت توسعه Cross-platform

Unit Testهای فعلی موارد زیر را بررسی می‌کنند:

- وجود Entry Point پروژه
- وجود Example Configuration
- معتبر بودن JSON Configuration
- هویت برنامه
- الزام نسخه PowerShell
- فعال بودن Strict Mode
- اجرای موفق Entry Point

---

## قابلیت‌های برنامه‌ریزی‌شده

در Roadmap پروژه، توسعه ماژول‌های زیر پیش‌بینی شده است:

- شناسایی Domain و Forest
- Inventory و عیب‌یابی Domain Controllerها
- تحلیل سلامت Replication
- عیب‌یابی DNS
- تحلیل Computer Accountها
- تحلیل User Accountها
- بررسی Group Policy
- ممیزی منتخب تنظیمات امنیتی
- تحلیل Windows Event Logs
- گزارش HTML
- گزارش CSV
- گزارش JSON
- Integration Test در محیط Windows و Active Directory

قابلیت‌های برنامه‌ریزی‌شده تا زمانی که کد و تست مربوط به آن‌ها پیاده‌سازی نشده باشد، نباید قابلیت عملیاتی پروژه تلقی شوند.

---

## معماری

ADSentinel از معماری ماژولار استفاده می‌کند:

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

اجزای اصلی عبارت‌اند از:

- **Entry Point** — راه‌اندازی و Orchestration برنامه
- **Core** — Configuration، اعتبارسنجی Environment و Logging
- **Modules** — اجزای عیب‌یابی Active Directory
- **Reporting** — تولید خروجی HTML، CSV و JSON
- **Tests** — Unit Test و در آینده Integration Test

مستندات کامل معماری:

[مشاهده Architecture Documentation](docs/architecture.md)

---

## ساختار Repository

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

## پیش‌نیازها

### توسعه

Foundation فعلی به موارد زیر نیاز دارد:

- PowerShell 7.4 یا جدیدتر
- Git

ابزارهای پیشنهادی:

- Visual Studio Code
- PowerShell Extension برای Visual Studio Code
- Pester
- PSScriptAnalyzer

### قابلیت‌های آینده Active Directory

بخش‌های وابسته به Active Directory به محیط Windows مناسب و ابزارهای مدیریتی Microsoft نیاز خواهند داشت.

برخی قابلیت‌های آینده به اجزایی مانند موارد زیر وابسته خواهند بود:

- Active Directory Domain Services
- ActiveDirectory PowerShell Module
- Group Policy Management Tools
- Windows Event Logs
- DNS Management Capabilities

---

## شروع کار

Repository را Clone کنید:

```bash
git clone https://github.com/amirbahmanabadii/ADSentinel.git
cd ADSentinel
```

نسخه PowerShell را بررسی کنید:

```powershell
pwsh --version
```

ADSentinel را اجرا کنید:

```powershell
pwsh ./src/ADSentinel.ps1
```

خروجی نسخه فعلی مشابه نمونه زیر است:

```text
Active Directory Infrastructure Toolkit

Version : 0.1.0-dev
Author  : Amir Bahmanabadi

[+] ADSentinel initialized successfully.
[i] Active Directory discovery engine is not loaded yet.
[i] Current milestone: Foundation
```

این خروجی تنها وضعیت Foundation فعلی را نمایش می‌دهد و **Active Directory Discovery هنوز پیاده‌سازی نشده است.**

---

## پیکربندی

Repository شامل فایل نمونه زیر است:

```text
config/config.example.json
```

برای پیکربندی مختص محیط، مسیر زیر در نظر گرفته شده است:

```text
config/config.json
```

این فایل Local توسط `.gitignore` از Version Control خارج شده است.

هیچ‌گاه Credential، Password، Token، Private Key، Log حساس یا اطلاعات محرمانه زیرساخت واقعی را داخل Example Configuration قرار ندهید.

---

## تست

ADSentinel برای تست PowerShell از **Pester** استفاده می‌کند.

برای اجرای Unit Testهای فعلی:

```powershell
Invoke-Pester ./tests/Unit/ADSentinel.Tests.ps1 -Output Detailed
```

Foundation فعلی دارای **7 Unit Test** است.

برای Static Analysis می‌توان از دستور زیر استفاده کرد:

```powershell
Invoke-ScriptAnalyzer -Path ./src -Recurse
```

تغییرات پروژه نباید باعث شکست Pester Testها یا ایجاد Finding حل‌نشده در PSScriptAnalyzer شوند.

---

## امنیت و حریم اطلاعات

اطلاعات حاصل از عیب‌یابی Active Directory می‌توانند شامل داده‌های حساس سازمانی باشند.

موارد زیر نباید در Repository عمومی منتشر شوند:

- Credential
- Password
- Authentication Token
- Private Key
- Production Certificate
- Domain Name محرمانه
- Username حساس
- اطلاعات داخلی Serverها
- Private IP Addressهای زیرساخت
- Logهای محرمانه
- اطلاعات Topology سازمان

برای Issueها، Screenshotها، Exampleها و Test Fixtureهای عمومی از اطلاعات Sanitized یا ساختگی استفاده کنید.

جزئیات بیشتر:

[SECURITY.md](SECURITY.md)

---

## اصول توسعه

ADSentinel بر اساس چند اصل مهندسی توسعه داده می‌شود:

- طراحی ماژولار
- Separation of Concerns
- Structured Output
- Testability
- Error Handling صریح
- عیب‌یابی امن زیرساخت
- Read-only Diagnostics به‌صورت پیش‌فرض
- توسعه مرحله‌ای
- مستندسازی همزمان با توسعه کد

---

## نقشه راه

### Foundation

- [x] ساختار Repository
- [x] PowerShell Entry Point
- [x] Example Configuration
- [x] Unit Testهای اولیه
- [x] Static Analysis Foundation
- [x] Security Policy
- [x] Architecture Documentation
- [ ] Continuous Integration Workflow
- [ ] GitHub Contribution Templates

### Domain Discovery

- [ ] Domain Discovery Engine
- [ ] Forest Discovery
- [ ] جمع‌آوری Domain Metadata
- [ ] Environment Capability Detection
- [ ] Unit Testهای Domain Discovery
- [ ] اعتبارسنجی در Windows/AD Lab

### Infrastructure Diagnostics

- [ ] Domain Controller Diagnostics
- [ ] Replication Diagnostics
- [ ] DNS Diagnostics
- [ ] Computer Analysis
- [ ] User Analysis
- [ ] Group Policy Inspection
- [ ] Security Auditing
- [ ] Event Log Diagnostics

### Reporting

- [ ] مدل استاندارد Diagnostic Result
- [ ] HTML Reports
- [ ] CSV Reports
- [ ] JSON Reports

### Validation & Release

- [ ] Integration Test Suite
- [ ] Windows Lab Validation
- [ ] بازبینی مستندات
- [ ] Pre-release Packaging
- [ ] اولین Tagged Release

---

## مشارکت در پروژه

مشارکت در توسعه پروژه از طریق GitHub Issue و Pull Request انجام خواهد شد.

پیش از مشارکت، فایل زیر را مطالعه کنید:

[CONTRIBUTING.md](CONTRIBUTING.md)

تغییرات باید استانداردهای PowerShell پروژه را رعایت کرده و Pester و PSScriptAnalyzer را با موفقیت پشت سر بگذارند.

---

## مجوز

ADSentinel تحت **MIT License** منتشر می‌شود.

جزئیات:

[LICENSE](LICENSE)

---

## توسعه‌دهنده

**Amir Bahmanabadi**

GitHub: `amirbahmanabadii`  
Email: `amirbahmanabadi@outlook.com`

---

## سلب مسئولیت

ADSentinel در حال حاضر یک پروژه Pre-release است.

پیش از استفاده از قابلیت‌های آینده عیب‌یابی روی زیرساخت عملیاتی Active Directory، Source Code را بررسی کرده و ابتدا آن را در یک محیط آزمایشگاهی کنترل‌شده تست کنید.