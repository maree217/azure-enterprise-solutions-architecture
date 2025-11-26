# Phase 2: Intelligence

## Meridian Housing Group - Data Platform Delivery

*Layer 2 implementation building the unified compliance data platform.*

---

## Overview

Phase 2 builds the data platform that unifies compliance data from all source systems. This phase delivers the first user-visible value: executive dashboards with complete compliance visibility.

**Duration:** 24 weeks (Q3-Q4 2024)
**Team:** Data Engineer, Integration Developer, BI Developer, Architect

---

## Sprint Breakdown

### Sprint 7-8: Fabric Foundation (Weeks 1-4)

**Objective:** Establish Microsoft Fabric Lakehouse

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Provision Fabric workspace | Data Engineer | 1 day | M365 admin |
| Create Lakehouse | Data Engineer | 1 day | Workspace |
| Design Bronze schema | Data Engineer | 3 days | Architecture |
| Create Bronze tables (Northgate) | Data Engineer | 2 days | Schema |
| Create Bronze tables (compliance) | Data Engineer | 2 days | Schema |
| Configure workspace security | Data Engineer | 1 day | Security groups |
| Test data write from Storage | Data Engineer | 2 days | Phase 1 |

**Deliverables:**
- Fabric workspace operational
- Lakehouse with Bronze tables
- Security configured

**Exit Criteria:**
- [ ] Data can be written to Bronze tables
- [ ] Only authorised users can access workspace
- [ ] Schema documented

---

### Sprint 9-10: Northgate Integration (Weeks 5-8)

**Objective:** Full Northgate data flowing to Lakehouse

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Enhance Northgate views (full scope) | IT/Vendor | 5 days | Vendor coordination |
| Create ADF pipeline - Property | Integration Dev | 2 days | Views |
| Create ADF pipeline - Tenancy | Integration Dev | 2 days | Views |
| Create ADF pipeline - Contact | Integration Dev | 2 days | Views |
| Create ADF pipeline - Repair | Integration Dev | 2 days | Views |
| Schedule pipelines | Integration Dev | 1 day | Pipelines |
| Validate data completeness | Data Engineer | 3 days | Data landed |

**Deliverables:**
- Complete Northgate data in Bronze
- Scheduled daily refresh
- Data validation report

**Exit Criteria:**
- [ ] 28,000 properties in Bronze
- [ ] Daily incremental working
- [ ] <1% data variance from source

---

### Sprint 11-12: Compliance System Integration (Weeks 9-12)

**Objective:** Gas-Track and Keystone data integrated

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Gas-Track API integration | Integration Dev | 3 days | API key |
| Create Logic App - Gas-Track | Integration Dev | 2 days | API access |
| Test Gas-Track sync | Integration Dev | 2 days | Logic App |
| Keystone DB read access | IT/Vendor | 3 days | Vendor |
| Create ADF pipeline - Keystone | Integration Dev | 3 days | DB access |
| Test Keystone sync | Integration Dev | 2 days | Pipeline |
| Create Bronze tables (Gas, FRA) | Data Engineer | 2 days | Data flowing |

**Deliverables:**
- Gas-Track certificates in Bronze (hourly)
- Keystone FRAs and actions in Bronze (daily)
- Monitoring for both integrations

**Exit Criteria:**
- [ ] 28,000 gas certificates landed
- [ ] 3,500 FRAs landed
- [ ] Sync status visible in monitoring

---

### Sprint 13-14: Silver Layer (Weeks 13-16)

**Objective:** Cleansed, conformed data layer

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design Silver schema | Data Engineer | 3 days | Architecture |
| Create Silver tables | Data Engineer | 2 days | Schema |
| Build transformation - Building | Data Engineer | 3 days | Bronze data |
| Build transformation - Property | Data Engineer | 2 days | Bronze data |
| Build transformation - Certificate | Data Engineer | 3 days | Bronze data |
| Build transformation - FRA | Data Engineer | 2 days | Bronze data |
| Implement data quality rules | Data Engineer | 3 days | Transformations |
| Schedule Silver refresh | Data Engineer | 1 day | Transformations |

**Deliverables:**
- Unified Building master (47 buildings)
- Unified Property master (28,000 properties)
- Unified Certificate table (all types)
- Unified FRA table with actions
- Data quality dashboard

**Exit Criteria:**
- [ ] All Bronze data transforms to Silver
- [ ] Data quality score >95%
- [ ] Building-to-property relationships complete

---

### Sprint 15-16: Gold Layer and Analytics (Weeks 17-20)

**Objective:** Business-ready analytics layer

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design Gold schema | Data Engineer | 2 days | Architecture |
| Create aggregation - Compliance Status | Data Engineer | 2 days | Silver |
| Create aggregation - Building Safety Case | Data Engineer | 2 days | Silver |
| Create aggregation - Executive KPIs | Data Engineer | 2 days | Silver |
| Build Power BI semantic model | BI Developer | 3 days | Gold tables |
| Create Executive Dashboard | BI Developer | 5 days | Semantic model |
| Dashboard UAT | BI Developer | 3 days | Dashboard |

**Deliverables:**
- Gold layer aggregations
- Power BI semantic model
- Executive compliance dashboard

