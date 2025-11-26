# Security & Compliance

## Meridian Housing Group - Security Architecture and Regulatory Mapping

*Security architecture aligned with UK housing sector requirements and the [Three-Layer Framework](../../../three-layer-overlay/README.md) security principles.*

---

## Overview

The Building Safety Platform handles sensitive personal data and safety-critical information. This document outlines the security architecture, regulatory compliance mapping, and audit requirements for the Building Safety Act 2022 and related legislation.

**Security Principles:**
- Zero Trust architecture
- Defence in depth
- Least privilege access
- Data protection by design
- Continuous monitoring and audit

---

## Regulatory Landscape

### Building Safety Act 2022

The Building Safety Act 2022 establishes the regulatory framework for building safety in England, with specific requirements for higher-risk buildings (18m+ or 7+ storeys).

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    BUILDING SAFETY ACT REQUIREMENTS                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  KEY DUTIES FOR ACCOUNTABLE PERSONS                                         │
│                                                                              │
│  1. BUILDING SAFETY CASE                                                    │
│     ├── Document building safety risks                                      │
│     ├── Describe safety measures in place                                   │
│     ├── Evidence ongoing management                                         │
│     └── Keep up to date (Golden Thread)                                    │
│                                                                              │
│  2. RESIDENT ENGAGEMENT                                                      │
│     ├── Establish Resident Engagement Strategy                              │
│     ├── Provide building safety information                                 │
│     ├── Operate complaints system                                           │
│     └── Consult on safety matters                                           │
│                                                                              │
│  3. GOLDEN THREAD                                                            │
│     ├── Maintain accurate building information                              │
│     ├── Keep information accessible                                         │
│     ├── Store in prescribed digital format                                  │
│     └── Update within 28 days of changes                                    │
│                                                                              │
│  4. MANDATORY OCCURRENCE REPORTING                                          │
│     ├── Report safety occurrences to BSR                                    │
│     ├── Within prescribed timescales                                        │
│     └── Maintain occurrence records                                         │
│                                                                              │
│  5. REGULATOR INFORMATION REQUESTS                                          │
│     ├── Respond to BSR information requests                                 │
│     ├── Within prescribed timescales                                        │
│     └── Provide accurate, complete information                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Platform Compliance Mapping

| BSA Requirement | Platform Capability | Evidence |
|-----------------|---------------------|----------|
| **Building Safety Case** | BSC module in staff portal | Digital BSC per building |
| **Golden Thread** | Fabric Lakehouse + SharePoint | Complete audit trail |
| **Resident Engagement** | Resident Safety Portal | Portal analytics, concern logs |
| **Mandatory Reporting** | Alert workflows | Incident records, timestamps |
| **Information Requests** | Compliance Copilot + exports | Response audit trail |
| **Competency Records** | Staff training records | Certificate storage |
| **Document Retention** | Managed retention policies | Retention reports |

---

## Data Protection

### UK GDPR Compliance

| Principle | Platform Implementation |
|-----------|-------------------------|
| **Lawfulness, fairness, transparency** | Privacy notices in portal, clear data use |
| **Purpose limitation** | Data used only for building safety purposes |
| **Data minimisation** | Only collect necessary compliance data |
| **Accuracy** | Data quality rules, regular cleansing |
| **Storage limitation** | Retention policies aligned to BSA requirements |
| **Integrity and confidentiality** | Encryption, access controls, audit logs |
| **Accountability** | DPO oversight, DPIA completed |

### Data Classification

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    DATA CLASSIFICATION SCHEME                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CONFIDENTIAL (Restricted)                                                   │
│  ├── Tenant personal data (names, contact details)                         │
│  ├── Vulnerability information                                              │
│  ├── Legal correspondence                                                   │
│  └── Security incident details                                              │
│                                                                              │
│  INTERNAL (Business Use)                                                     │
│  ├── Compliance certificates                                                │
│  ├── Fire Risk Assessments                                                  │
│  ├── Building Safety Cases                                                  │
│  ├── Action tracking data                                                   │
│  └── Staff operational data                                                 │
│                                                                              │
│  PUBLIC (Shareable)                                                          │
│  ├── Building addresses and descriptions                                    │
│  ├── General safety guidance                                                │
│  ├── Published compliance summaries (anonymised)                           │
│  └── Fire action plans                                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Personal Data Inventory

| Data Type | Source | Legal Basis | Retention |
|-----------|--------|-------------|-----------|
| Tenant names | Northgate | Contract | Tenancy + 6 years |
| Contact details | Northgate | Contract | Tenancy + 6 years |
| Vulnerability flags | Northgate | Vital interests | Active tenancy |
| Concern submissions | Portal | Legitimate interest | 7 years |
| Portal accounts | Entra B2C | Consent | Account lifetime |
| Inspection records | Mobile app | Legitimate interest | 10 years |

