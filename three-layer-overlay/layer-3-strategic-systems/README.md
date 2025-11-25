# Layer 3: Infrastructure & Operations

**Build Sequence**: FIRST
**Timeline**: 90 days
**Expected ROI**: 30-50% cost savings

---

## Overview

Layer 3 is the **foundation** of your enterprise AI architecture. Everything else depends on this layer being secure, observable, cost-optimized, and reliable.

> "You can't build a skyscraper on sand. Infrastructure first."

---

## Components

### 1. Orchestration

Container and compute orchestration for running workloads at scale.

| Service | Use Case | When to Use |
|---------|----------|-------------|
| **Azure Kubernetes Service (AKS)** | Container orchestration | Complex microservices, need full K8s control |
| **Azure Container Apps** | Serverless containers | Event-driven, auto-scaling workloads |
| **Azure Functions** | Serverless compute | Event triggers, short-running tasks |
| **Azure App Service** | PaaS web apps | Traditional web applications |
| **Azure Batch** | Batch processing | Large-scale parallel computing |

#### Decision Tree: Compute Selection

```
Need containers?
├── Yes
│   ├── Need full Kubernetes control?
│   │   ├── Yes → AKS
│   │   └── No → Container Apps
│   └── Simple container hosting?
│       └── → Azure Container Instances
└── No
    ├── Event-driven, short tasks?
    │   └── → Azure Functions
    ├── Traditional web app?
    │   └── → App Service
    └── Batch processing?
        └── → Azure Batch
```

### 2. Observability

Full-stack monitoring, logging, and diagnostics.

| Service | Purpose | Key Features |
|---------|---------|--------------|
| **Azure Monitor** | Platform metrics | Infrastructure metrics, alerts |
| **Application Insights** | APM | Request tracing, performance diagnostics |
| **Log Analytics** | Log aggregation | KQL queries, correlation |
| **Azure Workbooks** | Visualization | Custom dashboards, reports |

#### Observability Stack Pattern

```
┌─────────────────────────────────────────────────────────┐
│                    Azure Workbooks                       │
│                    (Visualization)                       │
└─────────────────────────────────────────────────────────┘
                          ↑
┌─────────────────────────────────────────────────────────┐
│                   Log Analytics                          │
│            (Query, Correlate, Alert)                    │
└─────────────────────────────────────────────────────────┘
                          ↑
┌──────────────┬──────────────┬──────────────────────────┐
│Azure Monitor │ App Insights │ Diagnostic Settings      │
│  (Metrics)   │   (Traces)   │     (Logs)               │
└──────────────┴──────────────┴──────────────────────────┘
```

### 3. Security

Defense in depth across all resources.

| Service | Purpose | Priority |
|---------|---------|----------|
| **Microsoft Defender for Cloud** | CSPM | P0 - Enable immediately |
| **Microsoft Sentinel** | SIEM/SOAR | P1 - Security operations |
| **Azure Key Vault** | Secrets management | P0 - All secrets in vault |
| **Microsoft Entra ID** | Identity | P0 - Foundation |
| **Azure Firewall** | Network security | P1 - Perimeter protection |
| **Azure Private Link** | Private connectivity | P1 - Eliminate public exposure |

#### Zero Trust Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    VERIFY EXPLICITLY                     │
│         Every access request is authenticated           │
│                    (Entra ID + MFA)                     │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                   LEAST PRIVILEGE                        │
│      Minimum permissions, Just-in-Time access           │
│                    (PIM, RBAC)                          │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                   ASSUME BREACH                          │
│      Segment networks, encrypt everywhere               │
│          (Private Link, Key Vault, Defender)            │
└─────────────────────────────────────────────────────────┘
```

### 4. Cost Optimization

FinOps practices for sustainable cloud spending.

| Practice | Service/Tool | Impact |
|----------|--------------|--------|
| **Reserved Instances** | Azure Reservations | 30-72% savings |
| **Spot VMs** | Spot pricing | Up to 90% savings (interruptible) |
| **Rightsizing** | Azure Advisor | 10-30% savings |
| **Auto-shutdown** | Automation | Dev/test cost reduction |
| **Storage Tiering** | ADLS lifecycle | 50-70% storage savings |

#### FinOps Dashboard KPIs

- Daily/Weekly/Monthly spend vs budget
- Cost by resource group/subscription
- Unused resources
- Reservation utilization
- Savings recommendations

---

## Landing Zone Patterns

### Enterprise-Scale Landing Zone

The recommended foundation for enterprise Azure deployments.

```
┌─────────────────────────────────────────────────────────┐
│                    Root Management Group                 │
└─────────────────────────────────────────────────────────┘
                          │
        ┌─────────────────┼─────────────────┐
        ↓                 ↓                 ↓
