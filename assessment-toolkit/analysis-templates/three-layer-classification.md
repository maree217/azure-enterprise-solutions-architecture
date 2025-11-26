# Three-Layer Framework Resource Classification Guide

Map Azure resources to the Three-Layer Enterprise AI Architecture for strategic analysis.

---

## Classification Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    THREE-LAYER RESOURCE CLASSIFICATION                       │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ LAYER 1: END USER EXPERIENCE                                      (BUILD LAST) │
│ Purpose: Where users interact with AI capabilities                           │
├─────────────────────────────────────────────────────────────────────────────┤
│ • Power Apps / Power Pages          • Bot Services / Copilot Studio         │
│ • App Service (user-facing)         • Static Web Apps                       │
│ • Logic Apps (user workflows)       • Azure Front Door (user endpoints)     │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ LAYER 2: ORGANIZATIONAL INTELLIGENCE                          (BUILD SECOND) │
│ Purpose: Where data becomes actionable intelligence                          │
├─────────────────────────────────────────────────────────────────────────────┤
│ • Azure Synapse / Databricks        • Azure AI Search                       │
│ • Azure OpenAI                      • Data Factory                          │
│ • Microsoft Purview                 • Azure ML                              │
│ • Event Hubs / Stream Analytics     • Azure AI Services                     │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│ LAYER 3: INFRASTRUCTURE & OPERATIONS                          (BUILD FIRST) │
│ Purpose: Foundation that enables everything above                            │
├─────────────────────────────────────────────────────────────────────────────┤
│ • Virtual Networks / Subnets        • AKS / Container Apps                  │
│ • Storage Accounts                  • Key Vault                             │
│ • Azure Monitor / Log Analytics     • Azure Firewall / NSGs                 │
│ • Azure Policy / Blueprints         • Microsoft Defender                    │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Resource Type to Layer Mapping

### Layer 1: End User Experience

| Resource Type | Azure Service | Purpose | Classification Notes |
|---------------|---------------|---------|---------------------|
| `microsoft.web/sites` | App Service | User-facing web apps | Only if user-facing, not API backends |
| `microsoft.web/staticsites` | Static Web Apps | Frontend hosting | React/Angular/Vue frontends |
| `microsoft.powerapps/accounts` | Power Apps | Low-code apps | Business user interfaces |
| `microsoft.botservice/botservices` | Bot Service | Conversational AI | User chatbots |
| `microsoft.logic/workflows` | Logic Apps | User workflows | Only user-triggered flows |
| `microsoft.cdn/profiles` | Front Door/CDN | Edge delivery | User content delivery |

**Assessment Questions for Layer 1:**
- [ ] How do end users currently interact with data/AI?
- [ ] What is the user adoption rate?
- [ ] Are there accessibility requirements?
- [ ] What is the mobile strategy?

---

### Layer 2: Organizational Intelligence

| Resource Type | Azure Service | Purpose | Classification Notes |
|---------------|---------------|---------|---------------------|
| `microsoft.synapse/workspaces` | Synapse Analytics | Data warehousing | Core data platform |
| `microsoft.databricks/workspaces` | Databricks | Data engineering/ML | Analytics processing |
| `microsoft.cognitiveservices/accounts` | Azure OpenAI | Gen AI capabilities | LLM services |
| `microsoft.search/searchservices` | AI Search | Knowledge retrieval | RAG implementation |
| `microsoft.datafactory/factories` | Data Factory | ETL/ELT | Data pipelines |
| `microsoft.purview/accounts` | Microsoft Purview | Data governance | Catalog & lineage |
| `microsoft.machinelearningservices/workspaces` | Azure ML | Custom ML models | MLOps platform |
| `microsoft.eventhub/namespaces` | Event Hubs | Real-time ingestion | Streaming data |
| `microsoft.streamanalytics/streamingjobs` | Stream Analytics | Real-time processing | Streaming analytics |
| `microsoft.documentdb/databaseaccounts` | Cosmos DB | Operational data | If used for analytics |
| `microsoft.kusto/clusters` | Data Explorer | Log analytics | Time series analytics |

