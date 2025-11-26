# Layer 1: Experience

## Meridian Housing Group - User Application Architecture

*Experience layer designed following the [Three-Layer Framework Layer 1 Principles](../../../three-layer-overlay/layer-1-end-user-experience/README.md).*

---

## Overview

Layer 1 delivers the user-facing applications that enable staff, residents, and executives to interact with building safety data. Built on the Power Platform, these applications consume the intelligence from Layer 2 and provide intuitive, role-appropriate experiences.

**Key Outcomes:**
- Unified staff portal replacing 8+ system logins
- Resident self-service portal for transparency
- Executive dashboards for strategic oversight
- Mobile app for field surveyors
- AI-powered compliance assistant
- 5-10x ROI through user productivity gains

---

## Application Portfolio

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       LAYER 1: APPLICATION PORTFOLIO                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  STAFF APPLICATIONS                                                          │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │  Building       │  │   Mobile        │  │   Compliance    │             │
│  │  Safety Portal  │  │   Surveyor      │  │   Copilot       │             │
│  │                 │  │   App           │  │                 │             │
│  │  Power Apps     │  │   Power Apps    │  │  Copilot Studio │             │
│  │  Model-Driven   │  │   Canvas        │  │                 │             │
│  │  50 users       │  │   25 users      │  │  All staff      │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  EXTERNAL APPLICATIONS                                                       │
│  ┌─────────────────┐  ┌─────────────────┐                                   │
│  │  Resident       │  │  Contractor     │                                   │
│  │  Safety Portal  │  │  Upload Portal  │                                   │
│  │                 │  │                 │                                   │
│  │  Power Pages    │  │  Power Pages    │                                   │
│  │  (Authenticated)│  │  (Partner)      │                                   │
│  │  8,500 users    │  │  50 users       │                                   │
│  └─────────────────┘  └─────────────────┘                                   │
│                                                                              │
│  ANALYTICS APPLICATIONS                                                      │
│  ┌─────────────────┐  ┌─────────────────┐                                   │
│  │  Executive      │  │  Operational    │                                   │
│  │  Dashboard      │  │  Reports        │                                   │
│  │                 │  │                 │                                   │
│  │  Power BI       │  │  Power BI       │                                   │
│  │  (Embedded)     │  │  (Workspace)    │                                   │
│  │  10 users       │  │  50 users       │                                   │
│  └─────────────────┘  └─────────────────┘                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Building Safety Portal (Staff)

### Overview

The Building Safety Portal is the primary application for compliance staff, providing a unified view of all building safety data and enabling management of compliance activities.

**Technology:** Power Apps Model-Driven
**Users:** Building Safety team, Housing Officers, Managers (50 users)
**Licence:** Power Apps per-user

