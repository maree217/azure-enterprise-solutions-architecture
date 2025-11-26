# Industry-Specific Solutions

Azure architecture patterns and compliance requirements tailored for specific industries.

---

## Overview

Each industry has unique regulatory requirements, use cases, and technical patterns. This section provides industry-specific guidance mapped to the Three-Layer Enterprise AI Architecture.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    INDUSTRY SOLUTIONS FRAMEWORK                              │
└─────────────────────────────────────────────────────────────────────────────┘

     Healthcare          Financial         Retail           Manufacturing
    ┌───────────┐      ┌───────────┐    ┌───────────┐    ┌───────────┐
    │ HIPAA     │      │ PCI-DSS   │    │ PCI-DSS   │    │ OT/IT     │
    │ HL7 FHIR  │      │ SOX       │    │ GDPR      │    │ Industrial│
    │ HITRUST   │      │ FCA       │    │ Real-time │    │ IoT Edge  │
    │ PHI       │      │ Basel III │    │ Inventory │    │ Predictive│
    └─────┬─────┘      └─────┬─────┘    └─────┬─────┘    └─────┬─────┘
          │                  │                │                │
          └──────────────────┴────────────────┴────────────────┘
                                    │
                                    ▼
                    ┌───────────────────────────────┐
                    │  THREE-LAYER AI ARCHITECTURE   │
                    │  + AZURE LANDING ZONES         │
                    └───────────────────────────────┘