---

## Identity and Access Management

### Role-Based Access Control

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ACCESS CONTROL MATRIX                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ROLE                    │ BUILDINGS │ PROPERTIES │ PERSONAL │ ADMIN        │
│  ────────────────────────┼───────────┼────────────┼──────────┼─────────     │
│  BSP Administrator       │   Full    │    Full    │   Full   │  Full        │
│  Building Safety Manager │   Full    │    Full    │   View   │  None        │
│  Compliance Officer      │   View    │    Full    │   View   │  None        │
│  Housing Officer         │   View    │   Assigned │   View   │  None        │
│  Surveyor               │   View    │   Assigned │   None   │  None        │
│  Executive              │   View    │    View    │   None   │  View        │
│  Resident (Portal)      │ Own Bldg  │  Own Home  │   Own    │  None        │
│  Contractor (Portal)    │  Assigned │   Assigned │   None   │  None        │
│                                                                              │
│  LEGEND:                                                                     │
│  Full = Create, Read, Update, Delete                                        │
│  View = Read only                                                           │
│  Assigned = Only records assigned to user                                   │
│  Own = Only own personal data/building                                      │
│  None = No access                                                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Security Groups

| Group | Members | Purpose |
|-------|---------|---------|
| `SG-BSP-Administrators` | IT + BSP Lead | Full platform access |
| `SG-BSP-BuildingSafetyTeam` | 15 users | Building safety operations |
| `SG-BSP-ComplianceOfficers` | 30 users | Certificate management |
| `SG-BSP-HousingOfficers` | 80 users | Property-level view |
| `SG-BSP-Surveyors` | 25 users | Mobile app, inspections |
| `SG-BSP-Executives` | 10 users | Dashboard, reports only |
| `SG-BSP-ServiceAccounts` | 5 accounts | Integration identities |

### Privileged Access Management

| Privileged Role | Users | PIM Configuration |
|-----------------|-------|-------------------|
| Azure Subscription Owner | 2 | Eligible, 8-hour activation, approval required |
| Key Vault Administrator | 3 | Eligible, 4-hour activation, approval required |
| Power Platform Admin | 2 | Eligible, 8-hour activation, justification required |
| Fabric Workspace Admin | 3 | Eligible, 8-hour activation, justification required |

---

## Network Security

### Network Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    NETWORK SECURITY ARCHITECTURE                             │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  INTERNET                          AZURE                    ON-PREMISES      │
│                                                                              │
│  ┌─────────────┐                                                            │
│  │  Residents  │                                                            │
│  │  (Portal)   │─────▶ WAF ─────▶ Power Pages                              │
│  └─────────────┘       │                                                    │
│                        │                                                    │
│  ┌─────────────┐       │                                                    │
│  │ Contractors │───────┤                                                    │
│  │  (Portal)   │       │                                                    │
│  └─────────────┘       │                                                    │
│                        ▼                                                    │
│                   ┌─────────────────────────────────────────┐              │
│                   │           AZURE FRONT DOOR              │              │
│                   │  (DDoS Protection, SSL Termination)     │              │
│                   └────────────────┬────────────────────────┘              │
│                                    │                                        │
│  ┌─────────────┐                   │                                        │
│  │   Staff     │                   │                                        │
│  │(Power Apps) │───▶ Entra ID ────┬┘                                        │
│  └─────────────┘    (Cond Access) │                                         │
│                                    │                                         │
│                   ┌────────────────┴────────────────────────┐              │
│                   │              VNET                        │              │
│                   │  ┌─────────────────────────────────────┐│    VPN       │
│                   │  │ snet-integration                    ││◀────────────▶│
│                   │  │ (Logic Apps, APIM)                  ││              │
│                   │  │ NSG: Allow outbound to sources      ││   Northgate  │
│                   │  └─────────────────────────────────────┘│   Keystone   │
│                   │                                          │              │
│                   │  ┌─────────────────────────────────────┐│              │
│                   │  │ snet-privatelink                    ││              │
│                   │  │ (Private Endpoints)                 ││              │
│                   │  │ NSG: Deny all inbound from internet ││              │
│                   │  └─────────────────────────────────────┘│              │
│                   └─────────────────────────────────────────┘              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Network Security Controls