### Information Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BUILDING SAFETY PORTAL - SITEMAP                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  HOME                                                                        │
│  ├── My Dashboard                                                            │
│  │   ├── My assigned actions                                                │
│  │   ├── Upcoming expiries                                                  │
│  │   └── Recent activity                                                    │
│  │                                                                          │
│  BUILDINGS                                                                   │
│  ├── All Buildings                                                          │
│  ├── High-Rise Buildings (47)                                               │
│  ├── Building Safety Cases                                                  │
│  └── Building Details                                                       │
│      ├── Overview                                                           │
│      ├── Properties (list)                                                  │
│      ├── Fire Risk Assessment                                               │
│      ├── Safety Case                                                        │
│      ├── Documents                                                          │
│      └── Timeline                                                           │
│                                                                              │
│  PROPERTIES                                                                  │
│  ├── All Properties                                                         │
│  ├── Properties by Compliance Status                                        │
│  └── Property Details                                                       │
│      ├── Overview                                                           │
│      ├── Certificates (Gas, EICR)                                          │
│      ├── Asbestos                                                          │
│      ├── Tenancy                                                           │
│      ├── Documents                                                          │
│      └── History                                                            │
│                                                                              │
│  COMPLIANCE                                                                  │
│  ├── Compliance Dashboard                                                   │
│  ├── Gas Safety                                                             │
│  │   ├── Certificates                                                       │
│  │   ├── Expiring Soon                                                     │
│  │   └── No Access                                                         │
│  ├── Electrical Safety                                                      │
│  │   ├── EICR Certificates                                                 │
│  │   └── Expiring Soon                                                     │
│  ├── Fire Safety                                                            │
│  │   ├── Fire Risk Assessments                                             │
│  │   ├── FRA Actions                                                       │
│  │   └── Overdue Actions                                                   │
│  └── Asbestos                                                               │
│      ├── Surveys                                                            │
│      └── ACM Locations                                                      │
│                                                                              │
│  ACTIONS                                                                     │
│  ├── All Actions                                                            │
│  ├── My Actions                                                             │
│  ├── Overdue Actions                                                        │
│  └── Completed Actions                                                      │
│                                                                              │
│  DOCUMENTS                                                                   │
│  ├── Document Search                                                        │
│  ├── Recent Uploads                                                         │
│  └── Upload Document                                                        │
│                                                                              │
│  REPORTS                                                                     │
│  ├── Compliance Summary                                                     │
│  ├── Building Safety Cases                                                  │
│  ├── Regulator Reports                                                      │
│  └── KPI Dashboard                                                          │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Screens

#### Building Compliance View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  BUILDING: Tower 3 - Riverside Estate                          [Edit] [BSC] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────────┐  COMPLIANCE STATUS                                    │
│  │                  │  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐        │
│  │   [Building      │  │  GAS   │ │  EICR  │ │  FRA   │ │ASBESTOS│        │
│  │    Photo]        │  │   ✓    │ │   ✓    │ │   !    │ │   ✓    │        │
│  │                  │  │  96%   │ │  92%   │ │ 3 open │ │Current │        │
│  │                  │  └────────┘ └────────┘ └────────┘ └────────┘        │
│  └──────────────────┘                                                       │
│                                                                              │
│  BUILDING DETAILS                        ACCOUNTABLE PERSONS                 │
│  ├── Address: 1-48 Riverside Estate     ├── Principal: Sarah Chen           │
│  ├── Storeys: 18                        └── Building: Marcus Williams       │
│  ├── Units: 48                                                              │
│  ├── Height: 52m                         BSR REGISTRATION                   │
│  └── Build Date: 1972                   ├── Status: Registered              │
│                                         ├── Reg No: BSR-2024-001234         │
│                                         └── Expires: 01/10/2025             │
│                                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│  TABS: [Overview] [Properties] [FRA] [Safety Case] [Documents] [Timeline]   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  FIRE RISK ASSESSMENT                                                        │
│  ├── Last Assessment: 15/03/2024        Risk Rating: MEDIUM                 │
│  ├── Assessor: Fire Safety Solutions Ltd                                    │
│  ├── Next Review Due: 15/03/2025                                            │
│  │                                                                          │
│  │  OPEN ACTIONS (3)                                                        │
│  │  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  │ ! Action 1: Replace fire door - Flat 12       Due: 01/04/2024 │    │
│  │  │ ! Action 2: Service AOV system                Due: 15/04/2024 │    │
│  │  │   Action 3: Update fire strategy document     Due: 01/05/2024 │    │
│  │  └─────────────────────────────────────────────────────────────────┘    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Property Compliance View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  PROPERTY: Flat 12, Tower 3, Riverside Estate                      [Edit]   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  COMPLIANCE CERTIFICATES                                                     │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  GAS SAFETY (CP12)                                                   │   │
│  │  ├── Status: ✓ COMPLIANT                                            │   │
│  │  ├── Certificate: GC-2024-123456                                    │   │
│  │  ├── Issue Date: 15/01/2024                                         │   │
│  │  ├── Expiry Date: 14/01/2025                                        │   │
│  │  ├── Engineer: J. Smith (Gas Safe: 123456)                          │   │
│  │  └── [View Certificate PDF]                                          │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  ELECTRICAL (EICR)                                                   │   │
│  │  ├── Status: ! EXPIRING SOON (45 days)                              │   │
│  │  ├── Certificate: EICR-2019-789012                                  │   │
│  │  ├── Issue Date: 15/03/2019                                         │   │
│  │  ├── Expiry Date: 14/03/2024                                        │   │
│  │  ├── Inspector: ABC Electrical Ltd                                   │   │
│  │  └── [View Certificate PDF] [Schedule Test]                         │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  TENANT INFORMATION                       ASBESTOS STATUS                   │
│  ├── Name: Mr J. Thompson                ├── Survey Date: 10/06/2020       │
│  ├── Tenancy Start: 01/06/2018          ├── ACM Present: Yes (Artex)       │
│  ├── Contact: 07700 900123              ├── Risk Rating: Low               │
│  └── Email: j.thompson@email.com        └── Management: In-situ             │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Business Rules

