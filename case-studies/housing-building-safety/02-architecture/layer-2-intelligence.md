# Layer 2: Intelligence

## Meridian Housing Group - Data Platform Architecture

*Intelligence layer designed following the [Three-Layer Framework Layer 2 Principles](../../../three-layer-overlay/layer-2-organisational-intelligence/README.md).*

---

## Overview

Layer 2 transforms raw data from source systems into actionable intelligence. This layer houses the unified compliance data platform, analytics capabilities, and AI services that power the Building Safety Platform.

**Key Outcomes:**
- Single source of truth for all compliance data
- Golden thread document repository
- Predictive compliance analytics
- 2-4x ROI through data-driven decision making

---

## Data Platform Architecture

### Microsoft Fabric Lakehouse

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MICROSOFT FABRIC LAKEHOUSE                                │
│                    Capacity: F16 (UK South)                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         BRONZE LAYER                                 │   │
│  │                     (Raw Data - As Received)                         │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │   │
│  │  │  Northgate  │ │   Keystone  │ │  Gas-Track  │ │  Promaster  │   │   │
│  │  │  Raw Tables │ │   Raw FRA   │ │Raw Certs    │ │ Raw Surveys │   │   │
│  │  │  (Daily)    │ │  (Daily)    │ │  (Hourly)   │ │  (Daily)    │   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐                   │   │
│  │  │    EICR     │ │   Lift      │ │  Legionella │                   │   │
│  │  │  Raw Data   │ │  Records    │ │ Raw Assess  │                   │   │
│  │  │  (Manual)   │ │  (Weekly)   │ │  (Monthly)  │                   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘                   │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                  │                                          │
│                                  ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         SILVER LAYER                                 │   │
│  │                   (Cleansed, Conformed Data)                         │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │   │
│  │  │  Buildings  │ │ Properties  │ │ Certificates│ │    FRAs     │   │   │
│  │  │   Master    │ │   Master    │ │  Unified    │ │  Unified    │   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │   │
│  │  │   Actions   │ │  Contacts   │ │  Documents  │ │   Events    │   │   │
│  │  │   Unified   │ │  Unified    │ │  Metadata   │ │  Timeline   │   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                  │                                          │
│                                  ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                          GOLD LAYER                                  │   │
│  │                  (Business-Ready Analytics)                          │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │   │
│  │  │  Building   │ │ Compliance  │ │  Executive  │ │  Resident   │   │   │
│  │  │   Safety    │ │  Status     │ │   Summary   │ │   Safety    │   │   │
│  │  │   Cases     │ │  Dashboard  │ │   Metrics   │ │   View      │   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │   │
│  │                                                                      │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐                   │   │
│  │  │ Predictive  │ │   Action    │ │  Regulator  │                   │   │
│  │  │  Analytics  │ │  Tracking   │ │  Reporting  │                   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘                   │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Lakehouse Tables

#### Bronze Layer (Raw)

| Table | Source | Refresh | Volume | Key Fields |
|-------|--------|---------|--------|------------|
| `brz_northgate_property` | Northgate DB | Daily | 28,000 | PropertyID, UPRN, Address |
| `brz_northgate_tenancy` | Northgate DB | Daily | 35,000 | TenancyID, PropertyID |
| `brz_northgate_contact` | Northgate DB | Daily | 50,000 | ContactID, TenancyID |
| `brz_keystone_fra` | Keystone DB | Daily | 3,500 | FRAID, PropertyRef |
| `brz_keystone_action` | Keystone DB | Daily | 15,000 | ActionID, FRAID |
| `brz_gastrack_certificate` | Gas-Track API | Hourly | 28,000 | CertID, UPRN |
| `brz_promaster_survey` | Promaster API | Daily | 8,000 | SurveyID, PropertyRef |
| `brz_promaster_location` | Promaster API | Daily | 45,000 | LocationID, SurveyID |
| `brz_eicr_certificate` | Manual upload | Weekly | 22,000 | CertRef, Address |

#### Silver Layer (Conformed)