| Control | Implementation | Purpose |
|---------|----------------|---------|
| **DDoS Protection** | Azure DDoS Standard | Protect public endpoints |
| **WAF** | Azure Front Door WAF | OWASP protection |
| **NSG** | Per subnet | Traffic filtering |
| **Private Endpoints** | Fabric, Storage, Key Vault | No public access |
| **Service Endpoints** | Power Platform | Regional access only |
| **VPN Gateway** | Site-to-Site | On-premises connectivity |
| **Conditional Access** | Location + Device | Restrict admin access |

---

## Data Security

### Encryption

| Data State | Method | Key Management |
|------------|--------|----------------|
| **At Rest (Azure)** | AES-256 | Microsoft-managed |
| **At Rest (Fabric)** | AES-256 | Fabric-managed |
| **At Rest (SharePoint)** | BitLocker + per-file | Microsoft-managed |
| **In Transit** | TLS 1.3 | Azure-managed certificates |
| **In Transit (VPN)** | IPSec | Azure VPN Gateway |

### Data Loss Prevention

| Policy | Scope | Action |
|--------|-------|--------|
| Block external sharing | SharePoint compliance libraries | Block |
| Sensitive data detection | Documents with NI numbers | Alert + block |
| Email DLP | Outbound with tenant data | Warn + log |

### Backup and Recovery

| Component | Method | RPO | RTO | Retention |
|-----------|--------|-----|-----|-----------|
| Fabric Lakehouse | Built-in versioning | 1 hour | 4 hours | 30 days |
| SharePoint | M365 backup | 1 hour | 4 hours | 93 days |
| Dataverse | Built-in backup | 1 hour | 4 hours | 28 days |
| Key Vault | Soft delete | 0 | 4 hours | 90 days |

---

## Audit and Monitoring

### Audit Requirements

The Building Safety Act requires comprehensive audit trails for:

| Requirement | Platform Capability | Retention |
|-------------|---------------------|-----------|
| Document changes | SharePoint versioning + audit log | 7 years |
| Data access | Azure AD sign-in logs + Dataverse audit | 2 years |
| Compliance decisions | Dataverse audit trail | 7 years |
| Resident communications | Portal activity logs | 7 years |
| System changes | Azure Activity logs | 2 years |

### Audit Log Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    AUDIT LOG ARCHITECTURE                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SOURCE                         COLLECTION              STORAGE              │
│                                                                              │
│  ┌─────────────┐               ┌─────────────┐        ┌─────────────────┐  │
│  │ Azure AD    │──────────────▶│             │───────▶│                 │  │
│  │ Sign-in     │               │             │        │  LOG ANALYTICS  │  │
│  └─────────────┘               │             │        │   WORKSPACE     │  │
│                                │             │        │                 │  │
│  ┌─────────────┐               │   AZURE     │        │  Retention:     │  │
│  │ Azure       │──────────────▶│  MONITOR    │        │  90 days hot    │  │
│  │ Activity    │               │             │        │  2 years archive│  │
│  └─────────────┘               │             │        │                 │  │
│                                │             │        └────────┬────────┘  │
│  ┌─────────────┐               │             │                 │           │
│  │ Key Vault   │──────────────▶│             │                 │           │
│  │ Audit       │               └─────────────┘                 │           │
│  └─────────────┘                                               │           │
│                                                                ▼           │
│  ┌─────────────┐               ┌─────────────┐        ┌─────────────────┐  │
│  │ Dataverse   │──────────────▶│  DATAVERSE  │───────▶│  FABRIC         │  │
│  │ Audit       │               │   AUDIT     │        │  ARCHIVE        │  │
│  └─────────────┘               │   (NATIVE)  │        │  (7 years)      │  │
│                                └─────────────┘        └─────────────────┘  │
│                                                                              │
│  ┌─────────────┐               ┌─────────────┐                              │
│  │ SharePoint  │──────────────▶│  UNIFIED    │                              │
│  │ Audit       │               │  AUDIT LOG  │                              │
│  └─────────────┘               │  (M365)     │                              │
│                                └─────────────┘                              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Security Monitoring

| Monitor | Source | Alert Condition | Response |
|---------|--------|-----------------|----------|
| Failed logins | Azure AD | >10 failures in 10 mins | Auto-block + alert |
| Unusual access | Azure AD Identity Protection | Risk score high | MFA challenge |
| Bulk data export | Dataverse | >1000 records exported | Alert security team |
| Admin activity | Azure AD | Out-of-hours admin login | Alert + require justification |
| Key Vault access | Key Vault | Secret accessed from new IP | Alert security team |
| Privilege escalation | PIM | Activation request | Require approval |

---

## Incident Response

### Security Incident Categories

