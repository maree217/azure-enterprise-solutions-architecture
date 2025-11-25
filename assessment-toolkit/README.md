# Azure Architecture Assessment Toolkit

A comprehensive, data-driven assessment methodology for evaluating enterprise Azure environments.

---

## Overview

This toolkit enables **systematic, evidence-based** Azure architecture assessments that go beyond opinions to deliver actionable insights grounded in actual configuration data.

### Our Philosophy

> "We don't guess. We extract your actual configuration and analyze it against proven patterns."

**Key Principles:**

1. **Data-Driven, Not Opinion-Based** - Extract real configurations, not assumptions
2. **Framework-Aligned** - Map to Well-Architected Framework + Three-Layer Architecture
3. **Perception vs. Reality** - Surface blind spots between belief and actuality
4. **Strategic Alignment** - Connect technical findings to business objectives
5. **Actionable Outcomes** - Deliver IaC templates, scripts, and executable roadmaps

---

## Assessment Methodology

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    ASSESSMENT WORKFLOW                                      │
└────────────────────────────────────────────────────────────────────────────┘

┌──────────────┐      ┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   DISCOVER   │ ───▶ │   EXTRACT    │ ───▶ │   ANALYZE    │ ───▶ │  RECOMMEND   │
│   (1 week)   │      │   (1 day)    │      │   (1 week)   │      │   (1 week)   │
└──────────────┘      └──────────────┘      └──────────────┘      └──────────────┘
       │                    │                     │                      │
       ▼                    ▼                     ▼                      ▼
• Stakeholder         • Automated            • Three-Layer          • Prioritized
  interviews            resource export        Framework mapping      roadmap
• Strategic           • Security             • WAF scoring          • Quick wins
  objectives            findings             • Gap analysis         • Long-term
• Current pain        • Cost data            • Cost modeling          initiatives
  points              • Performance          • Risk assessment      • IaC templates
• Documentation         metrics                                       ready to deploy
```

---

## Phase 1: Discovery

### Stakeholder Interviews

**Executive Level:**
- Business objectives and strategic priorities
- Budget constraints and timeline expectations
- Risk tolerance and compliance requirements
- Previous cloud experiences (positive/negative)

**Technical Level:**
- Current architecture and design decisions
- Known pain points and technical debt
- Team capabilities and skill gaps
- Operational challenges

**Interview Template:** [methodology/interview-guide.md](methodology/interview-guide.md)

### Document Collection

| Document Type | Purpose |
|---------------|---------|
| Architecture diagrams | Baseline understanding |
| Runbooks/SOPs | Operational maturity |
| Previous assessments | Historical context |
| Compliance requirements | Regulatory constraints |
| Cost reports | Financial baseline |

---

## Phase 2: Data Extraction

### Automated Extraction Tools

| Tool | What It Extracts | Script |
|------|------------------|--------|
| **Azure Resource Graph** | All resources, configs, relationships | [azure-inventory.ps1](extraction-scripts/azure-inventory.ps1) |
| **ARM Export** | Full infrastructure definitions | [arm-export.ps1](extraction-scripts/arm-export.ps1) |
| **Microsoft Defender** | Security posture, vulnerabilities | [security-export.ps1](extraction-scripts/security-export.ps1) |
| **Azure Advisor** | Recommendations (cost, security, perf) | [advisor-export.ps1](extraction-scripts/advisor-export.ps1) |
| **Cost Management** | Billing, usage, forecasts | [cost-export.ps1](extraction-scripts/cost-export.ps1) |
| **Azure Monitor** | Performance metrics, alerts | [monitoring-export.ps1](extraction-scripts/monitoring-export.ps1) |

### Quick Start

```powershell
# Run comprehensive extraction
./extraction-scripts/run-full-assessment.ps1 -SubscriptionId "xxx" -OutputPath "./assessment-data"
```

### Third-Party Tools (Optional)

| Tool | Purpose | When to Use |
|------|---------|-------------|
| **Cloudockit** | Automated documentation + diagrams | Client needs polished visuals |
| **Steampipe** | SQL-based compliance queries | Detailed compliance audit |
| **Azure Visualizer** | Live architecture diagrams | Quick visual discovery |

---

## Phase 3: Analysis

### Three-Layer Framework Mapping

Map all discovered resources to the framework:

```
┌─────────────────────────────────────────────────────────────────┐
│                 RESOURCE CLASSIFICATION                          │
└─────────────────────────────────────────────────────────────────┘

LAYER 1: End User Experience
├── Power Apps / Power Pages
├── Bot Services / Copilot Studio
├── App Service (user-facing)
└── Static Web Apps

LAYER 2: Organizational Intelligence
├── Azure Synapse / Databricks
├── Azure AI Search
├── Azure OpenAI
├── Data Factory
├── Microsoft Purview
└── Azure ML

