# Technology Architecture Assessment

## Meridian Housing Group - Current State Analysis

*Assessment conducted following the [Three-Layer Classification Guide](../../../assessment-toolkit/analysis-templates/three-layer-classification.md) methodology.*

---

## Executive Summary

Meridian's technology landscape is characterised by a solid core Housing Management System (Northgate) surrounded by fragmented point solutions for compliance. There is no integration layer, no data platform, and no unified user experience. This assessment maps the current state across Data, Application, and Process architectures.

---

## Data Architecture Assessment

### Current Data Landscape

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        CURRENT DATA LANDSCAPE                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│    ┌──────────────────────────────────────────────────────────────────┐     │
│    │                    NORTHGATE HOUSING                              │     │
│    │                    (Core HMS - SQL Server)                        │     │
│    │    ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐              │     │
│    │    │Tenancies│ │Properties│ │ Repairs │ │Contacts │              │     │
│    │    └─────────┘ └─────────┘ └─────────┘ └─────────┘              │     │
│    └──────────────────────────────────────────────────────────────────┘     │
│                                                                              │
│    ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌───────────┐                 │
│    │ Keystone  │ │ Promaster │ │ Gas-Track │ │   EICR    │                 │
│    │(Fire/FRA) │ │ (Asbestos)│ │  (Gas)    │ │(Electrical)│                │
│    │           │ │           │ │           │ │           │                 │
│    │ SQL/Access│ │ SQL Server│ │Cloud SaaS │ │Spreadsheet│                 │
│    └───────────┘ └───────────┘ └───────────┘ └───────────┘                 │
│                                                                              │
│    ┌───────────┐ ┌───────────┐ ┌───────────────────────────────────────┐   │
│    │   Lift    │ │ Legionella│ │           SharePoint / OneDrive        │   │
│    │ Contractor│ │  System   │ │    (Documents, Photos, Certificates)   │   │
│    │  Portal   │ │           │ │    ~2TB unstructured data              │   │
│    └───────────┘ └───────────┘ └───────────────────────────────────────┘   │
│                                                                              │
│    ┌───────────────────────────────────────────────────────────────────┐   │
│    │                    EXCEL SPREADSHEETS                              │   │
│    │    Certificate tracking, compliance registers, action logs         │   │
│    │    ~50 spreadsheets, various owners, no version control           │   │
│    └───────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│                         NO INTEGRATION LAYER                                 │
│                         NO DATA WAREHOUSE                                    │
│                         NO SINGLE SOURCE OF TRUTH                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### System-by-System Analysis

| System | Primary Data | Technology | Data Quality | Integration Capability |
|--------|--------------|------------|--------------|------------------------|
| **Northgate Housing** | Tenancies, Properties, Repairs, Contacts | SQL Server (on-prem) | 4/5 - Good | REST API available, DB read access possible |
| **Keystone (Fire Safety)** | FRAs, Actions, Risk Ratings | SQL/Access | 2/5 - Poor | Manual CSV export only |
| **Promaster (Asbestos)** | Surveys, Registers, Locations | SQL Server | 3/5 - Moderate | API available (limited) |
| **Gas-Track** | CP12 Certificates, Engineer Visits | Cloud SaaS | 3/5 - Moderate | API available |
| **EICR System** | Electrical Certificates | Spreadsheet-based | 2/5 - Poor | Manual only |
| **Lift Contractor Portal** | LOLER Records, Service History | Contractor cloud | 3/5 - Moderate | Portal access, no API |
| **Legionella System** | Risk Assessments, Monitoring | On-prem app | 2/5 - Poor | Manual export |
| **SharePoint** | Documents, Photos, Certificates | M365 | 1/5 - Very Poor | Unstructured, no metadata |
| **Excel Spreadsheets** | Various registers and tracking | Local files | 1/5 - Very Poor | Manual only |

### Data Quality Assessment

| Quality Dimension | Score | Findings |
|-------------------|-------|----------|
| **Completeness** | 2/5 | Significant gaps in building information, particularly for older stock |
| **Accuracy** | 3/5 | Core Northgate data good; compliance systems have inconsistencies |
| **Consistency** | 1/5 | Same property identified differently across systems; no master data |
| **Timeliness** | 2/5 | Batch updates, some systems weeks out of date |
| **Uniqueness** | 2/5 | Duplicate records common, especially where manual entry |
| **Validity** | 3/5 | Business rules not consistently enforced |

### Master Data Challenges

| Entity | Systems with Data | Alignment Issue |
|--------|-------------------|-----------------|
| **Property** | All systems | Different identifiers (UPRN, internal IDs, addresses) |
| **Building** | 4 systems | No consistent building-to-property hierarchy |
| **Certificate** | 6 systems | Duplicates, conflicting dates, missing records |
| **Contact** | 3 systems | Duplicate contacts, outdated information |

---

## Application Architecture Assessment

### Current Application Landscape