**Assessment Questions for Layer 2:**
- [ ] What is the data architecture (medallion, mesh)?
- [ ] Is there a centralized data catalog?
- [ ] What AI/ML capabilities exist?
- [ ] How is data quality managed?

---

### Layer 3: Infrastructure & Operations

| Resource Type | Azure Service | Purpose | Classification Notes |
|---------------|---------------|---------|---------------------|
| `microsoft.network/virtualnetworks` | Virtual Network | Network foundation | Core networking |
| `microsoft.network/networksecuritygroups` | NSG | Network security | Micro-segmentation |
| `microsoft.network/azurefirewalls` | Azure Firewall | Perimeter security | Traffic control |
| `microsoft.compute/virtualmachines` | Virtual Machines | Compute | Legacy or specialized |
| `microsoft.containerservice/managedclusters` | AKS | Container orchestration | Modern workloads |
| `microsoft.app/containerapps` | Container Apps | Serverless containers | Microservices |
| `microsoft.storage/storageaccounts` | Storage | Data storage | Foundation storage |
| `microsoft.keyvault/vaults` | Key Vault | Secret management | Security foundation |
| `microsoft.operationalinsights/workspaces` | Log Analytics | Observability | Monitoring foundation |
| `microsoft.insights/components` | Application Insights | APM | Application monitoring |
| `microsoft.security/assessments` | Defender | Security posture | Security monitoring |
| `microsoft.authorization/policyassignments` | Azure Policy | Governance | Compliance |

**Assessment Questions for Layer 3:**
- [ ] Is there a landing zone pattern?
- [ ] How is networking architected?
- [ ] What is the security posture score?
- [ ] Is infrastructure as code used?

---

## Governance (Cross-Cutting)

_Resources that span all layers_

| Resource Type | Azure Service | Purpose | Spans Layers |
|---------------|---------------|---------|--------------|
| `microsoft.authorization/roleassignments` | RBAC | Access control | All |
| `microsoft.authorization/policyassignments` | Azure Policy | Compliance | All |
| `microsoft.security/pricings` | Defender Plans | Security | All |
| `microsoft.managedidentity/userassignedidentities` | Managed Identity | Identity | All |
| `microsoft.operationalinsights/workspaces` | Log Analytics | Logging | All |
| `microsoft.costmanagement/exports` | Cost Management | FinOps | All |

---

## Classification Worksheet

Use this worksheet to classify extracted resources:

### Step 1: Resource Inventory Summary

| Layer | Resource Count | % of Total | Key Resource Types |
|-------|---------------|------------|-------------------|
| Layer 1 (UX) | | | |
| Layer 2 (Intelligence) | | | |
| Layer 3 (Infrastructure) | | | |
| Governance | | | |
| **Total** | | 100% | |

### Step 2: Layer Completeness Assessment

| Layer | Expected Components | Present | Missing | Score |
|-------|--------------------:|---------|---------|-------|
| **Layer 1** | | | | /5 |
| - User Interface | Power Apps / Web App | | | |
| - Conversational AI | Bot Service / Copilot | | | |
| - Edge Delivery | CDN / Front Door | | | |
| **Layer 2** | | | | /5 |
| - Data Platform | Synapse / Databricks | | | |
| - AI Capabilities | Azure OpenAI | | | |
| - Search/Retrieval | AI Search | | | |
| - Data Integration | Data Factory | | | |
| **Layer 3** | | | | /5 |
| - Networking | VNet / Hub-Spoke | | | |
| - Compute | AKS / VMs | | | |
| - Security | Firewall / NSGs | | | |
| - Observability | Monitor / Log Analytics | | | |

### Step 3: Integration Assessment

| Integration Point | Status | Notes |
|-------------------|--------|-------|
| Layer 3 → Layer 2 connectivity | | |
| Layer 2 → Layer 1 connectivity | | |
| Security across layers | | |
| Monitoring across layers | | |
| Identity across layers | | |

---

## Visual Classification Template

