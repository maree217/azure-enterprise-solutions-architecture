# Getting Started

Welcome to the Azure Enterprise Solutions Architecture repository.
This guide helps you navigate the resources and get value quickly.

---

## What Is This Repository?

This is an **Azure Center of Excellence (CoE)** that provides:

- **Architecture Patterns**: Proven designs for enterprise Azure deployments
- **Infrastructure as Code**: Ready-to-use Terraform and Bicep modules
- **Assessment Tools**: Scripts and templates to evaluate Azure environments
- **Industry Solutions**: Compliance-focused architectures for Healthcare, Financial Services, and more
- **Framework Guidance**: The Three-Layer Enterprise AI Architecture methodology

---

## Who Is This For?

| Role | What You'll Find |
|------|------------------|
| **Enterprise Architects** | Reference architectures, decision records, framework guidance |
| **Cloud Engineers** | Terraform/Bicep modules, landing zone patterns |
| **Security Teams** | Compliance checklists, security baselines, industry requirements |
| **IT Leaders** | ROI frameworks, assessment tools, roadmap templates |
| **Consultants** | Client deliverable templates, methodology guides |

---

## Quick Navigation

### By Goal

| I want to... | Start here |
|--------------|------------|
| Understand the framework | [Three-Layer Architecture](../../README.md#the-framework-three-layer-enterprise-ai-architecture) |
| Deploy infrastructure | [Infrastructure as Code](../../infrastructure-as-code/README.md) |
| Assess an Azure environment | [Assessment Toolkit](../../assessment-toolkit/README.md) |
| Design for a specific industry | [Industry Solutions](../../industry-solutions/README.md) |
| Review architecture decisions | [ADRs](../architecture-decisions/README.md) |
| View architecture diagrams | [Diagrams](../../diagrams/README.md) |

### By Technical Depth

| Level | Resources |
|-------|-----------|
| **Executive/Overview** | [What Is This Repo](what-is-this-repo.md), [Framework Whitepaper](../../diagrams/pdf/three-layer-framework-whitepaper.pdf) |
| **Architecture** | [Reference Architectures](../../reference-architectures/README.md), [ADRs](../architecture-decisions/README.md) |
| **Implementation** | [Terraform Modules](../../infrastructure-as-code/terraform/), [Bicep Modules](../../infrastructure-as-code/bicep/) |
| **Assessment** | [Extraction Scripts](../../assessment-toolkit/extraction-scripts/), [Analysis Templates](../../assessment-toolkit/analysis-templates/) |

---

## The Three-Layer Framework (30-Second Overview)

Build enterprise AI in this order:

```
┌─────────────────────────────────────────────────────────┐
│  LAYER 1: User Experience (Build LAST)                  │
│  Power Apps, Copilot Studio, Custom Web                 │
│  Timeline: 6-9 months | ROI: 5-10x                      │
└─────────────────────────────────────────────────────────┘
                          ▲
┌─────────────────────────────────────────────────────────┐
│  LAYER 2: Organizational Intelligence (Build SECOND)    │
│  Azure OpenAI, AI Search, Synapse, ML                   │
│  Timeline: 6-9 months | ROI: 2-4x                       │
└─────────────────────────────────────────────────────────┘
                          ▲
┌─────────────────────────────────────────────────────────┐
│  LAYER 3: Infrastructure (Build FIRST)                  │
│  Networking, Security, Identity, Monitoring             │
│  Timeline: 90 days | Savings: 30-50%                    │
└─────────────────────────────────────────────────────────┘
```

**Key Insight**: Each layer funds the next. Start with infrastructure cost savings, use those savings to fund intelligence, then user experiences.

[View Full Diagram](../../diagrams/png/three-layer-architecture-overview.png)

---

## 5-Minute Quick Starts

### Quick Start 1: Deploy Hub-Spoke Network

```bash
# Clone the repository
git clone https://github.com/maree217/azure-enterprise-solutions-architecture.git
cd azure-enterprise-solutions-architecture

# Navigate to hub-spoke module
cd infrastructure-as-code/terraform/modules/networking/hub-spoke

# Initialize and plan
terraform init
terraform plan -var="environment=dev" -var="location=uksouth"
```

### Quick Start 2: Run Azure Assessment

```powershell
# Connect to Azure
Connect-AzAccount

# Run inventory extraction
./assessment-toolkit/extraction-scripts/Get-AzureInventory.ps1 `
    -SubscriptionId "your-subscription-id" `
    -OutputPath "./assessment-output"
```

### Quick Start 3: Review Architecture Decisions

Browse the [Architecture Decision Records](../architecture-decisions/README.md) to understand:
- Why Three-Layer Architecture?
- How to choose a data platform?
- When to use Terraform vs Bicep?

---

## Repository Structure

```
azure-enterprise-solutions-architecture/
├── README.md                           # Main entry point
├── CONTRIBUTING.md                     # How to contribute
├── diagrams/                           # Architecture diagrams
│   ├── png/                            # PNG images
│   └── pdf/                            # Whitepapers
├── docs/
│   ├── getting-started/                # You are here
│   ├── architecture-decisions/         # ADRs
│   └── frameworks/                     # Framework details
├── infrastructure-as-code/
│   ├── terraform/modules/              # Terraform modules
│   └── bicep/modules/                  # Bicep modules
├── assessment-toolkit/
│   ├── extraction-scripts/             # PowerShell scripts
│   ├── analysis-templates/             # Assessment templates
│   ├── client-deliverables/            # Report templates
│   └── methodology/                    # Process guides
├── industry-solutions/
│   ├── healthcare/                     # HIPAA/HITRUST
│   └── financial-services/             # PCI-DSS
├── landing-zones/                      # Landing zone patterns
└── reference-architectures/            # Solution patterns
```

---

## Next Steps

1. **Read** [What Is This Repo](what-is-this-repo.md) for full context
2. **Review** [Glossary](glossary.md) if terms are unfamiliar
3. **Explore** the area most relevant to your current needs
4. **Contribute** improvements via [CONTRIBUTING.md](../../CONTRIBUTING.md)

---

## Need Help?

- **Questions**: [Open an issue](https://github.com/maree217/azure-enterprise-solutions-architecture/issues)
- **Contributions**: See [CONTRIBUTING.md](../../CONTRIBUTING.md)
- **Updates**: Watch the repository for notifications

---

*Last updated: November 2024*