| Application | Category | Users | Technology | Layer (Three-Layer) |
|-------------|----------|-------|------------|---------------------|
| Northgate Housing | Core HMS | 200 | .NET/SQL Server | Layer 3 (Data source) |
| Keystone | Fire Safety | 15 | Legacy (Access/SQL) | Layer 3 (Data source) |
| Promaster | Asbestos | 10 | .NET/SQL | Layer 3 (Data source) |
| Gas-Track | Gas Safety | 8 | Cloud SaaS | Layer 3 (Data source) |
| Microsoft 365 | Productivity | 450 | Cloud | Governance |
| SharePoint | Documents | 450 | M365 | Layer 3 (Storage) |
| Power BI | Reporting | 25 | M365 | Layer 1 (Limited) |

### Application Gaps

| Gap | Description | Impact |
|-----|-------------|--------|
| **No Integration Layer** | Systems don't communicate | Manual re-keying, data inconsistency |
| **No Mobile Applications** | Field workers use paper | Data entry delays, transcription errors |
| **No Resident Portal** | No digital channel | Phone calls, letters only |
| **No Unified Dashboard** | Multiple logins required | Fragmented view of compliance |
| **No Document Intelligence** | Manual certificate reading | Time-consuming, error-prone |

### Northgate Assessment (Core HMS)

**Capabilities:**
- Property management (28,000 properties)
- Tenancy management
- Repairs management
- Contact management
- Rent accounting
- Basic reporting

**Integration Options:**
- REST API (NPS API) - Limited endpoints
- Database read access - Available with care
- File-based integration - Supported

**Limitations:**
- No Building Safety Act-specific functionality
- Limited document management
- No compliance certificate tracking
- No mobile application
- No resident self-service

**Recommendation:** Northgate remains the core HMS. Build compliance capability around it, not within it.

---

## Process Architecture Assessment

### Key Compliance Processes

#### Process 1: Gas Safety Certificate Management

```
CURRENT STATE: Gas Safety Certificate Process
────────────────────────────────────────────

Contractor ──▶ Completes      ──▶ Uploads to    ──▶ Housing Officer ──▶ Updates
              Inspection          Gas-Track         Downloads PDF       Spreadsheet
                                                                           │
                                                                           ▼
                                                                      Manual Check
                                                                      for Expiry
                                                                           │
                                     ◀─── If near expiry, chase ◀─────────┘
                                           contractor

Issues:
• 2-3 day lag between inspection and record update
• Manual spreadsheet tracking
• No automatic alerts
• No link to Northgate property record
```

#### Process 2: Fire Risk Assessment Management

```
CURRENT STATE: Fire Risk Assessment Process
────────────────────────────────────────────

Fire Risk    ──▶ Conducts      ──▶ Uploads to   ──▶ Building Safety ──▶ Creates
Assessor         Assessment        Keystone         Manager Reviews     Actions
                                                                           │
                                                                           ▼
                                                                      Actions in
                                                                      Spreadsheet
                                                                           │
                                     ◀─── Manual follow-up ◀──────────────┘

Issues:
• FRA and actions in different systems
• No link to building record
• Manual action tracking
• No automatic prioritisation
• No resident notification
```

#### Process 3: Regulator Information Request

```
CURRENT STATE: Regulator Information Request
────────────────────────────────────────────

Regulator    ──▶ Request      ──▶ Sarah Chen   ──▶ Emails 5+       ──▶ Each team
Request          Received         Reviews          Different Teams     Searches
                                                                           │
                                                                           ▼
                                                                      Manual
                                                                      Collation
                                                                           │
3-5 Days Later ◀─── Response Compiled ◀─────── Quality Review ◀───────────┘

Issues:
• 3-5 days to respond
• No confidence in completeness
• Significant staff time
• Risk of missing information
• No audit trail
```

### Process Maturity Assessment

| Process | Current Maturity | Target Maturity | Gap |
|---------|------------------|-----------------|-----|
| Gas Safety Management | 2 - Repeatable | 4 - Managed | 2 levels |
| Electrical Safety Management | 1 - Initial | 4 - Managed | 3 levels |
| Fire Risk Assessment | 2 - Repeatable | 4 - Managed | 2 levels |
| Asbestos Management | 2 - Repeatable | 4 - Managed | 2 levels |
| Building Safety Reporting | 1 - Initial | 5 - Optimising | 4 levels |
| Resident Communication | 1 - Initial | 4 - Managed | 3 levels |

**Maturity Scale:**
- 1 - Initial: Ad-hoc, reactive
- 2 - Repeatable: Documented but manual
- 3 - Defined: Standardised processes
- 4 - Managed: Measured and controlled
- 5 - Optimising: Continuous improvement

---

## Current Azure/M365 Footprint

### Existing Services

| Service | Usage | Spend | Notes |
|---------|-------|-------|-------|
| Microsoft 365 E3 | 450 users | £180K/year | Email, SharePoint, Teams |
| Azure AD (Entra ID) | Identity | Included | Basic configuration |
| SharePoint Online | Document storage | Included | ~2TB, unstructured |
| Power BI Pro | 25 users | £2.5K/year | Basic reports from Northgate |
| OneDrive | Personal storage | Included | Unmanaged |

