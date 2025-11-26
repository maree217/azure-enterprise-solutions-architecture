# Deep Data Extraction

## Meridian Housing Group - Current State Data Analysis

*Extraction conducted using principles from the [Assessment Toolkit Extraction Scripts](../../../assessment-toolkit/extraction-scripts/), adapted for a greenfield Azure environment with existing M365 tenant.*

---

## Overview

Unlike organisations with existing Azure infrastructure, Meridian's data extraction focused on:
1. **M365 Tenant Analysis** - Understanding the existing Microsoft footprint
2. **Northgate HMS Review** - Assessing the core system's data and integration capabilities
3. **Compliance Systems Inventory** - Documenting each system's data export options
4. **Document Analysis** - Understanding the SharePoint document landscape

---

## M365 Tenant Analysis

### Entra ID (Azure AD) Assessment

| Metric | Value | Notes |
|--------|-------|-------|
| **Total Users** | 487 | 450 active, 37 disabled |
| **Licensed Users** | 450 | All M365 E3 |
| **Guest Users** | 23 | Contractors, partners |
| **Security Groups** | 45 | Basic departmental structure |
| **Dynamic Groups** | 0 | Not utilised |
| **Conditional Access Policies** | 0 | Default M365 only |
| **PIM Enabled** | No | No privileged access management |
| **MFA Enabled** | Partial | 65% of users (not enforced) |

**Key Finding:** Identity foundation needs strengthening before platform deployment.

### SharePoint Analysis

| Metric | Value | Notes |
|--------|-------|-------|
| **Total Sites** | 34 | Mix of team and communication sites |
| **Document Libraries** | 156 | Across all sites |
| **Total Documents** | ~450,000 | Mostly unstructured |
| **Storage Used** | 2.1 TB | No retention policies |
| **Compliance-Related Docs** | ~85,000 (estimated) | Certificates, FRAs, surveys |

**Document Distribution by Type (Estimated):**

| Document Type | Count | Location Quality |
|---------------|-------|------------------|
| Gas Certificates (CP12) | 28,000 | Scattered across 5 sites |
| Electrical Certificates (EICR) | 22,000 | Mostly in one folder |
| Fire Risk Assessments | 3,500 | Keystone + SharePoint |
| Asbestos Surveys | 8,000 | Promaster + SharePoint |
| Building Plans/Drawings | 12,000 | Various locations |
| Photographs | 45,000 | Untagged, no metadata |
| Other Compliance | 11,500 | Various |

**Key Finding:** Documents exist but lack metadata, consistent naming, or searchable structure. Golden thread will require document migration with proper classification.

### Power Platform Assessment

| Component | Current Usage | Potential |
|-----------|---------------|-----------|
| **Power Apps** | 0 apps | High - compliance forms, mobile |
| **Power Automate** | 3 basic flows | High - notifications, workflows |
| **Power BI** | 12 reports | High - compliance dashboards |
| **Power Pages** | Not used | High - resident portal |
| **Dataverse** | Not used | High - operational data store |
| **Copilot Studio** | Not used | Medium - compliance assistant |

**Key Finding:** Significant untapped potential in Power Platform licensing already included in M365 E3.

---

## Northgate HMS Analysis

### Database Assessment

| Aspect | Finding |
|--------|---------|
| **Database Type** | SQL Server 2019 |
| **Database Size** | 180 GB |
| **Table Count** | 1,200+ |
| **Core Entity Tables** | ~50 primary tables |
| **Historical Data** | 15+ years |
| **Backup Status** | Daily, retained 30 days |

### Key Entity Analysis

**Properties:**

| Attribute | Coverage | Quality | Notes |
|-----------|----------|---------|-------|
| Property Reference | 100% | Good | Internal unique ID |
| UPRN | 78% | Moderate | Missing for older stock |
| Address | 100% | Good | Full postal address |
| Property Type | 100% | Good | House, flat, maisonette, etc. |
| Build Date | 65% | Poor | Missing historical data |
| Building Reference | 85% | Moderate | High-rise identification |
| Floor/Level | 72% | Moderate | Not consistent |

**Key Finding:** UPRN coverage needs improvement. 22% of properties (6,160) lack UPRN, critical for golden thread.

**Tenancies:**

| Attribute | Coverage | Quality |
|-----------|----------|---------|
| Tenancy Reference | 100% | Good |
| Start Date | 100% | Good |
| Tenant Name | 100% | Good |
| Contact Details | 92% | Moderate |
| Email Address | 45% | Poor |
| Mobile Phone | 68% | Moderate |

