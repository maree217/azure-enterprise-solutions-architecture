# Layer 3: Infrastructure

## Meridian Housing Group - Foundation Architecture

*Infrastructure designed following the [Three-Layer Framework Layer 3 Principles](../../../three-layer-overlay/layer-3-infrastructure-foundation/README.md).*

---

## Overview

Layer 3 establishes the secure, governed foundation upon which the Building Safety Platform operates. This layer provides connectivity to source systems, security controls, and operational infrastructure.

**Key Outcomes:**
- Secure connectivity to Northgate and compliance systems
- Identity and access foundation
- Integration platform for data movement
- Monitoring and observability
- 30-50% infrastructure cost savings through cloud optimisation

---

## Azure Landing Zone

### Subscription Design

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     MERIDIAN AZURE LANDING ZONE                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  MANAGEMENT GROUP: Meridian-Housing                                         │
│  ├── Subscription: Meridian-Platform                                        │
│  │   ├── Resource Group: rg-bsp-prod-uks        (Production)               │
│  │   ├── Resource Group: rg-bsp-nonprod-uks     (Non-Production)           │
│  │   └── Resource Group: rg-shared-uks          (Shared Services)          │
│  │                                                                          │
│  └── Subscription: Meridian-Connectivity                                    │
│      └── Resource Group: rg-connectivity-uks    (Networking)               │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Resource Group Structure

| Resource Group | Purpose | Key Resources |
|----------------|---------|---------------|
| `rg-bsp-prod-uks` | Production workloads | Logic Apps, APIM, Key Vault |
| `rg-bsp-nonprod-uks` | Dev/Test environments | Non-prod instances |
| `rg-shared-uks` | Shared services | Log Analytics, Automation |
| `rg-connectivity-uks` | Network infrastructure | VNet, Private Endpoints |

### Naming Convention

All resources follow the pattern: `{resource-type}-{workload}-{environment}-{region}`

| Resource Type | Example | Notes |
|---------------|---------|-------|
| Resource Group | rg-bsp-prod-uks | UK South region |
| Logic App | logic-northgate-sync-prod-uks | Northgate integration |
| Key Vault | kv-bsp-prod-uks | Secrets management |
| Storage Account | stbspproduk | No hyphens, lowercase |

---

## Network Architecture

### Connectivity Design

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         NETWORK ARCHITECTURE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  MERIDIAN ON-PREMISES                    AZURE                              │
│  ┌──────────────────────┐               ┌────────────────────────────────┐  │
│  │  Corporate Network   │               │  VNet: vnet-bsp-prod-uks       │  │
│  │                      │               │  Address: 10.100.0.0/16        │  │
│  │  ┌────────────────┐  │               │                                │  │
│  │  │   Northgate    │  │  ExpressRoute │  ┌─────────────────────────┐   │  │
│  │  │   SQL Server   │──┼───────────────┼──│ snet-integration        │   │  │
│  │  │                │  │  or VPN       │  │ 10.100.1.0/24           │   │  │
│  │  └────────────────┘  │               │  │ Logic Apps, APIM        │   │  │
│  │                      │               │  └─────────────────────────┘   │  │
│  │  ┌────────────────┐  │               │                                │  │
│  │  │   Keystone     │  │               │  ┌─────────────────────────┐   │  │
│  │  │   Server       │──┼───────────────┼──│ snet-privatelink        │   │  │
│  │  │                │  │               │  │ 10.100.2.0/24           │   │  │
│  │  └────────────────┘  │               │  │ Private Endpoints       │   │  │
│  │                      │               │  └─────────────────────────┘   │  │
│  └──────────────────────┘               │                                │  │
│                                         │  ┌─────────────────────────┐   │  │
│  CLOUD SAAS                             │  │ snet-fabric             │   │  │
│  ┌──────────────────────┐               │  │ 10.100.3.0/24           │   │  │
│  │  Gas-Track API       │───────────────┼──│ Fabric Gateway          │   │  │
│  │  Promaster API       │  Internet     │  └─────────────────────────┘   │  │
│  └──────────────────────┘               │                                │  │
│                                         └────────────────────────────────┘  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Connectivity Options