| Table | Description | Key | Relationships |
|-------|-------------|-----|---------------|
| `slv_building` | Building master data | BuildingID | → Properties |
| `slv_property` | Property master data | PropertyID | → Building, Tenancies |
| `slv_tenancy` | Tenancy records | TenancyID | → Property, Contacts |
| `slv_contact` | Contact information | ContactID | → Tenancy |
| `slv_certificate_gas` | Gas certificates | CertificateID | → Property |
| `slv_certificate_electrical` | EICR certificates | CertificateID | → Property |
| `slv_fra` | Fire risk assessments | FRAID | → Building |
| `slv_fra_action` | FRA actions | ActionID | → FRA |
| `slv_asbestos_survey` | Asbestos surveys | SurveyID | → Property |
| `slv_asbestos_location` | Asbestos locations | LocationID | → Survey |
| `slv_document` | Document metadata | DocumentID | → Property/Building |
| `slv_event` | Compliance events | EventID | → Property/Building |

#### Gold Layer (Analytics)

| Table/View | Purpose | Refresh | Consumers |
|------------|---------|---------|-----------|
| `gld_building_safety_case` | Complete BSC data | Daily | Power BI, Portal |
| `gld_compliance_status` | Current compliance | Hourly | Dashboard, Alerts |
| `gld_certificate_expiry` | Upcoming expiries | Daily | Alerts, Reports |
| `gld_fra_action_summary` | FRA action tracking | Daily | Dashboard, Portal |
| `gld_executive_kpi` | Executive metrics | Daily | Power BI |
| `gld_resident_safety` | Resident-facing data | Daily | Resident Portal |
| `gld_regulator_report` | BSR reporting | On-demand | Regulator |
| `gld_predictive_risk` | Risk predictions | Weekly | Analytics |

---

## Data Model

### Entity Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         UNIFIED DATA MODEL                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                           ┌─────────────────┐                               │
│                           │    BUILDING     │                               │
│                           │  (Golden Thread │                               │
│                           │     Anchor)     │                               │
│                           └────────┬────────┘                               │
│                                    │                                         │
│          ┌─────────────────────────┼─────────────────────────┐              │
│          │                         │                         │              │
│          ▼                         ▼                         ▼              │
│  ┌───────────────┐        ┌───────────────┐        ┌───────────────┐       │
│  │   PROPERTY    │        │  FIRE RISK    │        │   BUILDING    │       │
│  │               │        │  ASSESSMENT   │        │  SAFETY CASE  │       │
│  └───────┬───────┘        └───────┬───────┘        └───────────────┘       │
│          │                        │                                          │
│          ▼                        ▼                                          │
│  ┌───────────────┐        ┌───────────────┐                                 │
│  │   TENANCY     │        │  FRA ACTION   │                                 │
│  └───────┬───────┘        └───────────────┘                                 │
│          │                                                                   │
│          ▼                                                                   │
│  ┌───────────────┐                                                          │
│  │   CONTACT     │                                                          │
│  └───────────────┘                                                          │
│                                                                              │
│  PROPERTY has many:                                                          │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │ GAS CERT    │ │ EICR CERT   │ │ ASBESTOS    │ │  DOCUMENT   │           │
│  │ (CP12)      │ │             │ │ SURVEY      │ │             │           │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Entities

#### Building (Golden Thread Anchor)

```
Building
├── BuildingID (PK)
├── BuildingName
├── Address
├── Postcode
├── UPRN
├── LocalAuthority
├── BuildingHeight (m)
├── NumberOfStoreys
├── NumberOfUnits
├── BuildDate
├── BuildingUse (Residential, Mixed)
├── HighRiseFlag (18m+)
├── HigherRiskFlag (7+ storeys)
├── AccountablePerson
├── PrincipalAccountablePerson
├── BSRRegistrationNumber
├── BSRRegistrationDate
├── BuildingSafetyCaseStatus
├── OverallComplianceStatus
├── LastAssessmentDate
└── NextAssessmentDue
```

#### Property