| Rule | Trigger | Action |
|------|---------|--------|
| Certificate Expiry Alert | 90 days before expiry | Create alert, notify assigned user |
| Overdue FRA Action | Due date passed | Escalate to manager, flag property |
| No Access Escalation | 3rd failed access attempt | Generate legal letter, escalate |
| Compliance Breach | Gas/EICR expired | Block work orders, alert director |
| BSC Update Required | Annual review due | Notify Accountable Person |

---

## Mobile Surveyor App

### Overview

The Mobile Surveyor App enables field workers to conduct inspections, capture evidence, and update compliance data while on-site.

**Technology:** Power Apps Canvas (Offline-capable)
**Users:** Compliance Surveyors, Housing Officers (25 users)
**Device:** iOS/Android tablets, smartphones

### App Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      MOBILE SURVEYOR APP FLOW                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐      ┌─────────────┐      ┌─────────────┐                 │
│  │   LOGIN     │ ───▶ │  MY JOBS    │ ───▶ │  SELECT     │                 │
│  │  (Entra ID) │      │  TODAY      │      │  PROPERTY   │                 │
│  └─────────────┘      └─────────────┘      └─────────────┘                 │
│                                                   │                          │
│                                                   ▼                          │
│                                          ┌─────────────┐                    │
│                                          │  PROPERTY   │                    │
│                                          │  OVERVIEW   │                    │
│                                          │  (Offline)  │                    │
│                                          └─────────────┘                    │
│                                                   │                          │
│         ┌────────────────────┬──────────────────┬┴──────────────┐           │
│         ▼                    ▼                  ▼               ▼           │
│  ┌─────────────┐     ┌─────────────┐    ┌─────────────┐ ┌─────────────┐   │
│  │ INSPECTION  │     │   PHOTO     │    │  DOCUMENT   │ │  RESIDENT   │   │
│  │    FORM     │     │   CAPTURE   │    │   UPLOAD    │ │  SIGN-OFF   │   │
│  │             │     │             │    │             │ │             │   │
│  │ - Checklist │     │ - Camera    │    │ - Scan cert │ │ - Digital   │   │
│  │ - Findings  │     │ - Annotate  │    │ - Classify  │ │   signature │   │
│  │ - Actions   │     │ - GPS tag   │    │ - Attach    │ │ - Timestamp │   │
│  └─────────────┘     └─────────────┘    └─────────────┘ └─────────────┘   │
│         │                    │                  │               │           │
│         └────────────────────┴──────────────────┴───────────────┘           │
│                                     │                                        │
│                                     ▼                                        │
│                            ┌─────────────┐                                  │
│                            │   SUBMIT    │                                  │
│                            │ (Auto-sync  │                                  │
│                            │  when online)│                                  │
│                            └─────────────┘                                  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Features