| Category | Example | Response Time | Escalation |
|----------|---------|---------------|------------|
| **Critical** | Data breach, system compromise | 15 minutes | IT Manager + DPO + Director |
| **High** | Suspected breach, authentication failure | 1 hour | IT Manager + Security |
| **Medium** | Unusual access pattern, policy violation | 4 hours | IT Team |
| **Low** | Failed login, minor policy alert | 24 hours | Log and review |

### Incident Response Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    INCIDENT RESPONSE WORKFLOW                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │   DETECT    │───▶│   ASSESS    │───▶│  CONTAIN    │───▶│  ERADICATE  │  │
│  │             │    │             │    │             │    │             │  │
│  │ • Alert     │    │ • Classify  │    │ • Isolate   │    │ • Remove    │  │
│  │ • Monitor   │    │ • Scope     │    │ • Block     │    │ • Patch     │  │
│  │ • Report    │    │ • Escalate  │    │ • Preserve  │    │ • Remediate │  │
│  └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘  │
│                                                                │             │
│                                                                ▼             │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐  │
│  │   CLOSE     │◀───│   REVIEW    │◀───│  RECOVER    │◀───┘             │  │
│  │             │    │             │    │             │                    │  │
│  │ • Document  │    │ • RCA       │    │ • Restore   │                    │  │
│  │ • Report    │    │ • Lessons   │    │ • Validate  │                    │  │
│  │ • Archive   │    │ • Improve   │    │ • Monitor   │                    │  │
│  └─────────────┘    └─────────────┘    └─────────────┘                    │  │
│                                                                              │
│  NOTIFICATION REQUIREMENTS:                                                  │
│  • ICO: Within 72 hours if personal data breach                            │
│  • BSR: If impacts building safety data/systems                            │
│  • Residents: If their data affected                                        │
│  • Board: All critical/high incidents                                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Compliance Certifications

### Platform Certifications

| Certification | Scope | Status |
|---------------|-------|--------|
| ISO 27001 | Azure, M365, Power Platform | Microsoft certified |
| SOC 2 Type II | Azure, M365 | Microsoft certified |
| Cyber Essentials Plus | Meridian organisation | Required annually |
| G-Cloud | Azure services | Listed |

### Compliance Assessments

| Assessment | Frequency | Owner | Last Completed |
|------------|-----------|-------|----------------|
| Penetration Test | Annual | External provider | [Date] |
| Vulnerability Scan | Monthly | IT Team | Automated |
| Access Review | Quarterly | IT Manager | [Date] |
| Data Protection Audit | Annual | DPO | [Date] |
| BSA Compliance Review | Annual | Building Safety Director | [Date] |

---

## Security Controls Summary

### Control Framework Mapping

| Control Area | NCSC CAF | ISO 27001 | Implementation |
|--------------|----------|-----------|----------------|
| Asset Management | A1 | A.8 | Asset inventory in CMDB |
| Identity & Access | B1, B2 | A.9 | Entra ID, RBAC, PIM |
| Data Security | B3 | A.8, A.10 | Encryption, DLP, classification |
| System Security | B4 | A.12 | Patching, hardening, monitoring |
| Network Security | B5 | A.13 | NSG, Private Endpoints, WAF |
| Operational Security | C1 | A.12 | Logging, monitoring, alerting |
| Incident Management | C2 | A.16 | Response procedures, testing |
| Business Continuity | D1 | A.17 | Backup, DR, testing |
| Supply Chain | E1 | A.15 | Vendor assessment, contracts |
| Personnel | E2 | A.7 | Training, awareness, vetting |

---

## Implementation Checklist

### Phase 1: Foundation (Weeks 1-4)

- [ ] Configure Entra ID security groups
- [ ] Implement Conditional Access policies
- [ ] Enable PIM for privileged roles
- [ ] Configure MFA for all users
- [ ] Deploy Key Vault with access policies

### Phase 2: Data Security (Weeks 5-8)

- [ ] Implement data classification
- [ ] Configure DLP policies
- [ ] Set up retention policies
- [ ] Enable audit logging
- [ ] Configure private endpoints

### Phase 3: Monitoring (Weeks 9-12)

- [ ] Deploy Log Analytics workspace
- [ ] Configure security alerts
- [ ] Set up incident response procedures
- [ ] Conduct penetration test
- [ ] Complete compliance documentation

---

## Related Documents

- [Solution Overview](solution-overview.md) - Complete architecture design
- [Layer 3: Infrastructure](layer-3-infrastructure.md) - Security infrastructure
- [Integration Patterns](integration-patterns.md) - Integration security
- [Layer 1: Experience](layer-1-experience.md) - Application security

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
*Security Classification: Internal Use Only*