```
┌───────────────────────────────────────────────────────────────┐
│                     CLIENT: _________________                  │
│                     DATE: ___________________                  │
└───────────────────────────────────────────────────────────────┘

LAYER 1: END USER EXPERIENCE
┌───────────────────────────────────────────────────────────────┐
│ Resources: ________                                            │
│ Status: ○ Not Present  ○ Partial  ○ Complete                  │
│                                                                │
│ [List resources here]                                          │
│ •                                                              │
│ •                                                              │
│                                                                │
│ Key Gaps:                                                      │
│ •                                                              │
└───────────────────────────────────────────────────────────────┘
                              │
                              ▼
LAYER 2: ORGANIZATIONAL INTELLIGENCE
┌───────────────────────────────────────────────────────────────┐
│ Resources: ________                                            │
│ Status: ○ Not Present  ○ Partial  ○ Complete                  │
│                                                                │
│ [List resources here]                                          │
│ •                                                              │
│ •                                                              │
│                                                                │
│ Key Gaps:                                                      │
│ •                                                              │
└───────────────────────────────────────────────────────────────┘
                              │
                              ▼
LAYER 3: INFRASTRUCTURE & OPERATIONS
┌───────────────────────────────────────────────────────────────┐
│ Resources: ________                                            │
│ Status: ○ Not Present  ○ Partial  ○ Complete                  │
│                                                                │
│ [List resources here]                                          │
│ •                                                              │
│ •                                                              │
│                                                                │
│ Key Gaps:                                                      │
│ •                                                              │
└───────────────────────────────────────────────────────────────┘

GOVERNANCE (Cross-cutting)
┌───────────────────────────────────────────────────────────────┐
│ Identity: ○ Basic  ○ Managed Identities  ○ Zero Trust         │
│ Policy:   ○ None   ○ Basic   ○ Comprehensive                  │
│ Security: ○ None   ○ Defender Basic  ○ Full Protection       │
│ FinOps:   ○ None   ○ Basic Tags  ○ Full Practice             │
└───────────────────────────────────────────────────────────────┘
```

---

## Classification Decision Tree

```
                    ┌─────────────────┐
                    │  Azure Resource │
                    └────────┬────────┘
                             │
              ┌──────────────┴──────────────┐
              │ Does user directly          │
              │ interact with this?         │
              └──────────────┬──────────────┘
                    │                │
                   YES              NO
                    │                │
                    ▼                ▼
            ┌───────────┐   ┌──────────────────┐
            │  LAYER 1  │   │ Does it process  │
            │    UX     │   │ or store data?   │
            └───────────┘   └────────┬─────────┘
                                │           │
                               YES         NO
                                │           │
                                ▼           ▼
                        ┌───────────┐  ┌───────────┐
                        │  LAYER 2  │  │  LAYER 3  │
                        │   DATA    │  │   INFRA   │
                        └───────────┘  └───────────┘
```

---

## Sample Classification Report

### Resource Distribution by Layer

| Layer | Count | % | Top Resources |
|-------|-------|---|---------------|
| Layer 1 | 12 | 15% | App Services (8), Bot Service (2), Power Apps (2) |
| Layer 2 | 28 | 35% | Synapse (1), Data Factory (3), Storage (15), SQL (9) |
| Layer 3 | 35 | 44% | VNets (5), NSGs (12), VMs (10), Key Vaults (8) |
| Governance | 5 | 6% | Policy (3), Defender (1), Log Analytics (1) |

### Architecture Maturity by Layer

| Layer | Score | Status |
|-------|-------|--------|
| Layer 1 (UX) | 2.1/5 | Developing - No AI interface |
| Layer 2 (Intelligence) | 3.2/5 | Defined - Basic data platform |
| Layer 3 (Infrastructure) | 3.8/5 | Managed - Good foundation |
| Governance | 2.5/5 | Developing - Policy gaps |

### Recommendations

1. **Layer 2 Enhancement**: Implement Azure OpenAI + AI Search for intelligence layer
2. **Layer 1 Build-out**: Add Copilot Studio for user-facing AI
3. **Governance**: Deploy comprehensive Azure Policy initiative