**Key Finding:** Email coverage (45%) limits digital engagement capability. Mobile phone (68%) better for SMS.

### Integration Capability Assessment

| Integration Method | Available | Notes |
|--------------------|-----------|-------|
| REST API (NPS API) | Yes | Limited endpoints, read-mostly |
| Database Views | Yes | Read-only access possible |
| File Export | Yes | CSV, XML exports |
| Real-time Events | No | No event publishing |
| Webhook Support | No | Would need middleware |

**Recommended Integration Approach:**
1. **Read operations:** Database views (fastest, most complete)
2. **Write operations:** API where available, otherwise file-based
3. **Real-time:** Poll-based change detection or database CDC

---

## Compliance Systems Inventory

### Keystone (Fire Safety)

| Aspect | Details |
|--------|---------|
| **Vendor** | Keystone Software |
| **Version** | 8.2 |
| **Database** | SQL Server (separate instance) |
| **Records** | 3,500 FRAs, 15,000 actions |
| **Data Quality** | 2/5 - Inconsistent, gaps |

**Export Capabilities:**
- CSV export of assessments
- PDF report generation
- No API available
- Database read access possible but unsupported

**Integration Approach:** Database read with data quality transformation

### Promaster (Asbestos)

| Aspect | Details |
|--------|---------|
| **Vendor** | Promaster/Aspire |
| **Version** | Current SaaS |
| **Database** | Cloud-hosted SQL |
| **Records** | 8,000 surveys, 45,000 locations |
| **Data Quality** | 3/5 - Moderate |

**Export Capabilities:**
- REST API available (limited)
- CSV bulk export
- PDF reports

**Integration Approach:** API integration with scheduled sync

### Gas-Track

| Aspect | Details |
|--------|---------|
| **Vendor** | Gas-Track Ltd |
| **Version** | Cloud SaaS |
| **Records** | 28,000 certificates |
| **Data Quality** | 3/5 - Moderate |

**Export Capabilities:**
- REST API available
- Real-time certificate notifications
- Bulk CSV export

**Integration Approach:** API integration with real-time notifications

### EICR Management

| Aspect | Details |
|--------|---------|
| **System** | Excel spreadsheets |
| **Location** | Shared drive + SharePoint |
| **Records** | 22,000 certificates (estimated) |
| **Data Quality** | 2/5 - Poor, inconsistent |

**Export Capabilities:**
- Manual only
- No structured data source

**Integration Approach:** Migrate to platform, with document upload and OCR

### Other Systems

| System | Records | Export Method | Priority |
|--------|---------|---------------|----------|
| Lift Contractor Portal | 2,000 records | Manual portal access | Low |
| Legionella System | 1,500 assessments | File export | Medium |
| Water Hygiene | 3,000 records | CSV | Low |

---

## Data Quality Summary

### Entity-Level Quality Scores

| Entity | Completeness | Accuracy | Consistency | Timeliness | Overall |
|--------|--------------|----------|-------------|------------|---------|
| **Property** | 3/5 | 4/5 | 3/5 | 4/5 | 3.5/5 |
| **Building** | 2/5 | 3/5 | 2/5 | 3/5 | 2.5/5 |
| **Tenancy** | 4/5 | 4/5 | 4/5 | 5/5 | 4.25/5 |
| **Gas Certificate** | 3/5 | 4/5 | 3/5 | 4/5 | 3.5/5 |
| **FRA** | 2/5 | 3/5 | 2/5 | 2/5 | 2.25/5 |
| **EICR** | 2/5 | 2/5 | 1/5 | 2/5 | 1.75/5 |
| **Asbestos** | 3/5 | 3/5 | 3/5 | 3/5 | 3/5 |

### Critical Data Gaps

| Gap | Records Affected | Business Impact | Remediation |
|-----|------------------|-----------------|-------------|
| Missing UPRN | 6,160 properties | Cannot link to national register | UPRN lookup project |
| No building hierarchy | All high-rises | Cannot aggregate to building level | Data modelling exercise |
| Missing email | 55% of tenants | Limited digital engagement | Contact data enrichment |
| Incomplete FRAs | 15% of high-rises | Compliance risk | FRA programme |
| No document metadata | 450,000 documents | Cannot search golden thread | Document migration |

---

## Integration Points Summary