┌───────────────┐ ┌───────────────┐ ┌───────────────┐
│   Platform    │ │  Landing      │ │ Decommissioned│
│               │ │  Zones        │ │               │
└───────────────┘ └───────────────┘ └───────────────┘
        │                 │
   ┌────┴────┐       ┌────┴────┐
   ↓         ↓       ↓         ↓
┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐
│Connec│ │Identi│ │ Corp │ │Online│
│tivity│ │ty    │ │      │ │      │
└──────┘ └──────┘ └──────┘ └──────┘
```

### Hub-Spoke Network Topology

```
                    ┌─────────────────┐
                    │   On-Premises   │
                    │   (ExpressRoute)│
                    └────────┬────────┘
                             │
                    ┌────────┴────────┐
                    │      HUB        │
                    │   ┌─────────┐   │
                    │   │Firewall │   │
                    │   │Bastion  │   │
                    │   │Gateway  │   │
                    │   └─────────┘   │
                    └────────┬────────┘
                             │
        ┌──────────┬─────────┼─────────┬──────────┐
        │          │         │         │          │
   ┌────┴────┐┌────┴────┐┌───┴────┐┌───┴────┐┌───┴────┐
   │ Spoke 1 ││ Spoke 2 ││Spoke 3 ││Spoke 4 ││Spoke 5 │
   │ (Prod)  ││ (Dev)   ││(Data)  ││  (AI)  ││ (DMZ)  │
   └─────────┘└─────────┘└────────┘└────────┘└────────┘
```

---

## Implementation Checklist

### Week 1-2: Identity & Governance Foundation

- [ ] Configure Entra ID tenant
- [ ] Set up Privileged Identity Management (PIM)
- [ ] Create Management Group hierarchy
- [ ] Assign baseline Azure Policies
- [ ] Enable Microsoft Defender for Cloud
- [ ] Configure diagnostic settings to Log Analytics

### Week 3-4: Networking Foundation

- [ ] Deploy Hub VNet with Firewall
- [ ] Configure ExpressRoute/VPN Gateway
- [ ] Set up Private DNS Zones
- [ ] Create Spoke VNet templates
- [ ] Configure Network Security Groups
- [ ] Enable Azure DDoS Protection

### Week 5-6: Compute & Security

- [ ] Deploy AKS cluster (if needed)
- [ ] Configure Container Registry
- [ ] Set up Key Vault
- [ ] Enable Private Link for services
- [ ] Configure Microsoft Sentinel
- [ ] Set up security alerts

### Week 7-8: Observability & Cost

- [ ] Deploy Log Analytics Workspace
- [ ] Configure Application Insights
- [ ] Create Azure Workbooks dashboards
- [ ] Set up Cost Management budgets
- [ ] Configure Azure Advisor alerts
- [ ] Purchase Reserved Instances (if applicable)

### Week 9-12: Automation & GitOps

- [ ] Set up GitHub/Azure DevOps
- [ ] Create IaC pipelines (Terraform/Bicep)
- [ ] Implement GitOps workflows
- [ ] Configure automated testing
- [ ] Set up deployment stages
- [ ] Document runbooks

---

## Terraform vs Bicep Decision Matrix

| Factor | Terraform | Bicep |
|--------|-----------|-------|
| **Multi-cloud** | Yes | No (Azure only) |
| **Learning curve** | Moderate | Low (if know ARM) |
| **State management** | Required | Not needed |
| **Community modules** | Extensive | Growing |
| **Microsoft support** | Third-party | First-party |
| **IDE support** | Good | Excellent (VS Code) |

**Recommendation**:
- Use **Terraform** if you have multi-cloud or existing Terraform expertise
- Use **Bicep** if Azure-only and want tightest Microsoft integration

---

## Success Metrics

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Uptime** | >99.9% | Azure Monitor SLA reports |
| **Security Score** | >90% | Defender for Cloud |
| **Cost Variance** | <5% | Cost Management vs Budget |
| **Deployment Frequency** | Daily | Pipeline metrics |
| **Mean Time to Recovery** | <1 hour | Incident tracking |
| **Compliance Score** | 100% | Compliance Manager |

---

## Key Resources

### Microsoft Repos

- [Enterprise-Scale](https://github.com/Azure/Enterprise-Scale) - Landing zones guidance
- [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep) - Bicep landing zones
- [terraform-azurerm-caf-enterprise-scale](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale) - Terraform CAF

### Documentation

- [Cloud Adoption Framework - Ready](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/)
- [Landing Zone Documentation](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)

---

## Next Steps

Once Layer 3 is stable (90 days), proceed to [Layer 2: Organizational Intelligence](../layer-2-data-intelligence/).