```
Property
├── PropertyID (PK)
├── BuildingID (FK)
├── PropertyReference
├── UPRN
├── UnitNumber
├── Floor
├── Address
├── PropertyType
├── Bedrooms
├── CurrentTenancyID (FK)
├── GasSupply (Yes/No)
├── ElectricalMeterType
├── HeatingType
├── ComplianceStatus
└── LastInspectionDate
```

#### Certificate (Gas/Electrical)

```
Certificate
├── CertificateID (PK)
├── PropertyID (FK)
├── CertificateType (Gas, EICR)
├── CertificateNumber
├── IssueDate
├── ExpiryDate
├── Status (Valid, Expiring, Expired)
├── EngineerName
├── EngineerRegistration
├── Outcome (Pass, Fail, Advisory)
├── DocumentID (FK)
├── SourceSystem
└── SyncDate
```

#### Fire Risk Assessment

```
FireRiskAssessment
├── FRAID (PK)
├── BuildingID (FK)
├── AssessmentDate
├── AssessorName
├── AssessorCompany
├── RiskRating (Low, Medium, High)
├── NextReviewDate
├── DocumentID (FK)
├── TotalActions
├── OpenActions
├── OverdueActions
├── Status (Current, Review Due, Overdue)
└── SyncDate
```

---

## Dataverse (Operational Data Store)

### Purpose

Dataverse serves as the operational data store, enabling:
- Real-time transactional operations from Power Apps
- Workflow automation via Power Automate
- Direct integration with Power Platform

### Dataverse Tables

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         DATAVERSE SCHEMA                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │  bsp_building   │  │  bsp_property   │  │ bsp_certificate │             │
│  │  (Read from     │  │  (Read from     │  │  (Read/Write)   │             │
│  │   Fabric)       │  │   Fabric)       │  │                 │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │    bsp_fra      │  │  bsp_action     │  │  bsp_inspection │             │
│  │  (Read/Write)   │  │  (Read/Write)   │  │  (Read/Write)   │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │  bsp_document   │  │   bsp_alert     │  │  bsp_workorder  │             │
│  │  (Read/Write)   │  │  (System Gen)   │  │  (Read/Write)   │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
│                                                                              │
│  ┌─────────────────┐  ┌─────────────────┐                                   │
│  │ bsp_residentqry │  │ bsp_auditlog    │                                   │
│  │  (Read/Write)   │  │  (System Gen)   │                                   │
│  └─────────────────┘  └─────────────────┘                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Data Synchronisation

| Direction | Method | Frequency | Notes |
|-----------|--------|-----------|-------|
| Fabric → Dataverse | ADF Pipeline | Hourly | Read-only reference data |
| Dataverse → Fabric | Dataverse Link | Near real-time | Operational changes |
| Dataverse → Northgate | Logic App | On event | Work order writeback |

---

## Document Intelligence