**Exit Criteria:**
- [ ] Dashboard shows all 47 buildings
- [ ] Compliance percentages accurate
- [ ] Executive approval

---

### Sprint 17-18: Document Platform (Weeks 21-24)

**Objective:** Golden thread document repository

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design SharePoint structure | Architect | 2 days | Architecture |
| Create document libraries | Architect | 1 day | Design |
| Configure metadata columns | Architect | 2 days | Libraries |
| Create Document Intelligence models | Data Engineer | 5 days | Training data |
| Build document upload flow | Integration Dev | 3 days | Libraries, DI |
| Test OCR pipeline | Data Engineer | 3 days | Flow complete |
| Migrate priority documents (1,000) | Data Engineer | 4 days | Pipeline |

**Deliverables:**
- SharePoint golden thread structure
- Document Intelligence custom models
- Automated metadata extraction
- Initial document migration

**Exit Criteria:**
- [ ] 1,000 high-priority docs migrated
- [ ] OCR accuracy >95%
- [ ] Documents searchable with metadata

---

### Sprint 19-20: AI Search Integration (Weeks 25-26)

**Objective:** Unified search across golden thread

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Deploy Azure AI Search | Data Engineer | 1 day | Infrastructure |
| Create search index | Data Engineer | 2 days | Documents |
| Configure semantic search | Data Engineer | 2 days | Index |
| Build search UI component | Developer | 3 days | Index |
| Test search scenarios | Data Engineer | 2 days | UI |
| Optimize relevance | Data Engineer | 2 days | Testing |

**Deliverables:**
- AI Search index of all documents
- Semantic search capability
- Search UI component for portal

**Exit Criteria:**
- [ ] Search returns relevant results
- [ ] Semantic queries work ("fire safety actions Tower 3")
- [ ] Response time <2 seconds

---

### Sprint 21-22: Dataverse and Sync (Weeks 27-28)

**Objective:** Operational data store for Power Apps

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Create Dataverse environment | Architect | 1 day | Power Platform |
| Design Dataverse schema | Architect | 2 days | Architecture |
| Create Dataverse tables | Developer | 2 days | Schema |
| Build Fabric to Dataverse sync | Integration Dev | 3 days | Tables |
| Test data sync | Integration Dev | 2 days | Sync |
| Configure security roles | Architect | 2 days | Tables |

**Deliverables:**
- Dataverse environment with tables
- Automated sync from Fabric Gold
- Security roles configured

**Exit Criteria:**
- [ ] Dataverse reflects Gold data within 1 hour
- [ ] Role-based security working
- [ ] Data accessible from Power Apps

---

### Sprint 23-24: Phase 2 UAT and Go-Live (Weeks 29-30)

**Objective:** Validate and launch Phase 2 deliverables

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Prepare UAT scenarios | BA | 2 days | All above |
| Conduct UAT (dashboards) | Business | 3 days | Scenarios |
| Address UAT findings | Team | 3 days | UAT |
| Performance testing | Data Engineer | 2 days | UAT complete |
| Go-live preparation | PM | 2 days | All above |
| Go-live (dashboards) | Team | 1 day | Preparation |
| Post go-live support | Team | 3 days | Go-live |

**Deliverables:**
- UAT sign-off
- Performance test results
- Go-live checklist complete
- Executive dashboard live

**Exit Criteria:**
- [ ] UAT signed off by business
- [ ] Dashboard performance acceptable
- [ ] Executive team trained
- [ ] Support handover complete

---

## Data Quality Framework

### Quality Rules Implemented

| Rule ID | Entity | Rule | Action |
|---------|--------|------|--------|
| DQ001 | Property | UPRN not null | Flag, report |
| DQ002 | Property | Valid postcode format | Flag, report |
| DQ003 | Building | Has at least 1 property | Reject |
| DQ004 | Certificate | Expiry > Issue date | Reject |
| DQ005 | Certificate | Valid date range | Flag |
| DQ006 | FRA | Building exists | Reject orphan |
| DQ007 | Contact | Valid email format | Flag |

### Quality Targets

| Dimension | Target | Measurement |
|-----------|--------|-------------|
| Completeness | >95% | Non-null critical fields |
| Accuracy | >98% | Validated against source |
| Timeliness | <1 hour | Time since source change |
| Uniqueness | >99% | Duplicate detection |
| Validity | >98% | Business rule compliance |

---

## Phase 2 Acceptance

### Technical Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| All integrations operational | Integration Dev | Monitoring dashboard |
| Data quality targets met | Data Engineer | DQ dashboard |
| Dashboard performance | BI Developer | Load test results |
| Document search functional | Data Engineer | Test scenarios |

### Business Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| Dashboard accurate | Marcus Williams | Comparison to spreadsheets |
| Executive approval | Sarah Chen | Sign-off |
| Search returns right docs | Compliance team | UAT |

---

## Handover to Phase 3

| Item | Owner | Recipient |
|------|-------|-----------|
| Dataverse documentation | Architect | Power Platform Dev |
| Semantic model | BI Developer | Power Platform Dev |
| Search component | Developer | Power Platform Dev |
| Data dictionary | Data Engineer | BA |

---

*Phase 2 Specification Version: 1.0*
*Last Updated: [Date]*