```

---

## Industries Covered

| Industry | Compliance | Key Use Cases | Guide |
|----------|------------|---------------|-------|
| **Healthcare** | HIPAA, HITRUST, HL7 FHIR | Patient engagement, clinical AI, interoperability | [Healthcare](./healthcare/) |
| **Financial Services** | PCI-DSS, SOX, FCA, PRA | Fraud detection, risk analytics, open banking | [Financial Services](./financial-services/) |
| **Retail** | PCI-DSS, GDPR | Inventory AI, customer 360, omnichannel | [Retail](./retail/) |
| **Manufacturing** | IEC 62443, OT security | Predictive maintenance, IoT, digital twin | [Manufacturing](./manufacturing/) |
| **Public Sector** | UK G-Cloud, FedRAMP, IL4/5 | Citizen services, secure cloud, data sharing | [Public Sector](./public-sector/) |

---

## Industry Solution Structure

Each industry guide includes:

```
industry-solutions/[industry]/
├── README.md                    # Industry overview and compliance
├── reference-architecture.md    # Three-layer mapping for industry
├── compliance-requirements.md   # Regulatory requirements detail
├── use-cases/                   # Industry-specific use cases
│   ├── use-case-1.md
│   └── use-case-2.md
├── accelerators/                # Industry-specific accelerators
│   └── [accelerator-name]/
└── azure-services.md            # Industry-optimized service selection
```

---

## Cross-Industry Patterns

### Common Security Requirements

| Requirement | Healthcare | Financial | Retail | Manufacturing | Public Sector |
|-------------|------------|-----------|--------|---------------|---------------|
| Data Encryption at Rest | Required | Required | Required | Required | Required |
| Data Encryption in Transit | TLS 1.2+ | TLS 1.2+ | TLS 1.2+ | TLS 1.2+ | TLS 1.2+ |
| Key Management | Customer-managed | Customer-managed | Platform | Platform | Customer-managed |
| Network Isolation | Private endpoints | Private endpoints | Optional | Required (OT) | Required |
| MFA | Required | Required | Required | Required | Required |
| Audit Logging | 7+ years | 7+ years | GDPR compliant | Varies | 7+ years |

### Azure Services by Industry

| Service | Healthcare | Financial | Retail | Manufacturing | Public Sector |
|---------|------------|-----------|--------|---------------|---------------|
| Azure Health Data Services | Primary | - | - | - | Secondary |
| Azure Synapse | Common | Primary | Primary | Common | Common |
| Azure OpenAI | Clinical AI | Fraud, Risk | Personalization | Predictive | Citizen AI |
| Azure IoT Hub | Remote monitoring | - | Supply chain | Primary | Smart city |
| Azure Confidential Computing | PHI processing | Trading | - | - | Classified |
| Microsoft Fabric | Analytics | Analytics | Primary | Analytics | Analytics |
| Power Platform | Care coordination | Self-service | Customer service | Field ops | Citizen portals |

---

## Compliance Framework Mapping

### Microsoft Cloud Compliance

| Framework | Industries | Azure Certification |
|-----------|------------|---------------------|
| HIPAA | Healthcare | Yes - BAA available |
| HITRUST | Healthcare | Yes - CSF certified |
| PCI-DSS | Financial, Retail | Yes - Level 1 |
| SOC 2 Type II | All | Yes |
| ISO 27001 | All | Yes |
| SOX | Financial | Supported |
| GDPR | All (EU/UK) | Yes |
| FedRAMP High | Public Sector (US) | Yes |
| UK G-Cloud | Public Sector (UK) | Yes |
| IRAP | Public Sector (AU) | Yes |

### Industry-Specific Resources

- [Azure Compliance Documentation](https://learn.microsoft.com/azure/compliance/)
- [Microsoft Industry Solutions](https://www.microsoft.com/industry)
- [Azure for Healthcare](https://azure.microsoft.com/solutions/industries/healthcare/)
- [Azure for Financial Services](https://azure.microsoft.com/solutions/industries/financial/)
- [Azure for Retail](https://azure.microsoft.com/solutions/industries/retail/)
- [Azure for Manufacturing](https://azure.microsoft.com/solutions/industries/discrete-manufacturing/)
- [Azure for Government](https://azure.microsoft.com/explore/global-infrastructure/government/)

---

## Three-Layer Mapping by Industry

### Layer 1: End User Experience

| Industry | Primary Interface | AI Integration |
|----------|-------------------|----------------|
| Healthcare | Patient portal, Provider app | Clinical copilot |
| Financial | Mobile banking, Advisor tools | Financial copilot |
| Retail | E-commerce, Store apps | Shopping assistant |
| Manufacturing | Field service, Control room | Maintenance copilot |
| Public Sector | Citizen portal, Case management | Citizen service bot |

### Layer 2: Organizational Intelligence

| Industry | Data Platform | AI/ML Focus |
|----------|---------------|-------------|
| Healthcare | FHIR data lake, Clinical analytics | Diagnostics, treatment |
| Financial | Transaction lake, Risk analytics | Fraud, credit, market |
| Retail | Customer 360, Inventory analytics | Demand, personalization |
| Manufacturing | Time-series lake, OT analytics | Predictive, quality |
| Public Sector | Citizen data lake, Service analytics | Case routing, insights |

### Layer 3: Infrastructure & Operations

| Industry | Network Pattern | Security Focus |
|----------|-----------------|----------------|
| Healthcare | Private, segmented | PHI protection |
| Financial | Zero trust, isolated | Transaction security |
| Retail | Hybrid, edge | PCI zones |
| Manufacturing | IT/OT segmented | Industrial security |
| Public Sector | Classified enclaves | Data sovereignty |

---

## Getting Started

1. **Identify your industry** - Select the most relevant industry guide
2. **Review compliance** - Understand regulatory requirements
3. **Map to three-layer** - Classify your workloads
4. **Select accelerators** - Use industry-specific templates
5. **Engage specialists** - Leverage Microsoft industry teams

---

## Microsoft Industry Resources

- [Microsoft Cloud for Healthcare](https://www.microsoft.com/industry/health/microsoft-cloud-for-healthcare)
- [Microsoft Cloud for Financial Services](https://www.microsoft.com/industry/financial-services/microsoft-cloud-for-financial-services)
- [Microsoft Cloud for Retail](https://www.microsoft.com/industry/retail/microsoft-cloud-for-retail)
- [Microsoft Cloud for Manufacturing](https://www.microsoft.com/industry/manufacturing/microsoft-cloud-for-manufacturing)
- [Microsoft Cloud for Sustainability](https://www.microsoft.com/sustainability/cloud)

---

*Azure Enterprise Solutions Architecture*
*github.com/maree217/azure-enterprise-solutions-architecture*