### Azure Infrastructure

**Current State:** None

Meridian has no Azure infrastructure beyond M365. All line-of-business applications are:
- On-premises (Northgate, Keystone, Promaster, Legionella)
- Third-party SaaS (Gas-Track)
- Spreadsheet-based (EICR, various tracking)

### M365 Assessment Findings

| Area | Finding | Recommendation |
|------|---------|----------------|
| **Entra ID** | Basic setup, no Conditional Access, no PIM | Implement modern identity |
| **SharePoint** | Unstructured document storage | Redesign for golden thread |
| **Power BI** | Limited adoption, basic reports | Expand for compliance dashboards |
| **Power Platform** | Not used | Opportunity for low-code apps |
| **Teams** | Basic communication | Extend for compliance workflows |

---

## Three-Layer Classification of Current State

### Layer 1: End User Experience
**Current State: Minimal**

| Component | Status | Notes |
|-----------|--------|-------|
| Staff Portal | None | Multiple system logins required |
| Resident Portal | None | No digital channel |
| Executive Dashboard | Partial | Basic Power BI, limited data |
| Mobile App | None | Paper-based field work |
| Chatbot/AI Assistant | None | Phone-based enquiries |

### Layer 2: Organisational Intelligence
**Current State: Fragmented**

| Component | Status | Notes |
|-----------|--------|-------|
| Unified Data Platform | None | Data in silos |
| Analytics Engine | Minimal | Basic reporting only |
| Document Intelligence | None | Manual certificate processing |
| Knowledge Management | None | Institutional knowledge in heads |
| Data Governance | None | No catalogue, no lineage |

### Layer 3: Infrastructure & Operations
**Current State: Basic**

| Component | Status | Notes |
|-----------|--------|-------|
| Azure Landing Zone | None | No Azure infrastructure |
| Integration Platform | None | Manual data movement |
| Security Posture | Basic | M365 defaults only |
| Observability | None | No monitoring capability |
| Cost Management | N/A | No Azure consumption |

---

## Integration Requirements Identified

### Northgate Integration (Priority 1)

| Integration Point | Direction | Data | Method |
|-------------------|-----------|------|--------|
| Property Master | Northgate → Platform | Property details, UPRN | API/DB Read |
| Tenancy Data | Northgate → Platform | Current tenants, contacts | API/DB Read |
| Repair Orders | Bidirectional | Compliance-related repairs | API |
| Contact Changes | Northgate → Platform | Resident contact updates | API/Events |

### Compliance System Integrations (Priority 2)

| System | Direction | Data | Method |
|--------|-----------|------|--------|
| Keystone | Keystone → Platform | FRAs, actions, ratings | File export/API |
| Promaster | Promaster → Platform | Asbestos surveys, locations | API |
| Gas-Track | Gas-Track → Platform | CP12 certificates | API |
| EICR | Manual → Platform | Electrical certificates | Document upload |
| Lift Portal | Manual → Platform | LOLER records | Document upload |
| Legionella | Manual → Platform | Risk assessments | File export |

### External Data Sources (Priority 3)

| Source | Data | Method |
|--------|------|--------|
| Building Safety Regulator | Registration status, guidance | Manual/API (future) |
| Land Registry | Title information | API |
| Ordnance Survey | UPRN validation, mapping | API |
| Local Authority | Planning, enforcement | Manual |

---

## Technology Recommendations

### Foundation Requirements

1. **Azure Landing Zone** - Establish secure, governed Azure environment
2. **Integration Platform** - API Management and Logic Apps for system connectivity
3. **Identity Foundation** - Conditional Access, PIM, MFA for all users

### Data Platform Requirements

1. **Unified Data Lake** - Microsoft Fabric for all compliance data
2. **Operational Data Store** - Dataverse for transactional data
3. **Document Repository** - SharePoint with metadata schema
4. **Search & Retrieval** - Azure AI Search for golden thread

### Application Requirements

1. **Staff Portal** - Power Apps model-driven for compliance management
2. **Resident Portal** - Power Pages for resident engagement
3. **Mobile App** - Power Apps canvas with offline capability
4. **Executive Dashboard** - Power BI for compliance visibility

---

## Architecture Principles

Based on this assessment, the following principles should guide the solution:

| Principle | Rationale |
|-----------|-----------|
| **Northgate as Master** | Core HMS contains property/tenancy truth |
| **Integrate, Don't Replace** | Build around existing investments |
| **Golden Thread First** | Data architecture enables everything else |
| **Mobile-First Field Work** | Surveyors need offline-capable tools |
| **Resident-Centric Design** | Building Safety Act requires engagement |
| **Security by Design** | Zero Trust, least privilege, audit everything |

---

*Assessment Date: [Assessment Date]*
*Lead Architect: [Architect Name]*
*Document Classification: Internal Use Only*
