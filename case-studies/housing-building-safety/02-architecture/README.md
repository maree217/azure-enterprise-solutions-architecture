# Solution Architecture

## Meridian Housing Group - Building Safety Compliance Platform

*Architecture designed following the [Three-Layer Enterprise AI Framework](../../../three-layer-overlay/README.md).*

---

## Overview

The Building Safety Compliance Platform follows the Three-Layer Framework, building from infrastructure through intelligence to experience. This approach ensures:

1. **Secure Foundation** - Azure Landing Zone and integrations established first
2. **Data as Enabler** - Unified compliance data platform before user interfaces
3. **User-Centric Delivery** - Experiences built on solid data foundation
4. **Sustainable ROI** - Each layer delivers value and funds the next

---

## Architecture Documents

| Document | Purpose | Audience |
|----------|---------|----------|
| [Solution Overview](solution-overview.md) | Complete architecture and design decisions | All stakeholders |
| [Layer 3: Infrastructure](layer-3-infrastructure.md) | Foundation layer design | IT, Security |
| [Layer 2: Intelligence](layer-2-intelligence.md) | Data and analytics platform | Architects, Data teams |
| [Layer 1: Experience](layer-1-experience.md) | User-facing applications | Business, UX |
| [Integration Patterns](integration-patterns.md) | Northgate and system connectivity | Integration teams |
| [Security & Compliance](security-compliance.md) | Building Safety Act mapping | Compliance, Security |

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         BUILDING SAFETY PLATFORM                             │
│                      Three-Layer Architecture View                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  LAYER 1: EXPERIENCE                                              5-10x ROI │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌───────────┐ │
│  │ Building   │ │ Resident   │ │ Executive  │ │  Mobile    │ │ Compliance│ │
│  │ Safety     │ │ Safety     │ │ Dashboard  │ │ Surveyor   │ │  Copilot  │ │
│  │ Portal     │ │ Portal     │ │            │ │  App       │ │           │ │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘ └───────────┘ │
│  Power Apps     Power Pages     Power BI       Power Apps    Copilot Studio│
│                                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  LAYER 2: INTELLIGENCE                                             2-4x ROI │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    UNIFIED COMPLIANCE DATA PLATFORM                  │   │
│  │  ┌────────────┐    ┌────────────┐    ┌────────────┐                 │   │
│  │  │   GOLD     │ ◀──│  SILVER    │ ◀──│  BRONZE    │                 │   │
│  │  │ Analytics  │    │ Conformed  │    │  Raw Data  │                 │   │
│  │  └────────────┘    └────────────┘    └────────────┘                 │   │
│  │                    Microsoft Fabric Lakehouse                        │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐              │
│  │ Dataverse  │ │ AI Search  │ │  Document  │ │ Compliance │              │
│  │ (Ops Data) │ │ (RAG)      │ │ Intel (OCR)│ │ Analytics  │              │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘              │
│                                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  LAYER 3: INFRASTRUCTURE                                     30-50% savings │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐              │
│  │ Landing    │ │   API      │ │  Logic     │ │  Azure     │              │
│  │ Zone       │ │ Management │ │  Apps/ADF  │ │  Monitor   │              │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘              │
│                                                                              │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐                              │
│  │ Defender   │ │ Key Vault  │ │ Entra ID   │                              │
│  │ for Cloud  │ │            │ │            │                              │
│  └────────────┘ └────────────┘ └────────────┘                              │
│                                                                              │
├─────────────────────────────────────────────────────────────────────────────┤
│  SOURCE SYSTEMS                                                              │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐              │
│  │ Northgate  │ │ Keystone   │ │ Promaster  │ │ Gas-Track  │ + 4 more    │
│  │ (HMS)      │ │ (Fire)     │ │ (Asbestos) │ │ (Gas)      │              │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Key Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **Core HMS** | Keep Northgate | Property/tenancy master data, staff familiarity |
| **Data Platform** | Microsoft Fabric | Right-sized, integrated, Power Platform native |
| **Operational Store** | Dataverse | Power Apps integration, low-code ready |
| **User Experience** | Power Platform | Speed, citizen developer potential, M365 integration |
| **Document Search** | Azure AI Search | RAG capability for golden thread |
| **Integration** | Logic Apps + ADF | No-code integration, enterprise patterns |