| Connection Type | Source | Destination | Method |
|-----------------|--------|-------------|--------|
| Northgate DB | On-premises | Azure | Site-to-Site VPN / ExpressRoute |
| Keystone DB | On-premises | Azure | Site-to-Site VPN / ExpressRoute |
| Gas-Track API | Azure | SaaS | Internet (APIM managed) |
| Promaster API | Azure | SaaS | Internet (APIM managed) |
| Microsoft Fabric | Azure | PaaS | Private Endpoint |
| Power Platform | Azure | PaaS | Service Endpoint |

### Network Security

| Control | Implementation | Notes |
|---------|----------------|-------|
| NSG | Applied to all subnets | Deny all by default |
| Private Endpoints | Fabric, Storage, Key Vault | No public access |
| Service Endpoints | Power Platform services | Regional access |
| Firewall Rules | IP allowlist for SaaS | Gas-Track, Promaster |

---

## Identity and Access

### Entra ID Configuration

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         IDENTITY ARCHITECTURE                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ENTRA ID TENANT: meridianhousing.onmicrosoft.com                           │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    SECURITY GROUPS                                   │   │
│  │  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐             │   │
│  │  │ SG-BSP-Admin  │ │ SG-BSP-Users  │ │ SG-BSP-Viewers│             │   │
│  │  │ (5 members)   │ │ (50 members)  │ │ (200 members) │             │   │
│  │  └───────────────┘ └───────────────┘ └───────────────┘             │   │
│  │                                                                      │   │
│  │  ┌───────────────┐ ┌───────────────┐ ┌───────────────┐             │   │
│  │  │SG-Surveyors   │ │SG-HousingOfficer│ │SG-Executive │             │   │
│  │  │ (25 members)  │ │ (80 members)  │ │ (10 members)  │             │   │
│  │  └───────────────┘ └───────────────┘ └───────────────┘             │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                  CONDITIONAL ACCESS POLICIES                         │   │
│  │  • CA-001: Require MFA for all users                                │   │
│  │  • CA-002: Block legacy authentication                               │   │
│  │  • CA-003: Require compliant device for admin access                 │   │
│  │  • CA-004: Named locations (UK only for admin)                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                  PRIVILEGED IDENTITY MANAGEMENT                      │   │
│  │  • Azure Subscription Owner - PIM eligible (2 users)                │   │
│  │  • Key Vault Admin - PIM eligible (3 users)                         │   │
│  │  • Power Platform Admin - PIM eligible (2 users)                    │   │
│  │  • All activations require justification + approval                 │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Role Assignments

| Role | Scope | Group | Purpose |
|------|-------|-------|---------|
| Contributor | rg-bsp-prod-uks | SG-BSP-Admin | Manage production resources |
| Reader | rg-bsp-prod-uks | SG-BSP-Users | View production resources |
| Logic App Contributor | rg-bsp-prod-uks | SG-BSP-Admin | Manage integrations |
| Key Vault Secrets User | kv-bsp-prod-uks | Logic Apps MI | Access secrets |

### Service Principals and Managed Identities

| Identity | Type | Purpose | Permissions |
|----------|------|---------|-------------|
| sp-northgate-sync | Service Principal | Northgate connection | SQL Read access |
| mi-logic-northgate | Managed Identity | Logic App identity | Key Vault, Storage |
| mi-adf-pipeline | Managed Identity | Data Factory identity | Fabric, Storage |
| mi-apim | Managed Identity | API Management | Key Vault secrets |

---

## Integration Platform

### Azure API Management

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    API MANAGEMENT ARCHITECTURE                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  APIM Instance: apim-bsp-prod-uks (Developer Tier)                          │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         API PRODUCTS                                 │   │
│  │                                                                      │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐     │   │
│  │  │ Internal APIs   │  │ External APIs   │  │ Partner APIs    │     │   │
│  │  │ (Staff apps)    │  │ (Resident)      │  │ (Contractors)   │     │   │
│  │  │ Rate: 1000/min  │  │ Rate: 100/min   │  │ Rate: 500/min   │     │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         API ENDPOINTS                                │   │
│  │                                                                      │   │
│  │  /api/buildings/{id}              GET building details               │   │
│  │  /api/buildings/{id}/compliance   GET compliance status              │   │
│  │  /api/certificates                GET/POST certificates              │   │
│  │  /api/fra/{id}                    GET fire risk assessment           │   │
│  │  /api/residents/{id}/safety       GET resident safety info           │   │
│  │                                                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Logic Apps Integration Flows