LAYER 3: Infrastructure & Operations
├── Virtual Networks / Subnets
├── AKS / Container Apps
├── Storage Accounts
├── Key Vault
├── Azure Monitor
└── Azure Firewall

GOVERNANCE (Cross-cutting)
├── Azure Policy
├── Microsoft Defender
├── Microsoft Sentinel
├── Entra ID
└── Cost Management
```

### Well-Architected Framework Scoring

Score each pillar 1-5 based on extracted data:

| Pillar | Score Criteria | Weight |
|--------|----------------|--------|
| **Reliability** | Redundancy, DR, backups, SLAs | 20% |
| **Security** | Identity, network, data, compliance | 25% |
| **Cost Optimization** | Rightsizing, reservations, waste | 15% |
| **Operational Excellence** | Monitoring, automation, DevOps | 20% |
| **Performance Efficiency** | Scaling, optimization, caching | 20% |

**Scorecard Template:** [analysis-templates/waf-scorecard.xlsx](analysis-templates/waf-scorecard.xlsx)

### Gap Analysis

Compare current state against:
1. Microsoft best practices
2. Industry standards
3. Client's stated objectives
4. Regulatory requirements

**Gap Analysis Template:** [analysis-templates/gap-analysis-template.md](analysis-templates/gap-analysis-template.md)

### Perception vs. Reality Matrix

| Area | Client Perception | Actual State | Gap |
|------|-------------------|--------------|-----|
| Security | "We're secure" | Defender score: 62% | High |
| Cost | "Optimized" | 40% underutilized | Medium |
| DR | "30 min RTO" | No DR tested | Critical |

---

## Phase 4: Recommendations

### Prioritization Framework

```
┌─────────────────────────────────────────────────────────────────┐
│               PRIORITIZATION MATRIX                              │
└─────────────────────────────────────────────────────────────────┘

                    HIGH IMPACT
                         │
        ┌────────────────┼────────────────┐
        │                │                │
        │   STRATEGIC    │   QUICK WINS   │
        │   INITIATIVES  │   (Do First)   │
        │   (Plan)       │                │
        │                │                │
LOW ────┼────────────────┼────────────────┼──── HIGH
EFFORT  │                │                │     EFFORT
        │   FILL-INS     │   MAJOR        │
        │   (Backlog)    │   PROJECTS     │
        │                │   (Sequence)   │
        │                │                │
        └────────────────┼────────────────┘
                         │
                    LOW IMPACT
```

### Remediation Categories

| Category | Timeline | Examples |
|----------|----------|----------|
| **Quick Wins** | < 1 week | Enable MFA, fix NSG rules, add tags |
| **Short-term** | 1-4 weeks | Implement backups, rightsizing, monitoring |
| **Medium-term** | 1-3 months | Landing zone deployment, security hardening |
| **Strategic** | 3-12 months | Data platform migration, AI enablement |

### Deliverables Package

| Deliverable | Template | Audience |
|-------------|----------|----------|
| Executive Summary | [executive-summary.docx](client-deliverables/executive-summary-template.docx) | C-Level |
| Assessment Report | [assessment-report.pptx](client-deliverables/assessment-report-template.pptx) | Technical leaders |
| Detailed Findings | [findings-workbook.xlsx](client-deliverables/findings-workbook.xlsx) | Architects |
| Roadmap | [roadmap-template.xlsx](client-deliverables/roadmap-template.xlsx) | PMO |
| IaC Templates | [/infrastructure-as-code/](../infrastructure-as-code/) | Engineers |

---

## Toolkit Contents

```
assessment-toolkit/
├── README.md                          # This file
├── extraction-scripts/
│   ├── azure-inventory.ps1            # Resource Graph extraction
│   ├── arm-export.ps1                 # ARM template export
│   ├── security-export.ps1            # Defender + security findings
│   ├── advisor-export.ps1             # Advisor recommendations
│   ├── cost-export.ps1                # Cost Management data
│   ├── monitoring-export.ps1          # Azure Monitor metrics
│   └── run-full-assessment.ps1        # Master script
├── analysis-templates/
│   ├── waf-scorecard.xlsx             # Well-Architected scoring
│   ├── gap-analysis-template.md       # Gap analysis document
│   ├── maturity-model.json            # Maturity radar data
│   └── three-layer-classification.md  # Resource mapping guide
├── client-deliverables/
│   ├── executive-summary-template.docx
│   ├── assessment-report-template.pptx
│   ├── findings-workbook.xlsx
│   └── roadmap-template.xlsx
└── methodology/
    ├── interview-guide.md             # Stakeholder questions
    ├── discovery-checklist.md         # Pre-assessment checklist
    └── presentation-guide.md          # How to present findings