---

## Technology Stack Summary

### Layer 1: Experience

| Component | Technology | Licence |
|-----------|------------|---------|
| Staff Portal | Power Apps (Model-Driven) | Per-user or capacity |
| Resident Portal | Power Pages | Capacity-based |
| Executive Dashboard | Power BI Premium | Per-user |
| Mobile App | Power Apps (Canvas) | Per-user |
| Compliance Copilot | Copilot Studio | Message-based |

### Layer 2: Intelligence

| Component | Technology | Licence |
|-----------|------------|---------|
| Data Platform | Microsoft Fabric | F16 capacity |
| Operational Data | Dataverse | Power Platform capacity |
| Search & RAG | Azure AI Search | Basic tier |
| Document OCR | Document Intelligence | S0 tier |
| AI Models | Azure OpenAI | Pay-per-use |

### Layer 3: Infrastructure

| Component | Technology | Licence |
|-----------|------------|---------|
| Integration | Azure Logic Apps | Consumption |
| Data Pipelines | Azure Data Factory | Pay-per-use |
| API Gateway | Azure API Management | Developer tier |
| Secrets | Azure Key Vault | Standard |
| Identity | Entra ID | M365 included |
| Security | Defender for Cloud | Included |
| Monitoring | Azure Monitor | Consumption |

---

## Build Sequence

```
Phase 1: FOUNDATION (Layer 3)         ───────────────────▶ 90 days
         Landing Zone, Security, Northgate Connect

Phase 2: INTELLIGENCE (Layer 2)       ───────────────────▶ 6-9 months
         Data Platform, Integrations, Analytics

Phase 3: EXPERIENCE (Layer 1)         ───────────────────▶ 6-9 months
         Portals, Dashboards, Mobile, Copilot

────────────────────────────────────────────────────────────────────────
                                                        Total: 18-24 months
```

---

## Cost Estimation

### Monthly Azure Costs (Steady State)

| Component | Monthly Cost | Notes |
|-----------|--------------|-------|
| Microsoft Fabric F16 | £1,800 | Data platform |
| Azure AI Search Basic | £60 | Document search |
| Document Intelligence S0 | £120 | OCR processing |
| Azure OpenAI | £200 | Copilot, analytics |
| Logic Apps | £150 | Integrations |
| API Management | £40 | Developer tier |
| Storage | £100 | Documents, backups |
| Monitoring | £80 | Log Analytics |
| **Total Azure** | **~£2,550/month** | **~£30,600/year** |

### Power Platform Licencing

| Component | Annual Cost | Notes |
|-----------|-------------|-------|
| Power Apps per-user (50) | £12,000 | Staff portal users |
| Power Pages (capacity) | £8,000 | Resident portal |
| Power BI Premium (25) | £3,600 | Executive users |
| Copilot Studio | £4,800 | Message allocation |
| **Total Power Platform** | **~£28,400/year** | |

### Total Annual Platform Cost

| Category | Annual Cost |
|----------|-------------|
| Azure consumption | £30,600 |
| Power Platform | £28,400 |
| Fabric capacity | Included in Azure |
| **Total** | **~£59,000/year** |

*Note: Implementation costs (£280K) are separate - see [Outcomes](../04-outcomes/README.md)*

---

## Next Steps

1. Review [Solution Overview](solution-overview.md) for complete technical architecture
2. Understand [Layer 3 Infrastructure](layer-3-infrastructure.md) foundation requirements
3. See [Integration Patterns](integration-patterns.md) for Northgate connectivity
4. Review [Security & Compliance](security-compliance.md) for Building Safety Act mapping

---

*Architecture Version: 1.0*
*Last Updated: [Date]*