### Golden Thread Document Repository

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DOCUMENT MANAGEMENT ARCHITECTURE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  DOCUMENT SOURCES                                                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │  Existing   │ │   Mobile    │ │  Contractor │ │   Scanned   │           │
│  │  SharePoint │ │    App      │ │   Upload    │ │  Documents  │           │
│  │  (Migration)│ │  (Photos)   │ │  (Portal)   │ │             │           │
│  └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ └──────┬──────┘           │
│         │               │               │               │                    │
│         └───────────────┴───────────────┴───────────────┘                    │
│                                  │                                           │
│                                  ▼                                           │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                    DOCUMENT PROCESSING PIPELINE                        │  │
│  │                                                                        │  │
│  │  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐               │  │
│  │  │   Upload    │───▶│  Document   │───▶│  Metadata   │               │  │
│  │  │  Validation │    │Intelligence │    │  Extraction │               │  │
│  │  │             │    │    (OCR)    │    │    (AI)     │               │  │
│  │  └─────────────┘    └─────────────┘    └─────────────┘               │  │
│  │                                               │                        │  │
│  │                                               ▼                        │  │
│  │                                    ┌─────────────────┐                │  │
│  │                                    │   Classification│                │  │
│  │                                    │   & Tagging     │                │  │
│  │                                    └─────────────────┘                │  │
│  │                                                                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                  │                                           │
│                                  ▼                                           │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                  GOLDEN THREAD DOCUMENT STORE                          │  │
│  │                   (SharePoint with Metadata)                           │  │
│  │                                                                        │  │
│  │  Site: Building Safety Compliance                                      │  │
│  │  ├── Library: Gas Certificates                                        │  │
│  │  │   ├── Metadata: PropertyID, UPRN, IssueDate, ExpiryDate           │  │
│  │  ├── Library: Electrical Certificates                                 │  │
│  │  │   ├── Metadata: PropertyID, UPRN, IssueDate, ExpiryDate           │  │
│  │  ├── Library: Fire Risk Assessments                                   │  │
│  │  │   ├── Metadata: BuildingID, AssessmentDate, RiskRating            │  │
│  │  ├── Library: Asbestos Surveys                                        │  │
│  │  │   ├── Metadata: PropertyID, SurveyDate, ACMPresent                │  │
│  │  ├── Library: Building Plans                                          │  │
│  │  │   ├── Metadata: BuildingID, PlanType, Version                     │  │
│  │  └── Library: Photographs                                             │  │
│  │      ├── Metadata: PropertyID, DateTaken, Category                   │  │
│  │                                                                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                  │                                           │
│                                  ▼                                           │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │                      AZURE AI SEARCH INDEX                             │  │
│  │                                                                        │  │
│  │  Index: bsp-documents-index                                           │  │
│  │  • Full-text search across all documents                              │  │
│  │  • Semantic search for natural language queries                       │  │
│  │  • Faceted filtering by type, date, building                         │  │
│  │  • RAG integration for Compliance Copilot                            │  │
│  │                                                                        │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Azure AI Document Intelligence

| Model | Use Case | Output |
|-------|----------|--------|
| Prebuilt-document | General documents | Text, tables, key-value pairs |
| Custom model: CP12 | Gas certificates | Engineer, Date, Outcome, Address |
| Custom model: EICR | Electrical certs | Inspector, Date, Results, Address |
| Custom model: FRA | Fire assessments | Risk rating, Actions, Dates |

### Document Classification

| Category | Document Types | Retention | Access Level |
|----------|----------------|-----------|--------------|
| Gas Safety | CP12 certificates | 10 years | Staff |
| Electrical Safety | EICR certificates | 10 years | Staff |
| Fire Safety | FRAs, action plans | Forever | Staff |
| Asbestos | Surveys, registers | Forever | Staff |
| Building Records | Plans, drawings | Forever | Staff |
| Resident Communication | Letters, notices | 7 years | Limited |
| Photographs | Inspection photos | 10 years | Staff |

---

## Azure AI Search

### Search Index Configuration

```json
{
  "name": "bsp-documents-index",
  "fields": [
    {"name": "id", "type": "Edm.String", "key": true},
    {"name": "content", "type": "Edm.String", "searchable": true},
    {"name": "documentType", "type": "Edm.String", "filterable": true, "facetable": true},
    {"name": "buildingId", "type": "Edm.String", "filterable": true},
    {"name": "propertyId", "type": "Edm.String", "filterable": true},
    {"name": "uprn", "type": "Edm.String", "filterable": true},
    {"name": "documentDate", "type": "Edm.DateTimeOffset", "filterable": true, "sortable": true},
    {"name": "expiryDate", "type": "Edm.DateTimeOffset", "filterable": true},
    {"name": "status", "type": "Edm.String", "filterable": true, "facetable": true},
    {"name": "tags", "type": "Collection(Edm.String)", "filterable": true, "facetable": true},
    {"name": "contentVector", "type": "Collection(Edm.Single)", "searchable": true, "dimensions": 1536}
  ],
  "semantic": {
    "configurations": [{
      "name": "bsp-semantic-config",
      "prioritizedFields": {
        "contentFields": [{"fieldName": "content"}],
        "titleField": {"fieldName": "documentType"}
      }
    }]
  }
}
```

### Search Use Cases

