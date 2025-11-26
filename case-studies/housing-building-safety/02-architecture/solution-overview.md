# Solution Overview

## Meridian Housing Group - Building Safety Compliance Platform

---

## Design Principles

The solution architecture is guided by these principles:

| Principle | Description | Application |
|-----------|-------------|-------------|
| **Northgate as Master** | Core HMS contains property and tenancy truth | All property/tenancy data sourced from Northgate |
| **Integrate, Don't Replace** | Build around existing investments | Compliance platform augments, doesn't duplicate |
| **Golden Thread First** | Data architecture enables everything else | Unified data model before user interfaces |
| **Mobile-First for Field** | Surveyors need offline-capable tools | Canvas apps with offline sync |
| **Resident-Centric** | Building Safety Act requires engagement | Public portal with transparency |
| **Security by Design** | Zero Trust, least privilege throughout | Conditional Access, data classification |

---

## Solution Components

### Component Summary

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      SOLUTION COMPONENT MAP                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  USER INTERFACES                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐         │  │
│  │ │Building │ │Resident │ │Executive│ │ Mobile  │ │Compliance│         │  │
│  │ │ Safety  │ │ Safety  │ │Dashboard│ │Surveyor │ │ Copilot │         │  │
│  │ │ Portal  │ │ Portal  │ │         │ │  App    │ │         │         │  │
│  │ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘         │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                      │                                       │
│                                      ▼                                       │
│  DATA SERVICES                                                               │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                                                                        │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  │  │
│  │  │  Dataverse  │  │  AI Search  │  │   Fabric    │  │  Document   │  │  │
│  │  │  (Ops)      │  │  (RAG)      │  │ (Analytics) │  │ Intelligence│  │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘  │  │
│  │                                                                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                      │                                       │
│                                      ▼                                       │
│  INTEGRATION LAYER                                                           │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                                                                        │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  │  │
│  │  │    API      │  │   Logic     │  │    Data     │  │   Event     │  │  │
│  │  │ Management  │  │   Apps      │  │   Factory   │  │   Grid      │  │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘  │  │
│  │                                                                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                      │                                       │
│                                      ▼                                       │
│  SOURCE SYSTEMS                                                              │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐  │
│  │Northgate│ │Keystone │ │Promaster│ │Gas-Track│ │  EICR   │ │SharePt  │  │
│  │  (HMS)  │ │ (Fire)  │ │(Asbestos)│ │ (Gas)  │ │  (Elec) │ │ (Docs)  │  │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Data Architecture

### Unified Data Model

The golden thread concept requires a unified data model with building as the central entity:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        GOLDEN THREAD DATA MODEL                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                              ┌──────────────┐                                │
│                              │   BUILDING   │                                │
│                              │    (Core)    │                                │
│                              └──────────────┘                                │
│                                     │                                        │
│         ┌───────────────┬──────────┼──────────┬───────────────┐             │
│         ▼               ▼          ▼          ▼               ▼             │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │ Properties │  │   Fire     │  │    Gas     │  │ Electrical │ ...        │
│  │            │  │  Safety    │  │   Safety   │  │   Safety   │            │
│  └────────────┘  └────────────┘  └────────────┘  └────────────┘            │
│        │               │              │               │                     │
│        ▼               ▼              ▼               ▼                     │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │ Tenancies  │  │    FRAs    │  │ CP12 Certs │  │   EICRs    │            │
│  │            │  │            │  │            │  │            │            │
│  └────────────┘  └────────────┘  └────────────┘  └────────────┘            │
│                        │                                                     │
│                        ▼                                                     │
│                 ┌────────────┐     ┌────────────┐                           │
│                 │  Actions   │────▶│   Works    │                           │
│                 │            │     │   Orders   │                           │
│                 └────────────┘     └────────────┘                           │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        DOCUMENT REPOSITORY                           │   │
│  │  Certificates, FRAs, Surveys, Plans, Photos - all linked to entity  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         AUDIT TRAIL                                  │   │
│  │  All changes versioned with timestamp, user, reason - golden thread │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Medallion Architecture

Data flows through Bronze → Silver → Gold layers:

| Layer | Purpose | Technology | Retention |
|-------|---------|------------|-----------|
| **Bronze** | Raw data as-ingested, immutable audit | Fabric Lakehouse (Delta) | Forever |
| **Silver** | Cleaned, validated, conformed | Fabric Lakehouse (Delta) | 7 years |
| **Gold** | Analytics-ready, aggregates, KPIs | Fabric Lakehouse + Dataverse | Forever |

### Data Flows

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DATA FLOW ARCHITECTURE                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  BATCH FLOWS (ADF Pipelines - Daily/Hourly)                                 │
│  ───────────────────────────────────────────                                │
│                                                                              │
│  Northgate ────▶ ADF ────▶ Bronze ────▶ Silver ────▶ Gold                  │
│  Keystone  ────▶ ADF ────▶ Bronze ────▶ Silver ────▶ Gold                  │
│  Promaster ────▶ ADF ────▶ Bronze ────▶ Silver ────▶ Gold                  │
│                                                                              │
│  REAL-TIME FLOWS (Logic Apps - Event-Driven)                                │
│  ────────────────────────────────────────────                               │
│                                                                              │
│  Gas-Track  ────▶ Logic App ────▶ Dataverse ────▶ Fabric (near real-time)  │
│  Portal     ────▶ Logic App ────▶ Dataverse ────▶ Fabric (sync)            │
│                                                                              │
│  DOCUMENT FLOWS                                                              │
│  ──────────────                                                             │
│                                                                              │
│  Upload ────▶ SharePoint ────▶ Doc Intel ────▶ AI Search ────▶ Dataverse   │
│                                (OCR/Extract)    (Index)        (Metadata)   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Application Architecture

### Staff Portal (Building Safety Portal)

**Technology:** Power Apps Model-Driven App

**Key Views:**
- **Building 360** - Complete view of a building's compliance status
- **My Actions** - Assigned actions requiring follow-up
- **Certificate Tracker** - Expiring and expired certificates
- **FRA Management** - Fire risk assessments and actions

**Key Features:**
- Role-based views (Manager, Officer, Surveyor)
- Inline document viewing
- Action creation and assignment
- Notes and comments
- Audit trail visibility

### Resident Portal

**Technology:** Power Pages

**Public Pages:**
- Building safety summary (per-building)
- Current compliance status (traffic light)
- Ongoing works and timeline
- FAQ and guidance

**Authenticated Pages:**
- My building details
- Report a concern
- View my building's certificates
- Download safety information

### Executive Dashboard

**Technology:** Power BI Premium

**Dashboards:**
- Portfolio compliance overview
- Building Safety Case status
- Risk heat map
- Certificate expiry forecast
- Regulator readiness score
- KPI trends

### Mobile Surveyor App

**Technology:** Power Apps Canvas App

**Key Features:**
- Offline-capable inspections
- Photo capture with auto-attach
- GPS location stamping
- Digital signatures
- Sync when connected

### Compliance Copilot

**Technology:** Copilot Studio + Azure OpenAI

**Capabilities:**
- "What's the FRA status for Tower 7?"
- "Show me buildings with overdue gas certificates"
- "Find all asbestos locations in Block A"
- "What does the Building Safety Act say about..."

---

## Integration Architecture

### API Strategy

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         API MANAGEMENT LAYER                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  EXTERNAL CONSUMERS                        INTERNAL CONSUMERS                │
│  ──────────────────                        ──────────────────               │
│  ┌─────────────┐                           ┌─────────────┐                  │
│  │  Resident   │                           │ Power Apps  │                  │
│  │   Portal    │                           │   Portal    │                  │
│  └──────┬──────┘                           └──────┬──────┘                  │
│         │                                         │                          │
│         ▼                                         ▼                          │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    AZURE API MANAGEMENT                              │   │
│  │                                                                      │   │
│  │  ┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐        │   │
│  │  │ Building  │  │Compliance │  │ Document  │  │ Northgate │        │   │
│  │  │    API    │  │    API    │  │    API    │  │  Facade   │        │   │
│  │  └───────────┘  └───────────┘  └───────────┘  └───────────┘        │   │
│  │                                                                      │   │
│  │  Rate Limiting │ Authentication │ Monitoring │ Caching              │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                    │                                        │
│                                    ▼                                        │
│                            ┌─────────────┐                                  │
│                            │  Dataverse  │                                  │
│                            │   / Fabric  │                                  │
│                            └─────────────┘                                  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Integration Summary