```

---

## Using This Toolkit

### Prerequisites

- Azure PowerShell or Azure CLI installed
- Reader access to target subscriptions
- Microsoft.Graph permissions (for Entra ID data)

### Step-by-Step Process

**1. Initial Setup (Day 1)**
```powershell
# Clone repository
git clone https://github.com/maree217/azure-enterprise-solutions-architecture
cd azure-enterprise-solutions-architecture/assessment-toolkit

# Connect to Azure
Connect-AzAccount
Set-AzContext -Subscription "target-subscription-id"
```

**2. Run Extraction (Day 1-2)**
```powershell
# Full extraction
./extraction-scripts/run-full-assessment.ps1 `
    -SubscriptionIds @("sub1", "sub2") `
    -OutputPath "./client-name-assessment" `
    -IncludeSecurityData $true `
    -IncludeCostData $true
```

**3. Analysis (Day 3-7)**
- Open extracted data in analysis tools
- Complete WAF scorecard
- Document gaps and findings
- Map to Three-Layer Framework

**4. Report Generation (Day 8-10)**
- Use templates to create deliverables
- Prepare executive summary
- Build prioritized roadmap
- Package IaC recommendations

**5. Presentation (Day 11-12)**
- Present findings to client
- Discuss priorities and trade-offs
- Agree on next steps
- Handover documentation

---

## Visualization Tools

### Architecture Diagrams

| Tool | Use Case | Integration |
|------|----------|-------------|
| **Draw.io** | Manual diagrams | Free, exports to PNG/SVG |
| **Cloudockit** | Auto-generated diagrams | Paid, connects to Azure |
| **Azure Visualizer** | Quick live views | Free extension |
| **Mermaid** | Code-based diagrams | Markdown compatible |

### Maturity Radar Charts

Generate radar charts from maturity assessment:

```python
# Using matplotlib
import matplotlib.pyplot as plt
import numpy as np

categories = ['Reliability', 'Security', 'Cost', 'Operations', 'Performance']
values = [3.5, 2.8, 4.0, 3.2, 3.8]

# Create radar chart
# See: analysis-templates/generate-radar.py
```

### Power BI Dashboard

Import assessment data into Power BI for interactive analysis:
- Resource distribution by type/location
- Cost trends and projections
- Security score over time
- Compliance status

---

## Sample Assessment Timeline

### Standard Assessment (2 weeks)

| Day | Activity | Deliverable |
|-----|----------|-------------|
| 1-2 | Discovery interviews | Interview notes |
| 3 | Data extraction | JSON exports |
| 4-5 | WAF analysis | Scorecard |
| 6-7 | Gap analysis | Findings doc |
| 8-9 | Recommendations | Roadmap |
| 10 | Report creation | Slide deck |
| 11 | Internal review | Final report |
| 12 | Client presentation | Handover |

### Rapid Assessment (1 week)

| Day | Activity |
|-----|----------|
| 1 | Extraction + quick interviews |
| 2-3 | Automated analysis |
| 4 | Report generation |
| 5 | Client presentation |

---

## Integration with Three-Layer Framework

This assessment toolkit maps directly to the framework philosophy:

| Assessment Finding | Framework Mapping | Remediation Source |
|--------------------|-------------------|-------------------|
| Missing monitoring | Layer 3 - Observability | [accelerators/](../accelerators/) |
| No RAG implementation | Layer 2 - Intelligence | [accelerators/ai-ml/](../accelerators/ai-ml/) |
| Poor user adoption | Layer 1 - UX | [three-layer-overlay/](../three-layer-overlay/) |
| Security gaps | Governance | [security-compliance/](../accelerators/security-compliance/) |

---

## Pricing Guidance

| Assessment Type | Duration | Typical Fee Range |
|-----------------|----------|-------------------|
| Rapid Assessment | 1 week | £5,000 - £10,000 |
| Standard Assessment | 2 weeks | £15,000 - £25,000 |
| Comprehensive (multi-sub) | 4 weeks | £30,000 - £50,000 |
| Enterprise-wide | 8+ weeks | £75,000+ |

*Pricing varies by scope, complexity, and market*

---

## Next Steps After Assessment

1. **Quick Wins Implementation** - Deploy immediate fixes
2. **Landing Zone Deployment** - If not present
3. **Security Hardening** - Address critical vulnerabilities
4. **Data Platform Modernization** - Enable Layer 2
5. **AI Enablement** - Build Layer 1 experiences
6. **Continuous Improvement** - Establish governance

---

## Related Resources

- [Well-Architected Framework Assessment](https://learn.microsoft.com/assessments/azure-architecture-review/)
- [Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/)
- [Azure Advisor](https://learn.microsoft.com/azure/advisor/)
- [Microsoft Defender for Cloud](https://learn.microsoft.com/azure/defender-for-cloud/)