| Logic App | Trigger | Source | Destination | Schedule |
|-----------|---------|--------|-------------|----------|
| `logic-northgate-property-sync` | Recurrence | Northgate DB | Fabric Bronze | Daily 02:00 |
| `logic-northgate-tenancy-sync` | Recurrence | Northgate DB | Fabric Bronze | Daily 03:00 |
| `logic-gastrack-sync` | Recurrence | Gas-Track API | Fabric Bronze | Hourly |
| `logic-promaster-sync` | Recurrence | Promaster API | Fabric Bronze | Daily 04:00 |
| `logic-keystone-export` | Recurrence | Keystone File | Fabric Bronze | Daily 05:00 |
| `logic-certificate-alert` | Event | Dataverse | Email/Teams | Real-time |

### Azure Data Factory Pipelines

| Pipeline | Purpose | Source | Destination | Schedule |
|----------|---------|--------|-------------|----------|
| `pl-bronze-to-silver` | Data cleansing | Bronze layer | Silver layer | After ingestion |
| `pl-silver-to-gold` | Aggregation | Silver layer | Gold layer | Daily 06:00 |
| `pl-dataverse-sync` | Operational data | Gold layer | Dataverse | Hourly |
| `pl-search-index` | Search updates | Gold layer | AI Search | Daily 07:00 |

---

## Security Infrastructure

### Key Vault Configuration

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    KEY VAULT: kv-bsp-prod-uks                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  SECRETS                                                                     │
│  ├── NorthgateDbConnectionString      (SQL connection string)               │
│  ├── KeystoneDbConnectionString       (SQL connection string)               │
│  ├── GasTrackApiKey                   (API authentication)                  │
│  ├── PromasterApiKey                  (API authentication)                  │
│  ├── FabricConnectionString           (Lakehouse connection)                │
│  └── StorageAccountKey                (Blob storage)                        │
│                                                                              │
│  CERTIFICATES                                                                │
│  ├── ApimGatewayCert                  (APIM SSL)                            │
│  └── ServiceBusCert                   (Service Bus auth)                    │
│                                                                              │
│  ACCESS POLICIES                                                             │
│  ├── mi-logic-northgate    → Get Secrets                                    │
│  ├── mi-adf-pipeline       → Get Secrets                                    │
│  ├── mi-apim               → Get Secrets, Get Certificates                  │
│  └── SG-BSP-Admin          → All (via PIM activation)                       │
│                                                                              │
│  CONFIGURATION                                                               │
│  ├── Soft Delete: Enabled (90 days)                                         │
│  ├── Purge Protection: Enabled                                              │
│  ├── Network: Private Endpoint only                                         │
│  └── Logging: Enabled to Log Analytics                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Microsoft Defender for Cloud

| Feature | Configuration | Notes |
|---------|---------------|-------|
| Defender CSPM | Enabled | Cloud security posture |
| Defender for Storage | Enabled | Blob threat detection |
| Defender for Key Vault | Enabled | Secret access monitoring |
| Secure Score | Target: 80%+ | Weekly review |
| Regulatory Compliance | UK NCSC, ISO 27001 | Compliance tracking |

### Logging and Audit

| Log Type | Destination | Retention |
|----------|-------------|-----------|
| Activity Logs | Log Analytics | 90 days |
| Diagnostic Logs | Log Analytics | 90 days |
| Key Vault Audit | Log Analytics | 1 year |
| APIM Analytics | Log Analytics | 90 days |
| Logic App Runs | Log Analytics | 90 days |

---

## Monitoring and Observability

### Azure Monitor Configuration

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MONITORING ARCHITECTURE                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  LOG ANALYTICS WORKSPACE: log-bsp-prod-uks                                  │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      DATA SOURCES                                    │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐   │   │
│  │  │ Logic Apps  │ │    APIM     │ │  Key Vault  │ │   Storage   │   │   │
│  │  │  Run Logs   │ │  Analytics  │ │   Audits    │ │   Metrics   │   │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘   │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      ALERT RULES                                     │   │
│  │  • Integration Failure: Logic App run failed                        │   │
│  │  • API Latency: APIM response > 5s                                  │   │
│  │  • Secret Access: Unusual Key Vault access pattern                  │   │
│  │  • Storage Anomaly: Unexpected data volume change                   │   │
│  │  • Cost Alert: Daily spend > £100                                   │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      ACTION GROUPS                                   │   │
│  │  • AG-Critical: IT Team email + Teams + PagerDuty                   │   │
│  │  • AG-Warning: IT Team email + Teams                                │   │
│  │  • AG-Info: Teams channel only                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Metrics and Dashboards