### Priority 1: Northgate (Core)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        NORTHGATE INTEGRATION                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐         ┌─────────────┐         ┌─────────────┐           │
│  │  Northgate  │ ──────▶ │    Azure    │ ──────▶ │   Fabric    │           │
│  │   SQL DB    │   DB    │    Data     │   ADF   │  Lakehouse  │           │
│  │             │   Read  │   Factory   │  Batch  │             │           │
│  └─────────────┘         └─────────────┘         └─────────────┘           │
│                                                                              │
│  Data Flow:                                                                  │
│  • Properties: Daily full sync (28,000 records)                             │
│  • Tenancies: Daily incremental (changes only)                              │
│  • Repairs: Hourly incremental (compliance-tagged only)                     │
│  • Contacts: Daily incremental                                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Priority 2: Compliance Systems

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    COMPLIANCE SYSTEM INTEGRATIONS                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌───────────┐    ┌───────────┐    ┌───────────┐    ┌───────────┐          │
│  │ Gas-Track │    │ Promaster │    │ Keystone  │    │   EICR    │          │
│  │   (API)   │    │   (API)   │    │   (DB)    │    │ (Manual)  │          │
│  └─────┬─────┘    └─────┬─────┘    └─────┬─────┘    └─────┬─────┘          │
│        │                │                │                │                 │
│        ▼                ▼                ▼                ▼                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    AZURE LOGIC APPS                                  │   │
│  │              (Transformation & Validation)                           │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                  │                                          │
│                                  ▼                                          │
│                    ┌─────────────────────────────────────┐                 │
│                    │         FABRIC LAKEHOUSE            │                 │
│                    │      (Bronze/Silver/Gold)           │                 │
│                    └─────────────────────────────────────┘                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Priority 3: Documents

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       DOCUMENT INTEGRATION                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌───────────────────┐                                                      │
│  │  SharePoint       │                                                      │
│  │  (Existing Docs)  │──────▶ Migration ──────▶ Golden Thread Repository   │
│  │  2TB, 450K docs   │         Project           (Structured SharePoint)    │
│  └───────────────────┘                                                      │
│                                                                              │
│  ┌───────────────────┐         ┌───────────────┐                           │
│  │  New Documents    │ ──────▶ │   Document    │ ──────▶ Metadata         │
│  │  (Upload Portal)  │         │  Intelligence │         Extraction        │
│  └───────────────────┘         └───────────────┘         (OCR + AI)        │
│                                                                              │
│  ┌───────────────────┐                                                      │
│  │  Azure AI Search  │ ◀────── Index ◀────── All Compliance Documents      │
│  │  (Golden Thread)  │                                                      │
│  └───────────────────┘                                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Extraction Outputs

### Data Volumes for Platform Sizing

| Data Type | Volume | Growth Rate | Retention |
|-----------|--------|-------------|-----------|
| Property Master | 28,000 records | 2%/year | Forever |
| Tenancy History | 150,000 records | 5%/year | 7 years |
| Gas Certificates | 28,000/year | Stable | 10 years |
| Electrical (EICR) | 5,600/year | Stable | 10 years |
| FRAs | 500/year | Growing | Forever |
| Asbestos Surveys | 1,000/year | Decreasing | Forever |
| Documents (new) | 50,000/year | Growing | Forever |

**Estimated Platform Data Size (5-year projection):** 500 GB structured data, 5 TB documents

### Infrastructure Requirements

Based on extraction analysis:

| Component | Sizing | Notes |
|-----------|--------|-------|
| **Fabric Capacity** | F16 | Sufficient for data volumes |
| **Azure AI Search** | Basic | Document volumes manageable |
| **Document Intelligence** | S0 | OCR processing needs |
| **Storage** | 10 TB | 5-year projection with headroom |
| **API Management** | Developer | Integration traffic volumes |

---

## Recommendations from Extraction

1. **UPRN Remediation Project** - Before platform go-live, address 6,160 properties missing UPRN
2. **Document Migration Strategy** - Cannot migrate all 450K documents; focus on high-rise compliance docs first
3. **Northgate DB Read Access** - Fastest, most reliable integration method; establish read replica
4. **Keystone Replacement Consideration** - Low quality system; consider replacing with platform capability
5. **Contact Data Enrichment** - 45% email coverage insufficient; run enrichment campaign

---

*Extraction Date: [Extraction Date]*
*Lead Analyst: [Analyst Name]*
*Document Classification: Internal Use Only*
