# ADR-001: Three-Layer Enterprise AI Architecture

## Status
Accepted

## Date
2024-01-15

## Context

Enterprises adopting AI and cloud technologies struggle with:

1. **Where to start**: Should they build AI interfaces first, or data platforms first?
2. **Disconnected investments**: AI projects that don't connect to enterprise data
3. **Poor adoption**: Technology that doesn't meet user needs
4. **Technical debt**: Piecemeal solutions that don't integrate

Industry frameworks (Gartner, McKinsey, MIT CISR) consistently identify patterns, but there's no unified approach specific to Azure enterprise deployments.

We need an opinionated framework that:
- Guides enterprise Azure architecture decisions
- Integrates AI/ML as a first-class concern
- Provides clear sequencing for implementation
- Aligns with Microsoft's Well-Architected Framework

## Decision

We adopt a **Three-Layer Enterprise AI Architecture** with explicit build order:

![Three-Layer Enterprise AI Architecture](../../diagrams/png/three-layer-architecture-overview.png)

> **Full Framework Documentation**: See the [Three-Layer Framework Whitepaper](../../diagrams/pdf/three-layer-framework-whitepaper.pdf) for comprehensive methodology, industry validation, and implementation guidance.

### Build Order Rationale

1. **Layer 3 First** (Infrastructure)
   - Landing zone provides consistent, secure foundation
   - Network topology enables private connectivity
   - Security baseline prevents retrofitting
   - Observability enables troubleshooting from day one

2. **Layer 2 Second** (Intelligence)
   - Data platform requires infrastructure in place
   - AI services need data to be useful
   - ML models require training data
   - RAG patterns need knowledge bases

3. **Layer 1 Last** (Experience)
   - User interfaces should expose existing capabilities
   - Adoption requires polished, valuable experiences
   - Iterating on UX is faster than iterating on data models
   - Business users can validate value before major investment

### Layer Composition

**Layer 1: End User Experience**
- Power Apps / Power Pages (low-code)
- Copilot Studio (conversational AI)
- Custom web applications
- Teams integrations
- Mobile applications

**Layer 2: Organizational Intelligence**
- Azure Synapse / Databricks (data platform)
- Azure OpenAI (generative AI)
- Azure AI Search (knowledge retrieval)
- Azure ML (custom models)
- Data Factory (integration)
- Microsoft Purview (governance)

**Layer 3: Infrastructure & Operations**
- Virtual Networks (hub-spoke)
- Azure Firewall / NSGs (security)
- Key Vault (secrets)
- Azure Monitor / Log Analytics (observability)
- Azure Policy (governance)
- Cost Management (FinOps)

## Consequences

### Positive

1. **Clear Prioritization**: Teams know what to build first
2. **Reduced Rework**: Infrastructure supports all future needs
3. **Data-First AI**: AI projects have data foundation
4. **User Validation**: UX built on proven capabilities
5. **Framework Alignment**: Maps to WAF, CAF, industry standards
6. **Reusable Patterns**: Each layer becomes repeatable

### Negative

1. **Longer Time to User Value**: Users see results last
2. **Upfront Investment**: Infrastructure costs before revenue
3. **Requires Discipline**: Temptation to skip to Layer 1
4. **Complexity**: Three layers to understand and manage

### Neutral

1. **Training Required**: Teams must understand the framework
2. **Tooling Changes**: May require new skills (IaC, data engineering)
3. **Organizational Change**: May require new team structures

## Alternatives Considered

### Option A: Start with User Experience (Layer 1 First)

**Pros:**
- Faster time to user-visible value
- Easier to demo to stakeholders
- Lower initial investment

**Cons:**
- Technical debt from missing foundation
- Difficult to integrate with enterprise data
- Security retrofitting is expensive
- Doesn't scale

**Decision:** Rejected. Short-term gains create long-term problems.

### Option B: Flat Architecture (No Layers)

**Pros:**
- Simpler mental model
- Flexible ordering
- No prescribed sequence

**Cons:**
- No guidance on prioritization
- Teams make inconsistent decisions
- Harder to communicate architecture
- No clear boundaries

**Decision:** Rejected. Lack of structure leads to chaos.

### Option C: Two-Layer (Platform + Applications)

**Pros:**
- Simpler than three layers
- Clear platform vs. app boundary
- Common industry pattern

**Cons:**
- Doesn't call out AI/ML explicitly
- Conflates data and infrastructure
- Misses the intelligence layer importance

**Decision:** Rejected. AI deserves explicit architectural status.

## References

- [Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [Cloud Adoption Framework](https://learn.microsoft.com/azure/cloud-adoption-framework/)
- [Gartner Data and Analytics Framework](https://www.gartner.com/en/documents/4019837)
- [McKinsey Data Architecture](https://www.mckinsey.com/capabilities/mckinsey-digital/our-insights/how-to-build-a-data-architecture-to-drive-innovation)
- [MIT CISR Architecture](https://cisr.mit.edu/publication/2019_1001_DataMonetization_WoernerRoss)
