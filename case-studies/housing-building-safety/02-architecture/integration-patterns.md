# Integration Patterns

## Meridian Housing Group - System Connectivity Architecture

*Integration patterns following enterprise integration best practices and the [Three-Layer Framework](../../../three-layer-overlay/README.md) connectivity principles.*

---

## Overview

The Building Safety Platform integrates with 8+ existing systems to create a unified compliance data platform. This document details the integration patterns, data flows, and technical specifications for each system connection.

**Integration Principles:**
- Northgate remains the master for property and tenancy data
- Read-heavy patterns (pull from source, don't replicate core logic)
- Event-driven where possible, batch where practical
- API-first for new integrations, pragmatic for legacy

---

## Integration Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     INTEGRATION ARCHITECTURE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SOURCE SYSTEMS                    INTEGRATION LAYER                         │
│                                                                              │
│  ┌─────────────┐                  ┌─────────────────────────────────────┐   │
│  │  Northgate  │ ─── DB Read ───▶│                                     │   │
│  │   (HMS)     │ ◀── API Write ──│                                     │   │
│  └─────────────┘                  │                                     │   │
│                                   │     AZURE LOGIC APPS                │   │
│  ┌─────────────┐                  │                                     │   │
│  │  Keystone   │ ─── DB Read ───▶│  ┌───────────────────────────────┐ │   │
│  │   (Fire)    │                  │  │  Transformation & Validation  │ │   │
│  └─────────────┘                  │  │  Error Handling & Retry       │ │   │
│                                   │  │  Logging & Monitoring         │ │   │
│  ┌─────────────┐                  │  └───────────────────────────────┘ │   │
│  │  Gas-Track  │ ─── REST API ──▶│                                     │   │
│  │   (Gas)     │                  │                                     │   │
│  └─────────────┘                  │     AZURE DATA FACTORY              │   │
│                                   │                                     │   │
│  ┌─────────────┐                  │  ┌───────────────────────────────┐ │   │
│  │  Promaster  │ ─── REST API ──▶│  │  Batch Processing             │ │   │
│  │  (Asbestos) │                  │  │  Data Quality Rules           │ │   │
│  └─────────────┘                  │  │  Bronze/Silver/Gold ETL       │ │   │
│                                   │  └───────────────────────────────┘ │   │
│  ┌─────────────┐                  │                                     │   │
│  │  EICR/Lift  │ ─── File ──────▶│                                     │   │
│  │  (Manual)   │                  │     AZURE API MANAGEMENT            │   │
│  └─────────────┘                  │                                     │   │
│                                   │  ┌───────────────────────────────┐ │   │
│  ┌─────────────┐                  │  │  API Gateway & Security       │ │   │
│  │  SharePoint │ ─── Graph API ─▶│  │  Rate Limiting                 │ │   │
│  │   (Docs)    │                  │  │  Analytics                     │ │   │
│  └─────────────┘                  │  └───────────────────────────────┘ │   │
│                                   │                                     │   │
│                                   └──────────────┬──────────────────────┘   │
│                                                  │                           │
│                                                  ▼                           │
│                                   ┌─────────────────────────────────────┐   │
│                                   │        MICROSOFT FABRIC             │   │
│                                   │          LAKEHOUSE                  │   │
│                                   │   Bronze → Silver → Gold            │   │
│                                   └──────────────┬──────────────────────┘   │
│                                                  │                           │
│                                                  ▼                           │
│                                   ┌─────────────────────────────────────┐   │
│                                   │        DATAVERSE                    │   │
│                                   │    (Operational Data Store)         │   │
│                                   └─────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Northgate Integration

### Overview

Northgate is the core Housing Management System and master data source for properties, tenancies, and contacts. Integration is bidirectional: read-heavy for data extraction, selective write-back for work orders.

### Connection Method

| Aspect | Details |
|--------|---------|
| **Primary Method** | SQL Database Read (Views) |
| **Secondary Method** | NPS REST API |
| **Connection** | Site-to-Site VPN |
| **Authentication** | SQL Authentication (stored in Key Vault) |
| **Frequency** | Daily batch + hourly incremental |

### Data Extraction

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    NORTHGATE DATA EXTRACTION                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  NORTHGATE SQL SERVER (On-premises)                                         │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                      │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│   │
│  │  │vw_Property  │  │vw_Tenancy   │  │vw_Contact   │  │vw_Repair    ││   │
│  │  │  (Custom)   │  │  (Custom)   │  │  (Custom)   │  │  (Custom)   ││   │
│  │  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘│   │
│  │         │                │                │                │        │   │
│  └─────────┼────────────────┼────────────────┼────────────────┼────────┘   │
│            │                │                │                │             │
│            │    SITE-TO-SITE VPN             │                │             │
│            │                │                │                │             │
│            ▼                ▼                ▼                ▼             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    AZURE DATA FACTORY                                │   │
│  │                                                                      │   │
│  │  Pipeline: pl-northgate-extract                                     │   │
│  │  ├── Copy Activity: Property (Full - Daily)                         │   │
│  │  ├── Copy Activity: Tenancy (Incremental - Daily)                   │   │
│  │  ├── Copy Activity: Contact (Incremental - Daily)                   │   │
│  │  └── Copy Activity: Repair (Incremental - Hourly, compliance only)  │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│            │                                                                 │
│            ▼                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    FABRIC LAKEHOUSE (BRONZE)                         │   │
│  │                                                                      │   │
│  │  brz_northgate_property    brz_northgate_tenancy                    │   │
│  │  brz_northgate_contact     brz_northgate_repair                     │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Custom Views Required

The following views should be created in Northgate (read-only) for extraction:

**vw_Property_Extract**
```sql
-- Northgate Property Extract View (indicative)
SELECT
    PropertyID,
    PropertyRef,
    UPRN,
    AddressLine1,
    AddressLine2,
    AddressLine3,
    Town,
    County,
    Postcode,
    PropertyType,
    Bedrooms,
    BuildDate,
    BlockRef,           -- Building reference
    Floor,
    GasSupply,
    ElectricMeterType,
    HeatingType,
    ModifiedDate
FROM Property
WHERE PropertyStatus = 'Active'
```

**vw_Tenancy_Extract**
```sql
-- Northgate Tenancy Extract View (indicative)
SELECT
    TenancyID,
    TenancyRef,
    PropertyID,
    TenancyType,
    StartDate,
    EndDate,
    Status,
    ModifiedDate
FROM Tenancy
WHERE Status IN ('Current', 'Former')
AND ModifiedDate >= @LastExtractDate  -- Incremental
```

### Write-Back Pattern

Work orders for compliance remediation are created in Northgate:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    NORTHGATE WORK ORDER WRITE-BACK                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  DATAVERSE                         LOGIC APP                    NORTHGATE   │
│                                                                              │
│  ┌─────────────┐    On Create     ┌─────────────┐  NPS API    ┌──────────┐ │
│  │ bsp_action  │ ───────────────▶ │ logic-create│ ──────────▶ │  Repair  │ │
│  │  (FRA)      │                  │ -workorder  │             │  Order   │ │
│  └─────────────┘                  └─────────────┘             └──────────┘ │
│                                         │                                   │
│                                         ▼                                   │
│                                   Validation:                               │
│                                   • Property exists                        │
│                                   • Priority mapping                       │
│                                   • SOR code lookup                        │
│                                                                              │
│  Payload:                                                                    │
│  {                                                                           │
│    "propertyRef": "MER-001234",                                             │
│    "description": "FRA Action: Replace fire door",                          │
│    "priority": "P2",                                                        │
│    "sorCode": "FD001",                                                      │
│    "targetDate": "2024-04-01",                                              │
│    "sourceRef": "FRA-2024-001-A001"                                         │
│  }                                                                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Gas-Track Integration

### Overview

Gas-Track is the cloud SaaS system used by gas contractors to record CP12 certificates. Integration is API-based with near real-time certificate data.

### Connection Method

| Aspect | Details |
|--------|---------|
| **Method** | REST API |
| **Authentication** | API Key (stored in Key Vault) |
| **Endpoint** | https://api.gas-track.co.uk/v2 |
| **Frequency** | Hourly |
| **Events** | Certificate created webhook (optional) |

### API Integration

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    GAS-TRACK API INTEGRATION                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  GAS-TRACK CLOUD                   AZURE                                    │
│                                                                              │
│  ┌─────────────────┐              ┌─────────────────────────────────────┐  │
│  │                 │              │  API MANAGEMENT                      │  │
│  │  /certificates  │◀─────────────│  (Rate limiting, logging)           │  │
│  │  /engineers     │              └──────────────┬──────────────────────┘  │
│  │  /properties    │                             │                          │
│  │                 │              ┌──────────────┴──────────────────────┐  │
│  └─────────────────┘              │  LOGIC APP: logic-gastrack-sync     │  │
│                                   │                                      │  │
│                                   │  Trigger: Recurrence (Hourly)        │  │
│                                   │                                      │  │
│                                   │  Steps:                              │  │
│                                   │  1. Get last sync timestamp          │  │
│                                   │  2. Call GET /certificates           │  │
│                                   │     ?modifiedSince={timestamp}       │  │
│                                   │  3. Transform response               │  │
│                                   │  4. Write to Fabric Bronze           │  │
│                                   │  5. Update sync timestamp            │  │
│                                   │                                      │  │
│                                   └──────────────┬──────────────────────┘  │
│                                                  │                          │
│                                                  ▼                          │
│                                   ┌─────────────────────────────────────┐  │
│                                   │  FABRIC: brz_gastrack_certificate   │  │
│                                   └─────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### API Endpoints Used

| Endpoint | Method | Purpose | Frequency |
|----------|--------|---------|-----------|
| `/certificates` | GET | Retrieve certificates modified since timestamp | Hourly |
| `/certificates/{id}` | GET | Get single certificate detail | On demand |
| `/certificates/{id}/pdf` | GET | Download certificate PDF | On demand |
| `/properties/{uprn}` | GET | Get property certificates | On demand |

### Data Mapping

| Gas-Track Field | Fabric Field | Transformation |
|-----------------|--------------|----------------|
| `certificateId` | `CertificateID` | Direct |
| `uprn` | `UPRN` | Direct |
| `addressLine1` | `Address` | Concatenate address fields |
| `certificateDate` | `IssueDate` | Parse ISO date |
| `expiryDate` | `ExpiryDate` | Parse ISO date |
| `engineerName` | `EngineerName` | Direct |
| `gasSafeNumber` | `EngineerRegistration` | Direct |
| `result` | `Outcome` | Map: PASS/FAIL/AR |
| `pdfUrl` | `DocumentURL` | Store for retrieval |

---

## Keystone Integration

### Overview

Keystone manages Fire Risk Assessments and associated actions. As a legacy system with limited API capability, integration uses database read access.

### Connection Method

| Aspect | Details |
|--------|---------|
| **Method** | SQL Database Read |
| **Database** | SQL Server / Access (via linked server) |
| **Connection** | Site-to-Site VPN |
| **Authentication** | SQL Authentication |
| **Frequency** | Daily |

### Data Extraction

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    KEYSTONE DATA EXTRACTION                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  KEYSTONE DATABASE                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                                                                      │   │
│  │  ┌───────────────┐    ┌───────────────┐    ┌───────────────┐       │   │
│  │  │ tbl_FRA       │    │ tbl_Action    │    │ tbl_Building  │       │   │
│  │  │               │    │               │    │               │       │   │
│  │  │ - FRAID       │───▶│ - ActionID    │    │ - BuildingRef │       │   │
│  │  │ - BuildingRef │    │ - FRAID       │    │ - Address     │       │   │
│  │  │ - AssessDate  │    │ - Priority    │    │               │       │   │
│  │  │ - RiskRating  │    │ - DueDate     │    │               │       │   │
│  │  │ - Assessor    │    │ - Status      │    │               │       │   │
│  │  └───────────────┘    └───────────────┘    └───────────────┘       │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│            │                                                                 │
│            │    VPN                                                          │
│            ▼                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    AZURE DATA FACTORY                                │   │
│  │                                                                      │   │
│  │  Pipeline: pl-keystone-extract                                      │   │
│  │  ├── Copy Activity: FRA (Full - Daily)                              │   │
│  │  ├── Copy Activity: Action (Full - Daily)                           │   │
│  │  └── Data Quality: Validate BuildingRef exists in Northgate         │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│            │                                                                 │
│            ▼                                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  FABRIC LAKEHOUSE (BRONZE)                                           │   │
│  │                                                                      │   │
│  │  brz_keystone_fra              brz_keystone_action                  │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Data Quality Challenges

| Issue | Impact | Remediation |
|-------|--------|-------------|
| Inconsistent BuildingRef | Cannot link to Northgate | Manual mapping table |
| Missing dates | Incomplete FRA records | Default rules + flag |
| Duplicate FRAs | Double-counting | Deduplication logic |
| Open/Closed status misaligned | Incorrect action counts | Status normalisation |

---

## Promaster Integration

### Overview

Promaster manages asbestos surveys and ACM (Asbestos Containing Material) locations. As a modern SaaS system, integration uses REST API.

### Connection Method

| Aspect | Details |
|--------|---------|
| **Method** | REST API |
| **Authentication** | OAuth 2.0 (Client Credentials) |
| **Endpoint** | https://api.promaster.co.uk/v1 |
| **Frequency** | Daily |

### API Integration

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/surveys` | GET | Retrieve asbestos surveys |
| `/surveys/{id}/locations` | GET | Get ACM locations for survey |
| `/properties/{uprn}` | GET | Get property survey history |
| `/reports/{id}` | GET | Download survey report PDF |

### Data Mapping

| Promaster Field | Fabric Field | Notes |
|-----------------|--------------|-------|
| `surveyId` | `SurveyID` | Primary key |
| `uprn` | `UPRN` | Property link |
| `surveyDate` | `SurveyDate` | |
| `surveyType` | `SurveyType` | Management/Refurb/Demo |
| `acmPresent` | `ACMPresent` | Boolean |
| `riskRating` | `OverallRisk` | Low/Medium/High |
| `locations[]` | Separate table | One-to-many |

---

## Document Integration

### SharePoint Document Migration

Existing documents in SharePoint are migrated to the golden thread repository with metadata enrichment.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DOCUMENT MIGRATION FLOW                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  EXISTING SHAREPOINT              PROCESSING                   TARGET       │
│  (Unstructured)                                               SHAREPOINT    │
│                                                               (Structured)   │
│  ┌─────────────┐                                                            │
│  │ Gas Certs   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│  │ (5 folders) │─▶│   Azure     │─▶│  Document   │─▶│ Gas Safety  │       │
│  ├─────────────┤  │   Logic     │  │Intelligence │  │  Library    │       │
│  │ EICR Certs  │─▶│   App       │─▶│    (OCR)    │─▶│             │       │
│  ├─────────────┤  │             │  │             │  │ Metadata:   │       │
│  │ FRA Reports │─▶│ Migration   │─▶│  Extract:   │  │ - PropertyID│       │
│  ├─────────────┤  │   Flow      │  │ - Dates     │  │ - UPRN      │       │
│  │ Asbestos    │─▶│             │─▶│ - Names     │─▶│ - IssueDate │       │
│  ├─────────────┤  └─────────────┘  │ - Results   │  │ - ExpiryDate│       │
│  │ Building    │                   └─────────────┘  │ - Status    │       │
│  │ Plans       │                                    └─────────────┘       │
│  └─────────────┘                                                            │
│                                                                              │
│  Migration Priority:                                                         │
│  1. High-rise compliance docs (gas, EICR, FRA)                             │
│  2. Asbestos surveys and registers                                          │
│  3. Building plans and drawings                                             │
│  4. Historical photographs                                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### New Document Upload Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    NEW DOCUMENT UPLOAD FLOW                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SOURCE                 PROCESSING                       STORAGE             │
│                                                                              │
│  ┌─────────────┐       ┌─────────────────────────┐     ┌─────────────┐     │
│  │ Mobile App  │──────▶│                         │────▶│ SharePoint  │     │
│  │ (Photo)     │       │    Power Automate       │     │ (Documents) │     │
│  └─────────────┘       │                         │     └─────────────┘     │
│                        │  1. Receive file        │            │             │
│  ┌─────────────┐       │  2. Validate format     │            │             │
│  │ Portal      │──────▶│  3. Call Doc Intel      │            ▼             │
│  │ (Upload)    │       │  4. Extract metadata    │     ┌─────────────┐     │
│  └─────────────┘       │  5. Classify document   │────▶│   Fabric    │     │
│                        │  6. Apply metadata      │     │ (slv_document)│    │
│  ┌─────────────┐       │  7. Store in library    │     └─────────────┘     │
│  │ Contractor  │──────▶│  8. Index in AI Search  │            │             │
│  │ Portal      │       │  9. Link to entity      │            ▼             │
│  └─────────────┘       │                         │     ┌─────────────┐     │
│                        └─────────────────────────┘     │  AI Search  │     │
│                                                        │   Index     │     │
│                                                        └─────────────┘     │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Error Handling and Retry

### Retry Policies

| Integration | Retry Count | Interval | Backoff |
|-------------|-------------|----------|---------|
| Northgate DB | 3 | 5 mins | Exponential |
| Gas-Track API | 5 | 2 mins | Exponential |
| Promaster API | 5 | 2 mins | Exponential |
| Keystone DB | 3 | 5 mins | Exponential |
| Document Intelligence | 3 | 1 min | Fixed |

### Error Classification

| Error Type | Action | Notification |
|------------|--------|--------------|
| Transient (timeout, 429) | Retry with backoff | None (unless repeated) |
| Authentication failure | Alert immediately | Critical - IT Team |
| Data validation error | Log and continue | Warning - Data Team |
| Source system down | Pause and retry | Critical - IT Team |
| Transformation error | Log failed record | Warning - Data Team |

### Dead Letter Pattern

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ERROR HANDLING PATTERN                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐        ┌─────────────┐        ┌─────────────┐             │
│  │   Source    │───────▶│   Logic     │───────▶│   Fabric    │             │
│  │   System    │        │    App      │        │   Bronze    │             │
│  └─────────────┘        └──────┬──────┘        └─────────────┘             │
│                                │                                            │
│                          Error │                                            │
│                                ▼                                            │
│                        ┌─────────────┐                                      │
│                        │   Retry     │                                      │
│                        │   Logic     │                                      │
│                        └──────┬──────┘                                      │
│                               │                                             │
│               Success ◀───────┴───────▶ Max Retries                         │
│                                               │                             │
│                                               ▼                             │
│                                       ┌─────────────┐                       │
│                                       │ Dead Letter │                       │
│                                       │   Queue     │                       │
│                                       │ (Storage)   │                       │
│                                       └──────┬──────┘                       │
│                                              │                              │
│                                              ▼                              │
│                                       ┌─────────────┐                       │
│                                       │   Alert     │                       │
│                                       │  (Teams)    │                       │
│                                       └─────────────┘                       │
│                                                                              │
│  Dead letter records can be:                                                │
│  • Manually reviewed and fixed                                              │
│  • Replayed after source fix                                                │
│  • Excluded if invalid                                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Integration Monitoring

### Key Metrics

| Metric | Source | Alert Threshold |
|--------|--------|-----------------|
| Logic App Success Rate | Azure Monitor | <95% |
| Records Processed | Custom metric | >20% variance from average |
| Processing Latency | Logic App duration | >5 minutes |
| API Response Time | APIM Analytics | >2 seconds |
| Dead Letter Count | Storage Queue | >0 |

### Monitoring Dashboard

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  INTEGRATION MONITORING DASHBOARD                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SYNC STATUS (Last 24 Hours)                                                │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │  Northgate  │ │  Gas-Track  │ │  Keystone   │ │  Promaster  │           │
│  │     ✓       │ │     ✓       │ │     ✓       │ │     !       │           │
│  │ 02:15 today │ │ 11:00 today │ │ 05:30 today │ │ FAILED 04:00│           │
│  │ 28,000 recs │ │   450 recs  │ │ 3,500 recs  │ │ Retry 3/3   │           │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘           │
│                                                                              │
│  RECORDS PROCESSED (7 Days)                                                  │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ 30K ─┤                                                               │   │
│  │      │  ████                                                         │   │
│  │ 20K ─┤  ████  ████                                                   │   │
│  │      │  ████  ████  ████  ████  ████  ████  ████                     │   │
│  │ 10K ─┤  ████  ████  ████  ████  ████  ████  ████                     │   │
│  │      │  ████  ████  ████  ████  ████  ████  ████                     │   │
│  │   0 ─┼──Mon───Tue───Wed───Thu───Fri───Sat───Sun──                    │   │
│  │        Northgate  Gas-Track  Keystone  Promaster                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ERRORS (Last 7 Days)                                                        │
│  │ Type              │ Count │ Last Occurred │                              │
│  │───────────────────│───────│───────────────│                              │
│  │ Timeout           │   3   │ 2 days ago    │                              │
│  │ Authentication    │   0   │ Never         │                              │
│  │ Data Validation   │  12   │ Today         │ [View Details]               │
│  │ Source Unavailable│   1   │ 5 days ago    │                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Integration Schedule

### Daily Schedule

| Time | Integration | Type | Duration |
|------|-------------|------|----------|
| 02:00 | Northgate Property | Full | 30 mins |
| 03:00 | Northgate Tenancy | Incremental | 15 mins |
| 03:30 | Northgate Contact | Incremental | 15 mins |
| 04:00 | Promaster Surveys | Full | 20 mins |
| 05:00 | Keystone FRA | Full | 20 mins |
| 05:30 | Keystone Actions | Full | 15 mins |
| 06:00 | Bronze → Silver ETL | Transform | 45 mins |
| 07:00 | Silver → Gold ETL | Aggregate | 30 mins |
| 07:30 | Dataverse Sync | Incremental | 20 mins |
| 08:00 | AI Search Index | Incremental | 15 mins |

### Hourly Schedule

| Integration | Runs At |
|-------------|---------|
| Gas-Track Certificates | :00 (every hour) |
| Northgate Repairs | :30 (every hour, compliance-tagged) |

---

## Related Documents

- [Solution Overview](solution-overview.md) - Complete architecture design
- [Layer 3: Infrastructure](layer-3-infrastructure.md) - Foundation services
- [Layer 2: Intelligence](layer-2-intelligence.md) - Data platform receiving data
- [Security & Compliance](security-compliance.md) - Integration security controls

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
