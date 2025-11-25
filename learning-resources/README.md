# Learning Resources

Curated learning paths, certifications, and educational content for Azure enterprise architecture.

---

## Certification Paths

### Azure Solutions Architect Expert (AZ-305)

The primary certification for enterprise Azure architects.

**Prerequisites**: AZ-104 (Azure Administrator)

**Exam Topics**:
- Design identity, governance, and monitoring solutions (25-30%)
- Design data storage solutions (20-25%)
- Design business continuity solutions (15-20%)
- Design infrastructure solutions (30-35%)

**Study Resources**:
- [Microsoft Learn Path](https://learn.microsoft.com/training/paths/az-305-design-identity-governance-monitor-solutions/)
- [John Savill's AZ-305 Study Cram](https://www.youtube.com/watch?v=vq9LuCM4YP4)
- [Exam Readiness Zone](https://learn.microsoft.com/shows/exam-readiness-zone/preparing-for-az-305)

### Certification Roadmap

```
┌─────────────────────────────────────────────────────────────────┐
│                 AZURE CERTIFICATION PATH                         │
└─────────────────────────────────────────────────────────────────┘

FUNDAMENTALS (Optional but recommended)
┌─────────────┐
│   AZ-900    │  Azure Fundamentals
└──────┬──────┘
       │
       ↓
ASSOCIATE LEVEL
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   AZ-104    │  │   DP-203    │  │   AI-102    │
│ Administrator│  │Data Engineer│  │ AI Engineer │
└──────┬──────┘  └──────┬──────┘  └──────┬──────┘
       │                │                │
       └────────┬───────┴────────┬───────┘
                │                │
                ↓                ↓
EXPERT LEVEL
┌─────────────────────────┐  ┌─────────────────────────┐
│        AZ-305           │  │        AZ-400           │
│ Solutions Architect     │  │   DevOps Engineer       │
│       Expert            │  │       Expert            │
└─────────────────────────┘  └─────────────────────────┘

SPECIALTY
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   AZ-500    │  │   AZ-700    │  │   AZ-140    │
│  Security   │  │  Networking │  │    AVD      │
└─────────────┘  └─────────────┘  └─────────────┘
```

---

## YouTube Channels

### Tier 1: Essential (Watch First)

#### John Savill's Technical Training
**Channel**: [@NTFAQGuy](https://www.youtube.com/@NTFAQGuy)
**Content**: 924 videos, 24,403+ minutes
**Best For**: Comprehensive Azure training, certification prep

**Must-Watch Playlists**:
| Playlist | Videos | Topic |
|----------|--------|-------|
| AZ-305 Studying | 30+ | Solutions Architect Expert |
| AZ-104 Studying | 50+ | Azure Administrator |
| Azure Master Class | 100+ | Deep dive on all Azure services |
| DevOps Master Class | 30+ | CI/CD, IaC, automation |

**Key Videos**:
- [AZ-305 Study Cram](https://www.youtube.com/watch?v=vq9LuCM4YP4) - 4 hours
- [Azure Networking Deep Dive](https://www.youtube.com/watch?v=nVZYDhB_M64) - 3 hours
- [Azure Landing Zones Explained](https://www.youtube.com/watch?v=VTnqUDMchXA) - 1 hour

**Download Materials**: [GitHub - CertificationMaterials](https://github.com/johnthebrit/CertificationMaterials)

#### Microsoft Azure Official
**Channel**: [@MicrosoftAzure](https://www.youtube.com/@MicrosoftAzure)
**Best For**: Product announcements, feature demos, Azure Friday

**Must-Watch Series**:
- Azure Friday (weekly)
- Azure Enablement Show
- Ask the Expert

### Tier 2: Specialized

#### Adam Marczak - Azure for Everyone
**Channel**: [@yoursubscriptioner](https://www.youtube.com/@yoursubscriptioner)
**Best For**: Beginner-friendly explanations, visual diagrams

#### Microsoft Developer
**Channel**: [@MicrosoftDeveloper](https://www.youtube.com/@MicrosoftDeveloper)
**Best For**: Developer-focused content, coding demos

#### Cloud Academy
**Best For**: Structured learning paths, hands-on labs

---

## Curated Playlists by Domain

### Data Platform Architecture

| Topic | Resource | Duration |
|-------|----------|----------|
| Synapse Analytics | [MS Learn Path](https://learn.microsoft.com/training/paths/realize-integrated-analytical-solutions-with-azure-synapse-analytics/) | 8 hours |
| Databricks | [Databricks Academy](https://www.databricks.com/learn/training/catalog) | Self-paced |
| Microsoft Fabric | [MS Learn Path](https://learn.microsoft.com/training/paths/get-started-fabric/) | 6 hours |
| Data Engineering | [DP-203 Study](https://learn.microsoft.com/certifications/azure-data-engineer/) | 40 hours |

### AI & Machine Learning

| Topic | Resource | Duration |
|-------|----------|----------|
| Azure OpenAI | [MS Learn Path](https://learn.microsoft.com/training/paths/develop-ai-solutions-azure-openai/) | 5 hours |
| AI Fundamentals | [AI-900 Path](https://learn.microsoft.com/training/paths/get-started-with-artificial-intelligence-on-azure/) | 3 hours |
| AI Engineer | [AI-102 Path](https://learn.microsoft.com/certifications/azure-ai-engineer/) | 30 hours |
| RAG Patterns | [RAG Workshop](https://github.com/Azure-Samples/azure-search-openai-demo) | 4 hours |

### Security & Compliance

| Topic | Resource | Duration |
|-------|----------|----------|
| Security Engineer | [AZ-500 Path](https://learn.microsoft.com/certifications/azure-security-engineer/) | 35 hours |
| Zero Trust | [Zero Trust Workshop](https://learn.microsoft.com/security/zero-trust/) | 8 hours |
| Sentinel | [Sentinel Ninja](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/become-a-microsoft-sentinel-ninja-the-complete-level-400/ba-p/1246310) | 40 hours |

### Landing Zones & Governance

| Topic | Resource | Duration |
|-------|----------|----------|
| CAF | [Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/) | 20 hours |
| Landing Zones | [Enterprise-Scale](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/) | 10 hours |
| Well-Architected | [WAF Learning Path](https://learn.microsoft.com/training/paths/azure-well-architected-framework/) | 6 hours |

---

## Books & Publications

### Essential Reading

| Title | Author | Focus |
|-------|--------|-------|
| Azure Architecture Best Practices | Microsoft | Official guidance |
| Designing Distributed Systems | Brendan Burns | Kubernetes patterns |
| Building Microservices | Sam Newman | Microservices architecture |
| Data Mesh | Zhamak Dehghani | Decentralized data |
| Fundamentals of Data Engineering | Joe Reis | Data engineering |

### Azure-Specific Books

| Title | Publisher | Year |
|-------|-----------|------|
| Microsoft Azure Infrastructure Services for Architects | John Savill | 2024 |
| Azure Security Handbook | Microsoft | 2024 |
| The Azure Cloud Native Architecture Mapbook | Microsoft | 2023 |

---

## Hands-On Labs

### Microsoft Learn Sandbox

Free, no subscription required:
- [Create a Virtual Machine](https://learn.microsoft.com/training/modules/create-linux-virtual-machine-in-azure/)
- [Deploy Azure Kubernetes Service](https://learn.microsoft.com/training/modules/intro-to-azure-kubernetes-service/)
- [Build AI Apps with Azure OpenAI](https://learn.microsoft.com/training/modules/build-language-solution-azure-openai/)

### GitHub Learning Labs

| Lab | Repository | Time |
|-----|------------|------|
| RAG Chatbot | [azure-search-openai-demo](https://github.com/Azure-Samples/azure-search-openai-demo) | 2-4 hours |
| Landing Zone | [Enterprise-Scale](https://github.com/Azure/Enterprise-Scale) | 4-6 hours |
| Data Platform | [modern-data-warehouse-dataops](https://github.com/Azure-Samples/modern-data-warehouse-dataops) | 4-6 hours |
| MLOps | [mlops-v2](https://github.com/Azure/mlops-v2) | 3-4 hours |

### Azure Workshops

| Workshop | Link | Duration |
|----------|------|----------|
| Azure OpenAI Workshop | [GitHub](https://github.com/microsoft/Workshop-Interact-with-OpenAI-models) | 4 hours |
| Well-Architected Review | [Azure Portal](https://portal.azure.com/#blade/Microsoft_Azure_WellArchitected/AssessmentMenuBlade/overview) | 2 hours |
| Sentinel Training Lab | [GitHub](https://github.com/Azure/Azure-Sentinel/tree/master/Solutions/Training/Azure-Sentinel-Training-Lab) | 4 hours |

---

## Communities

### Microsoft Tech Community

- [Azure Architecture Blog](https://techcommunity.microsoft.com/t5/azure-architecture-blog/bg-p/AzureArchitectureBlog)
- [Microsoft Sentinel Blog](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/bg-p/MicrosoftSentinelBlog)
- [Azure AI Services Blog](https://techcommunity.microsoft.com/t5/ai-azure-ai-services-blog/bg-p/Azure-AI-Services-blog)

### Reddit Communities

- r/AZURE
- r/azurecertification
- r/devops

### Discord Servers

- Microsoft Azure (Official)
- Cloud Native Computing Foundation
- HashiCorp (for Terraform)

---

## Weekly Learning Plan

### Week 1-4: Foundations

| Week | Focus | Resources |
|------|-------|-----------|
| 1 | Azure Fundamentals | AZ-900 path, John Savill intro |
| 2 | Networking Basics | Networking deep dive videos |
| 3 | Identity & Security | Entra ID, Conditional Access |
| 4 | Governance | Management groups, policies |

### Week 5-8: Associate Level

| Week | Focus | Resources |
|------|-------|-----------|
| 5 | Compute & Storage | VMs, Storage accounts, AKS |
| 6 | Data Platform | Synapse, Databricks basics |
| 7 | AI Services | Azure OpenAI, Cognitive Services |
| 8 | DevOps | Azure DevOps, GitHub Actions |

### Week 9-12: Expert Level

| Week | Focus | Resources |
|------|-------|-----------|
| 9 | Architecture Patterns | Well-Architected Framework |
| 10 | Landing Zones | CAF, Enterprise-Scale |
| 11 | Security Architecture | Zero Trust, Defender, Sentinel |
| 12 | Capstone Project | Build end-to-end solution |

---

## Certification Exam Tips

### General Tips

1. **Use Microsoft Learn** - Free, comprehensive, and aligned with exams
2. **Watch John Savill** - Best free video content available
3. **Do hands-on labs** - Nothing beats practical experience
4. **Take practice tests** - MeasureUp, Whizlabs, or MS practice assessments
5. **Join study groups** - Discord, Reddit, local meetups

### AZ-305 Specific Tips

- Focus on **design decisions**, not implementation details
- Understand **trade-offs** between options
- Know **when to use each service** (decision trees)
- Practice **scenario-based questions**
- Review **case studies** in the exam

### Day Before Exam

- Review your notes
- Get good sleep
- Don't cram new material
- Prepare ID and test environment (if online)

---

## Three-Layer Framework Learning Path

### Layer 3 (Infrastructure) - Start Here

1. Complete AZ-104 (Administrator)
2. Study landing zones and governance
3. Learn networking and security
4. Practice IaC (Terraform or Bicep)

### Layer 2 (Intelligence) - Second

1. Complete DP-203 (Data Engineer)
2. Learn Synapse/Databricks/Fabric
3. Study data governance (Purview)
4. Practice RAG patterns

### Layer 1 (UX) - Last

1. Learn Power Platform basics
2. Study Copilot Studio
3. Practice building chatbots
4. Learn user adoption strategies

### Expert (All Layers)

1. Complete AZ-305 (Solutions Architect)
2. Study Well-Architected Framework
3. Practice end-to-end solutions
4. Build portfolio projects
