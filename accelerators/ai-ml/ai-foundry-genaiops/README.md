# Azure AI Foundry GenAIOps Accelerator

## Overview

Enterprise-grade strategic intelligence implementations using Azure AI Foundry with Inner/Outer Loop GenAIOps patterns.

---

## Reference Repository

**Primary Implementation**: [azure-ai-foundry-showcase](https://github.com/maree217/azure-ai-foundry-showcase)

This accelerator demonstrates production-ready AI Foundry deployments with:

- **Inner Loop**: Local experimentation with VS Code integration
- **Outer Loop**: Automated CI/CD pipelines for production deployment
- **Custom Evaluators**: Framework for AI quality assessment
- **Azure AI Agents**: Multi-agent orchestration patterns

---

## Three-Layer Framework Mapping

| Component | Framework Layer | Purpose |
|-----------|-----------------|---------|
| AI Foundry Workspace | Layer 3 | Strategic AI infrastructure |
| Custom Evaluators | Layer 2 | Intelligence quality control |
| Model Endpoints | Layer 1 | User-facing AI services |
| MLOps Pipelines | Governance | Automated deployment & monitoring |

---

## Technologies

- **Azure AI Foundry** - GenAIOps platform
- **Azure OpenAI Service** - LLM foundation models
- **Azure Container Registry** - Model & artifact storage
- **Azure Key Vault** - Secrets management
- **Application Insights** - Observability
- **Terraform** - Infrastructure as Code
- **GitHub Actions** - CI/CD automation

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    OUTER LOOP (Production)                       │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐     │
│  │  GitHub  │ → │  Build   │ → │  Test    │ → │  Deploy  │     │
│  │  Actions │   │  Image   │   │  Eval    │   │  Prod    │     │
│  └──────────┘   └──────────┘   └──────────┘   └──────────┘     │
└─────────────────────────────────────────────────────────────────┘
                              ↑
                              │ Promote
                              │
┌─────────────────────────────────────────────────────────────────┐
│                    INNER LOOP (Development)                      │
│  ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐     │
│  │ VS Code  │ → │  Local   │ → │  Manual  │ → │  Commit  │     │
│  │ + Ext    │   │  Test    │   │  Eval    │   │  PR      │     │
│  └──────────┘   └──────────┘   └──────────┘   └──────────┘     │
└─────────────────────────────────────────────────────────────────┘
```

---

## Use Cases Included

### 1. Math Coding Agent
Mathematical reasoning with code generation capabilities.

### 2. Semantic Kernel Agents
Multi-agent orchestration using Microsoft Semantic Kernel.

### 3. Custom Evaluators
Quality assessment framework for AI outputs.

---

## Getting Started

1. Clone the reference repository:
   ```bash
   git clone https://github.com/maree217/azure-ai-foundry-showcase
   cd azure-ai-foundry-showcase
   ```

2. Follow the setup instructions in the repository README

3. Deploy infrastructure:
   ```bash
   cd infra
   terraform init
   terraform apply
   ```

4. Run local experiments with VS Code integration

---

## ROI Metrics

Based on production deployments:

| Metric | Result |
|--------|--------|
| Model iteration speed | 3x faster |
| Deployment time | 70% reduction |
| Quality assurance | Automated evaluation |
| Cost optimization | GPU scheduling efficiency |

---

## Related Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [GenAIOps Guide](https://learn.microsoft.com/azure/machine-learning/prompt-flow/concept-llmops-maturity)
- [Semantic Kernel](https://github.com/microsoft/semantic-kernel)

---

## Integration with Three-Layer Framework

This accelerator is a **Layer 3: Strategic Intelligence** component that:

1. Provides the AI compute and orchestration foundation
2. Enables rapid experimentation (Inner Loop)
3. Ensures production quality (Outer Loop with evaluators)
4. Connects to Layer 2 data sources for RAG patterns
5. Exposes endpoints for Layer 1 user interfaces