| Feature | Description | Benefit |
|---------|-------------|---------|
| Offline Mode | Full functionality without connectivity | Works in basements, plant rooms |
| Photo Capture | Camera integration with auto-GPS tagging | Evidence collection |
| Digital Forms | Configurable inspection checklists | Standardised data capture |
| Signature Capture | Resident sign-off on inspection | Proof of attendance |
| Document Scanner | Built-in OCR for certificates | Immediate data extraction |
| Auto-Sync | Background sync when connected | No manual upload required |

### Inspection Forms

| Form | Fields | Outputs |
|------|--------|---------|
| Gas Safety Check | Access granted, meter location, appliances, defects | Inspection record |
| Electrical Check | Consumer unit, circuits, defects | Inspection record |
| Fire Safety Check | Doors, signage, compartmentation | Actions, photos |
| Communal Area | Cleaning, lighting, access, hazards | Actions, photos |
| Asbestos Inspection | ACM condition, damage, encapsulation | Status update |

---

## Resident Safety Portal

### Overview

The Resident Safety Portal provides residents with transparency about the safety status of their building and home, fulfilling Building Safety Act engagement requirements.

**Technology:** Power Pages (Authenticated external)
**Users:** Residents in high-rise buildings (8,500 potential users)
**Access:** Email/phone verification

### Portal Structure

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      RESIDENT SAFETY PORTAL                                  │
│                      "Your Home, Your Safety"                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  PUBLIC PAGES (Unauthenticated)                                             │
│  ├── Home: Welcome, Building Safety Act information                         │
│  ├── About: Meridian's commitment to safety                                │
│  ├── FAQ: Common questions answered                                         │
│  └── Contact: How to reach the Building Safety team                        │
│                                                                              │
│  AUTHENTICATED PAGES (After login)                                          │
│  ├── My Home                                                                │
│  │   ├── Your property safety status                                       │
│  │   ├── Gas certificate summary (valid until...)                          │
│  │   ├── Electrical certificate summary                                    │
│  │   └── Download certificates                                             │
│  │                                                                          │
│  ├── My Building                                                            │
│  │   ├── Building overview and photo                                       │
│  │   ├── Fire Risk Assessment summary                                      │
│  │   ├── Current safety rating                                             │
│  │   ├── Recent and planned safety works                                   │
│  │   ├── Key contacts (Building Safety Manager)                            │
│  │   └── Building Safety Case summary (downloadable)                       │
│  │                                                                          │
│  ├── Safety Works                                                           │
│  │   ├── Current works in your building                                    │
│  │   ├── Planned works schedule                                            │
│  │   └── Completed works history                                           │
│  │                                                                          │
│  ├── Report a Concern                                                       │
│  │   ├── Report form (category, description, photo upload)                 │
│  │   ├── Track your reports                                                │
│  │   └── Concern history                                                   │
│  │                                                                          │
│  └── Communications                                                         │
│      ├── Safety notices and updates                                        │
│      ├── Fire action plan for your building                                │
│      └── Emergency contacts                                                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### My Building Page

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  MY BUILDING: Tower 3, Riverside Estate                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────────┐  SAFETY STATUS: ✓ COMPLIANT                          │
│  │                  │                                                       │
│  │   [Building      │  Your building meets current safety requirements.     │
│  │    Photo]        │  Last full assessment: March 2024                     │
│  │                  │                                                       │
│  └──────────────────┘                                                       │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  FIRE SAFETY                                                         │   │
│  │  ├── Fire Risk Assessment: Current (reviewed March 2024)            │   │
│  │  ├── Risk Rating: Medium                                            │   │
│  │  ├── Fire Strategy: Stay Put (unless affected by fire/smoke)        │   │
│  │  └── [Download Fire Action Plan]                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  CURRENT SAFETY WORKS                                                │   │
│  │  ├── Fire door replacement programme (Floors 10-18) - In Progress   │   │
│  │  ├── Expected completion: June 2024                                 │   │
│  │  └── [View Details]                                                  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  YOUR BUILDING SAFETY MANAGER                                        │   │
│  │  ├── Name: Marcus Williams                                          │   │
│  │  ├── Email: building.safety@meridianhousing.org.uk                  │   │
│  │  ├── Phone: 0800 123 4567                                           │   │
│  │  └── [Send a Message]                                                │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  [Report a Safety Concern]    [Download Building Safety Case Summary]       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Resident Engagement Features