| Use Case | Query Type | Example |
|----------|------------|---------|
| Find certificate | Keyword + filter | "gas certificate UPRN:100012345678" |
| Building documents | Filter | documentType:FRA AND buildingId:B001 |
| Expiring certificates | Filter + sort | expiryDate lt 2024-06-01 |
| Natural language | Semantic | "fire risk assessment recommendations for Tower 3" |
| Copilot RAG | Vector + semantic | "what are the outstanding fire safety actions" |

---

## AI and Analytics Services

### Azure OpenAI Integration

| Model | Purpose | Use Case |
|-------|---------|----------|
| GPT-4 | Document analysis | Extract insights from FRAs |
| GPT-4 | Copilot responses | Natural language compliance queries |
| text-embedding-ada-002 | Vector search | Document similarity, RAG |

### Compliance Analytics

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      ANALYTICS CAPABILITIES                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  DESCRIPTIVE ANALYTICS                                                       │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  • Current compliance status by building/type                        │   │
│  │  • Certificate coverage and gaps                                     │   │
│  │  • FRA action completion rates                                       │   │
│  │  • Historical trends and patterns                                    │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  DIAGNOSTIC ANALYTICS                                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  • Root cause analysis for compliance failures                       │   │
│  │  • Contractor performance comparison                                 │   │
│  │  • Building-level risk factors                                       │   │
│  │  • Process bottleneck identification                                 │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  PREDICTIVE ANALYTICS                                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  • Certificate expiry forecasting                                    │   │
│  │  • Access failure prediction (gas, EICR)                            │   │
│  │  • FRA action overdue probability                                    │   │
│  │  • Resource demand forecasting                                       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  PRESCRIPTIVE ANALYTICS                                                      │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │  • Optimal inspection scheduling                                     │   │
│  │  • Risk-based prioritisation recommendations                         │   │
│  │  • Resource allocation optimisation                                  │   │
│  │  • Contractor workload balancing                                     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Data Quality Framework

### Quality Rules

| Rule | Entity | Check | Action |
|------|--------|-------|--------|
| DQ001 | Property | UPRN format valid | Flag invalid |
| DQ002 | Certificate | Expiry date > Issue date | Reject |
| DQ003 | Building | Has at least one property | Alert |
| DQ004 | FRA | Building exists | Reject orphan |
| DQ005 | Contact | Email format valid | Flag invalid |
| DQ006 | Certificate | No duplicate cert numbers | Alert |

### Data Quality Monitoring

| Metric | Target | Frequency | Alert Threshold |
|--------|--------|-----------|-----------------|
| Completeness | >95% | Daily | <90% |
| Accuracy | >98% | Daily | <95% |
| Timeliness | <1 hour lag | Hourly | >4 hours |
| Uniqueness | >99% | Daily | <98% |
| Validity | >98% | Daily | <95% |

---

## Implementation Checklist

### Phase 1: Data Foundation (Weeks 1-4)

- [ ] Provision Microsoft Fabric workspace
- [ ] Create Bronze layer tables
- [ ] Configure data ingestion pipelines
- [ ] Set up Northgate data sync
- [ ] Test data landing in Bronze

### Phase 2: Data Transformation (Weeks 5-8)

- [ ] Create Silver layer tables
- [ ] Implement data quality rules
- [ ] Build transformation pipelines
- [ ] Create unified entity views
- [ ] Validate data quality metrics

### Phase 3: Analytics Layer (Weeks 9-12)

- [ ] Create Gold layer aggregations
- [ ] Build Dataverse sync
- [ ] Configure AI Search index
- [ ] Deploy Document Intelligence
- [ ] Test end-to-end data flow

### Phase 4: AI Integration (Weeks 13-16)

- [ ] Configure Azure OpenAI
- [ ] Train custom document models
- [ ] Implement RAG pipeline
- [ ] Build predictive models
- [ ] Deploy analytics dashboards

---

## Related Documents

- [Solution Overview](solution-overview.md) - Complete architecture design
- [Layer 3: Infrastructure](layer-3-infrastructure.md) - Foundation services
- [Layer 1: Experience](layer-1-experience.md) - User applications
- [Integration Patterns](integration-patterns.md) - Data flow specifications

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
