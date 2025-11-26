# Glossary

Plain-English definitions for common terms used in this repository.

---

## Azure Services

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **Azure OpenAI** | Microsoft's hosted version of OpenAI's GPT models | ChatGPT, but running in your Azure tenant with enterprise security |
| **Azure AI Search** | Cognitive search service with vector capabilities | A smart search engine that understands meaning, not just keywords |
| **Azure Synapse** | Unified analytics platform | A data warehouse that also does big data processing |
| **Azure Databricks** | Apache Spark-based analytics | A powerful data engineering platform for complex transformations |
| **Microsoft Fabric** | SaaS analytics platform | All-in-one data platform with Power BI at its core |
| **Azure Key Vault** | Secrets management service | A secure lockbox for passwords, keys, and certificates |
| **Azure Firewall** | Cloud-native network firewall | A bouncer that controls what traffic can enter/exit your network |
| **Azure Bastion** | Secure VM access | A way to access VMs without exposing them to the internet |
| **Microsoft Entra ID** | Identity and access management (formerly Azure AD) | The service that manages who can access what |
| **Azure Policy** | Governance service | Rules that automatically enforce your organization's standards |
| **Azure Monitor** | Observability platform | The dashboard showing how your Azure resources are performing |

---

## Frameworks & Methodologies

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **CAF** | Cloud Adoption Framework | Microsoft's guidance for successfully adopting Azure |
| **WAF** | Well-Architected Framework | Microsoft's 5-pillar approach to building reliable systems |
| **Three-Layer Architecture** | This repository's framework | Build Infrastructure (3) → Intelligence (2) → Experience (1) |
| **Landing Zone** | Pre-configured Azure environment | A "starter kit" for Azure that includes networking, security, governance |
| **Enterprise-Scale** | Microsoft's reference architecture | A specific landing zone design for large organizations |

---

## Architecture Concepts

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **Hub-Spoke** | Network topology pattern | One central network (hub) connects to many workload networks (spokes) |
| **Private Endpoint** | Private connectivity to Azure services | Access Azure services through your private network, not the internet |
| **VNet Peering** | Connecting virtual networks | Making two networks talk to each other |
| **NSG** | Network Security Group | Firewall rules at the network interface level |
| **RBAC** | Role-Based Access Control | Giving people only the permissions they need |
| **Zero Trust** | Security model | Never trust, always verify - treat every request as potentially hostile |
| **Managed Identity** | Azure's service accounts | Let Azure services authenticate without storing passwords |

---

## Data Concepts

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **Data Lake** | Large-scale data storage | A massive repository for all types of data (structured and unstructured) |
| **Medallion Architecture** | Data organization pattern | Bronze (raw) → Silver (cleaned) → Gold (ready-to-use) |
| **ETL/ELT** | Data processing patterns | Extract-Transform-Load: Moving and reshaping data |
| **Delta Lake** | Open-source storage layer | Makes data lakes more reliable with transactions and versioning |
| **ADLS Gen2** | Azure Data Lake Storage Gen2 | Azure's high-performance data lake storage |

---

## AI/ML Concepts

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **RAG** | Retrieval-Augmented Generation | Combining search with AI to answer questions from your documents |
| **LLM** | Large Language Model | AI models like GPT-4 that understand and generate text |
| **Embedding** | Vector representation of text | Converting words into numbers so AI can find similar meanings |
| **Vector Search** | Similarity-based search | Finding things by meaning rather than exact keyword matches |
| **Prompt Engineering** | Crafting AI instructions | Writing effective prompts to get better AI responses |
| **Fine-tuning** | Customizing AI models | Training a model on your specific data to improve performance |
| **Token** | Unit of text for LLMs | Roughly a word or part of a word - what AI models count and charge for |

---

## Compliance & Security

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **HIPAA** | Healthcare compliance | US law protecting patient health information |
| **HITRUST** | Healthcare security framework | A certification that proves healthcare data security |
| **PCI-DSS** | Payment card compliance | Security standards for handling credit card data |
| **SOC 2** | Service organization controls | Audit report proving security/availability/confidentiality |
| **GDPR** | EU data protection regulation | European law governing personal data privacy |
| **CDE** | Cardholder Data Environment | The systems that store, process, or transmit credit card data |
| **PHI** | Protected Health Information | Any health data that can identify a patient |

---

## Infrastructure as Code

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **IaC** | Infrastructure as Code | Managing infrastructure through code files, not clicking in portals |
| **Terraform** | IaC tool by HashiCorp | Popular multi-cloud infrastructure deployment tool |
| **Bicep** | Azure-native IaC | Microsoft's modern language for Azure deployments |
| **ARM Template** | Azure Resource Manager Template | JSON-based Azure deployment (Bicep compiles to this) |
| **State File** | Terraform's memory | File tracking what Terraform has deployed |
| **Module** | Reusable IaC component | A packaged set of resources you can deploy repeatedly |
| **Plan** | Terraform preview | Shows what will change before actually making changes |
| **Apply** | Terraform execution | Actually creates/modifies the infrastructure |

---

## DevOps & Operations

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **CI/CD** | Continuous Integration/Deployment | Automatically testing and deploying code changes |
| **GitOps** | Git-based operations | Using Git as the source of truth for infrastructure |
| **Pipeline** | Automated workflow | A series of automated steps (build, test, deploy) |
| **SLA** | Service Level Agreement | Guaranteed uptime percentage (e.g., 99.9%) |
| **SLO** | Service Level Objective | Target performance metrics |
| **Observability** | System visibility | Ability to understand what's happening inside your systems |
| **APM** | Application Performance Monitoring | Tracking how applications perform |

---

## Assessment & Governance

| Term | What It Is | Plain English |
|------|-----------|---------------|
| **WAF Scorecard** | Assessment template | Evaluation against Well-Architected Framework pillars |
| **Gap Analysis** | Current vs desired state | Identifying what's missing between now and target |
| **Maturity Model** | Capability assessment | Framework for measuring organizational capability levels |
| **ADR** | Architecture Decision Record | Document explaining why a technical decision was made |
| **Roadmap** | Implementation plan | Prioritized sequence of improvements |
| **FinOps** | Cloud financial management | Discipline of managing cloud costs |

---

## Acronyms Quick Reference

| Acronym | Full Form |
|---------|-----------|
| AAC | Azure Architecture Center |
| CAF | Cloud Adoption Framework |
| CDE | Cardholder Data Environment |
| CIDR | Classless Inter-Domain Routing (IP address ranges) |
| CMK | Customer-Managed Key |
| DNS | Domain Name System |
| FHIR | Fast Healthcare Interoperability Resources |
| GPU | Graphics Processing Unit |
| HSM | Hardware Security Module |
| IAM | Identity and Access Management |
| IP | Internet Protocol |
| MFA | Multi-Factor Authentication |
| NSG | Network Security Group |
| PIM | Privileged Identity Management |
| RBAC | Role-Based Access Control |
| SKU | Stock Keeping Unit (Azure pricing tier) |
| TPM | Tokens Per Minute (AI rate limiting) |
| UDR | User-Defined Route |
| VNet | Virtual Network |
| WAF | Well-Architected Framework |

---

## Related Resources

- [Microsoft Azure Glossary](https://learn.microsoft.com/azure/azure-glossary-cloud-terminology)
- [Cloud Adoption Framework Terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/considerations/fundamental-concepts)
- [Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)

---

*Terms missing? Suggest additions via [GitHub Issues](https://github.com/maree217/azure-enterprise-solutions-architecture/issues).*