| Feature | Purpose | BSA Requirement |
|---------|---------|-----------------|
| Building Safety Summary | Transparency | Resident engagement duty |
| Certificate Downloads | Evidence access | Information sharing |
| Concern Reporting | Two-way communication | Complaints system |
| Works Updates | Proactive notification | Keep residents informed |
| Fire Action Plan | Safety guidance | Emergency procedures |

---

## Executive Dashboard

### Overview

The Executive Dashboard provides senior leadership with strategic oversight of building safety compliance across the portfolio.

**Technology:** Power BI (Embedded in Portal)
**Users:** Executive team, Board members (10 users)
**Refresh:** Daily

### Dashboard Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  MERIDIAN HOUSING - BUILDING SAFETY EXECUTIVE DASHBOARD                     │
│  Last Updated: 26 Nov 2024 06:00                    [PDF] [Subscribe]       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  PORTFOLIO COMPLIANCE                                                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │     94%     │  │     92%     │  │     89%     │  │    100%     │        │
│  │  GAS SAFE   │  │    EICR     │  │  FRA CURR   │  │   ASBESTOS  │        │
│  │  ▲ 2% MoM   │  │  ▲ 1% MoM   │  │  ▼ 1% MoM   │  │   SURVEYS   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                                              │
│  ┌─────────────────────────────────┐  ┌─────────────────────────────────┐  │
│  │  BUILDING SAFETY CASES          │  │  HIGH-RISK BUILDINGS            │  │
│  │                                 │  │                                 │  │
│  │    ████████████████░░░░  78%   │  │  Tower 3    - 3 overdue actions │  │
│  │                                 │  │  Maple Hse  - FRA review due    │  │
│  │    Complete: 37/47              │  │  Oak Tower  - 2 no-access       │  │
│  │    In Progress: 8/47            │  │                                 │  │
│  │    Not Started: 2/47            │  │  [View All High Risk Buildings] │  │
│  │                                 │  │                                 │  │
│  └─────────────────────────────────┘  └─────────────────────────────────┘  │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  COMPLIANCE TREND (12 MONTHS)                                        │   │
│  │                                                                      │   │
│  │  100% ─┬─────────────────────────────────────────────────────────   │   │
│  │        │                                          __────────────    │   │
│  │   90% ─┤                              ___────────                    │   │
│  │        │                    _────────                                │   │
│  │   80% ─┤        ___────────                                          │   │
│  │        │   ────                                                      │   │
│  │   70% ─┼─────────────────────────────────────────────────────────   │   │
│  │        Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec   │   │
│  │                                                                      │   │
│  │        ── Gas   ── EICR   ── FRA Actions                            │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────┐  ┌─────────────────────────────────┐  │
│  │  FRA ACTIONS                    │  │  REGULATOR STATUS               │  │
│  │                                 │  │                                 │  │
│  │  Total Open: 127                │  │  Registered Buildings: 47/47   │  │
│  │  Overdue: 12 (9%)              │  │  Information Requests: 0 open  │  │
│  │  Due This Month: 23            │  │  Last Inspection: Mar 2024     │  │
│  │                                 │  │  Next Inspection: Est. Q2 2025 │  │
│  │  By Priority:                   │  │                                 │  │
│  │  ● Critical: 2                  │  │  Days since last BSR contact:  │  │
│  │  ● High: 15                     │  │           45                    │  │
│  │  ● Medium: 68                   │  │                                 │  │
│  │  ● Low: 42                      │  │                                 │  │
│  └─────────────────────────────────┘  └─────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### KPI Definitions