| Dashboard | Audience | Key Metrics |
|-----------|----------|-------------|
| Infrastructure Health | IT Team | Logic App success rate, API latency, errors |
| Integration Status | Data Team | Records processed, sync status, failures |
| Security Posture | Security Team | Secure Score, threat alerts, access anomalies |
| Cost Management | Finance | Daily spend, forecast, budget variance |

### Alert Configuration

| Alert | Condition | Severity | Action |
|-------|-----------|----------|--------|
| Northgate Sync Failed | Logic App failed | Critical | AG-Critical |
| API Gateway Error Rate | >5% errors in 5 mins | Warning | AG-Warning |
| Key Vault Access Denied | >10 denials in 1 hour | Warning | AG-Warning |
| Unexpected Secret Access | Access from new IP | Critical | AG-Critical |
| Budget Threshold | >80% monthly budget | Warning | AG-Info |

---

## Disaster Recovery

### Recovery Objectives

| Metric | Target | Notes |
|--------|--------|-------|
| RPO (Recovery Point Objective) | 1 hour | Data loss tolerance |
| RTO (Recovery Time Objective) | 4 hours | Recovery time |
| DR Region | UK West | Paired region |

### Backup Configuration

| Component | Backup Method | Frequency | Retention |
|-----------|---------------|-----------|-----------|
| Key Vault | Built-in soft delete | Continuous | 90 days |
| Logic Apps | ARM template export | Daily | 30 days |
| APIM | Automated backup | Daily | 30 days |
| Fabric Data | Lakehouse versioning | Continuous | 30 days |
| Storage Blobs | GRS replication | Continuous | 30 days |

### DR Procedures

1. **Logic Apps**: Redeploy from ARM templates in UK West
2. **APIM**: Restore from backup to secondary instance
3. **Key Vault**: Soft delete recovery or restore from backup
4. **Data**: Fabric automatic failover to secondary region

---

## Cost Management

### Monthly Cost Breakdown

| Component | SKU/Tier | Monthly Cost | Notes |
|-----------|----------|--------------|-------|
| Logic Apps | Consumption | £150 | ~50,000 runs/month |
| API Management | Developer | £40 | 1M calls included |
| Key Vault | Standard | £5 | Secret operations |
| Storage | Standard GRS | £100 | 2TB capacity |
| Log Analytics | Pay-as-you-go | £80 | 50GB/month |
| VPN Gateway | VpnGw1 | £120 | Site-to-site |
| **Total Layer 3** | | **~£495/month** | |

### Cost Optimisation Measures

| Measure | Savings | Implementation |
|---------|---------|----------------|
| Reserved capacity (VPN) | 30% | 1-year reservation |
| Logic Apps batching | 20% | Reduce connector calls |
| Log retention policy | 15% | Archive to cold storage |
| Right-size monitoring | 10% | Reduce metric frequency |

---

## Implementation Checklist

### Phase 1: Foundation (Weeks 1-4)

- [ ] Create Azure subscriptions and management groups
- [ ] Deploy Landing Zone with resource groups
- [ ] Configure Entra ID security groups
- [ ] Implement Conditional Access policies
- [ ] Enable PIM for privileged roles

### Phase 2: Connectivity (Weeks 5-8)

- [ ] Deploy VNet and subnets
- [ ] Configure Site-to-Site VPN to on-premises
- [ ] Test Northgate DB connectivity
- [ ] Test Keystone DB connectivity
- [ ] Configure Private Endpoints

### Phase 3: Integration Platform (Weeks 9-12)

- [ ] Deploy Key Vault with secrets
- [ ] Deploy API Management
- [ ] Create Logic Apps for data sync
- [ ] Configure Azure Data Factory
- [ ] Test end-to-end data flow

### Phase 4: Security and Monitoring (Weeks 11-12)

- [ ] Enable Microsoft Defender for Cloud
- [ ] Configure Log Analytics workspace
- [ ] Create alert rules
- [ ] Deploy monitoring dashboards
- [ ] Document DR procedures

---

## Related Documents

- [Solution Overview](solution-overview.md) - Complete architecture design
- [Layer 2: Intelligence](layer-2-intelligence.md) - Data platform design
- [Integration Patterns](integration-patterns.md) - Detailed integration specifications
- [Security & Compliance](security-compliance.md) - Security controls mapping

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