| Source | Direction | Method | Frequency |
|--------|-----------|--------|-----------|
| Northgate | Inbound | DB Read + ADF | Daily + Hourly |
| Keystone | Inbound | File + ADF | Daily |
| Promaster | Inbound | API + Logic App | Daily |
| Gas-Track | Inbound | API + Logic App | Real-time |
| SharePoint | Bidirectional | Native + Graph | Real-time |
| Residents | Outbound | Power Pages | On-demand |

---

## Security Architecture

### Identity & Access

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        IDENTITY ARCHITECTURE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                        ENTRA ID                                      │   │
│  │                                                                      │   │
│  │  ┌──────────────────────────────────────────────────────────────┐   │   │
│  │  │                 CONDITIONAL ACCESS                            │   │   │
│  │  │  • MFA for all users                                         │   │   │
│  │  │  • Compliant device required for sensitive data              │   │   │
│  │  │  • Block legacy authentication                               │   │   │
│  │  │  • Risk-based sign-in policies                               │   │   │
│  │  └──────────────────────────────────────────────────────────────┘   │   │
│  │                                                                      │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │   │
│  │  │ Staff Users  │  │ B2C Residents│  │  Service     │              │   │
│  │  │ (Internal)   │  │ (External)   │  │  Principals  │              │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘              │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ROLE-BASED ACCESS                                                          │
│  ─────────────────                                                          │
│  ┌───────────────┬────────────┬───────────┬──────────┬────────────────┐   │
│  │ Building      │ All data,  │ Compliance│ Dataverse│ Power Apps,    │   │
│  │ Safety Admin  │ all actions│ management│ System   │ Fabric, Admin  │   │
│  ├───────────────┼────────────┼───────────┼──────────┼────────────────┤   │
│  │ Compliance    │ Assigned   │ Certificate│ Business │ Power Apps,    │   │
│  │ Officer       │ buildings  │ management│ Unit     │ Power BI       │   │
│  ├───────────────┼────────────┼───────────┼──────────┼────────────────┤   │
│  │ Surveyor      │ Inspection │ Create/   │ Business │ Mobile App     │   │
│  │               │ data only  │ edit only │ Unit     │                │   │
│  ├───────────────┼────────────┼───────────┼──────────┼────────────────┤   │
│  │ Housing       │ Read-only  │ View only │ Business │ Power Apps     │   │
│  │ Officer       │            │           │ Unit     │ (limited)      │   │
│  ├───────────────┼────────────┼───────────┼──────────┼────────────────┤   │
│  │ Resident      │ Own        │ View      │ Portal   │ Power Pages    │   │
│  │               │ building   │ only      │ Only     │                │   │
│  └───────────────┴────────────┴───────────┴──────────┴────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Data Classification

| Classification | Examples | Controls |
|----------------|----------|----------|
| **Public** | Building address, compliance summary | No restriction |
| **Internal** | Certificate details, FRA summaries | Staff only, MFA |
| **Confidential** | Resident contact details, vulnerabilities | Need-to-know, audit |
| **Restricted** | Security assessments, investigation data | Named users, PIM |

---

## Monitoring & Operations

### Observability Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Application monitoring | Azure Monitor | Platform health |
| User analytics | Power Platform analytics | Adoption, usage |
| Data quality | Fabric monitoring | Pipeline health |
| Security | Defender for Cloud | Threat detection |
| Compliance | Purview (future) | Data governance |

### SLA Targets

| Component | Availability | Performance |
|-----------|--------------|-------------|
| Staff Portal | 99.5% | <3s page load |
| Resident Portal | 99.9% | <2s page load |
| Data Platform | 99.9% | <1hr data freshness |
| Integrations | 99% | <5min sync lag |

---

## Disaster Recovery

| Component | RPO | RTO | Strategy |
|-----------|-----|-----|----------|
| Dataverse | 1 hour | 4 hours | Geo-redundant |
| Fabric | 1 hour | 4 hours | Geo-redundant |
| Documents | 0 (sync) | 1 hour | SharePoint native |
| Northgate | N/A | N/A | Source system |

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