| KPI | Definition | Target | RAG |
|-----|------------|--------|-----|
| Gas Compliance | Properties with valid CP12 / Total gas properties | 100% | <98% Red |
| EICR Compliance | Properties with valid EICR / Total properties | 100% | <95% Red |
| FRA Currency | Buildings with FRA <12 months / Total buildings | 100% | <90% Red |
| FRA Actions | Open actions not overdue / Total open actions | 95% | <85% Red |
| BSC Completion | Complete BSCs / Total high-rise buildings | 100% | <80% Red |
| Resident Engagement | Residents registered on portal / Total eligible | 50% | <20% Red |

---

## Compliance Copilot

### Overview

The Compliance Copilot is an AI-powered assistant that helps staff answer questions, find information, and navigate the golden thread.

**Technology:** Copilot Studio with Azure OpenAI
**Users:** All staff (450 potential users)
**Integration:** Teams, Portal embedded

### Capabilities

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      COMPLIANCE COPILOT                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  QUESTION TYPES                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  INFORMATION RETRIEVAL (RAG)                                         │   │
│  │  "What are the outstanding fire safety actions for Tower 3?"        │   │
│  │  "Show me the gas certificate for Flat 12, Riverside"               │   │
│  │  "When was the last FRA for Maple House?"                           │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  COMPLIANCE GUIDANCE                                                 │   │
│  │  "What does the Building Safety Act require for resident engagement?"│   │
│  │  "How often should fire doors be inspected?"                        │   │
│  │  "What are our obligations as Principal Accountable Person?"        │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  DOCUMENT SEARCH                                                     │   │
│  │  "Find all asbestos surveys for Riverside Estate"                   │   │
│  │  "Show me FRAs with high risk rating"                               │   │
│  │  "What certificates expire in the next 30 days?"                    │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  REPORT GENERATION                                                   │   │
│  │  "Generate a compliance summary for the board"                      │   │
│  │  "Create a list of properties with expiring EICRs"                  │   │
│  │  "Summarise FRA actions by building"                                │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Sample Interactions

**User:** "What's the compliance status for Tower 3?"

**Copilot:** "Tower 3 (Riverside Estate) has the following compliance status:
- **Gas Safety:** 96% compliant (46/48 properties have valid CP12)
- **Electrical:** 92% compliant (44/48 properties have valid EICR)
- **Fire Risk Assessment:** Current (reviewed 15 March 2024), rated Medium
- **Open FRA Actions:** 3 (1 overdue)

The two gas and four electrical non-compliances are due to no-access situations. Would you like me to show the no-access properties?"

---

## Implementation Checklist

### Phase 1: Staff Portal (Weeks 1-8)

- [ ] Configure Dataverse tables
- [ ] Build model-driven app
- [ ] Create building compliance views
- [ ] Build property detail forms
- [ ] Implement business rules
- [ ] Configure security roles
- [ ] User acceptance testing

### Phase 2: Mobile App (Weeks 9-12)

- [ ] Design canvas app screens
- [ ] Implement offline capability
- [ ] Build inspection forms
- [ ] Configure photo capture
- [ ] Integrate signature capture
- [ ] Field testing
- [ ] Rollout to surveyors

### Phase 3: Resident Portal (Weeks 13-16)

- [ ] Configure Power Pages site
- [ ] Implement authentication
- [ ] Build public pages
- [ ] Create authenticated pages
- [ ] Build concern reporting
- [ ] Accessibility testing
- [ ] Soft launch

### Phase 4: Dashboards and Copilot (Weeks 17-20)

- [ ] Build Power BI semantic model
- [ ] Create executive dashboard
- [ ] Build operational reports
- [ ] Configure Copilot Studio
- [ ] Integrate with AI Search
- [ ] Test and refine responses
- [ ] Launch to all users

---

## Related Documents

- [Solution Overview](solution-overview.md) - Complete architecture design
- [Layer 2: Intelligence](layer-2-intelligence.md) - Data platform powering apps
- [Layer 3: Infrastructure](layer-3-infrastructure.md) - Foundation services
- [Security & Compliance](security-compliance.md) - Access control design

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
