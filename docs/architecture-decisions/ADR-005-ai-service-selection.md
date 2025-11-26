# ADR-005: AI Service Selection for Enterprise

## Status
Accepted

## Date
2024-01-15

## Context

Enterprises adopting AI need to select appropriate Azure AI services. Options include:

1. **Azure OpenAI** - GPT models for generative AI
2. **Azure AI Search** - Cognitive search with semantic ranking
3. **Azure Machine Learning** - Custom model development
4. **Azure AI Services** - Pre-built AI capabilities
5. **Copilot Studio** - Low-code conversational AI

The choice impacts:
- Development complexity
- Time to value
- Customization options
- Cost structure
- Skill requirements
- Compliance posture

## Decision

We adopt an **AI capability stack** aligned with the Three-Layer Architecture:

```
┌─────────────────────────────────────────────────────────────────┐
│                    AI CAPABILITY STACK                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  LAYER 1: USER INTERFACES                                       │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ Copilot Studio │ Power Apps │ Custom Web │ Teams Apps   │    │
│  └─────────────────────────────────────────────────────────┘    │
│                           │                                      │
│  LAYER 2: AI SERVICES                                           │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐   │    │
│  │ │  Azure OpenAI │ │ Azure AI      │ │ Azure ML      │   │    │
│  │ │  (Generation) │ │ Search (RAG)  │ │ (Custom)      │   │    │
│  │ └───────────────┘ └───────────────┘ └───────────────┘   │    │
│  │ ┌───────────────┐ ┌───────────────┐                     │    │
│  │ │ Document      │ │ Speech        │                     │    │
│  │ │ Intelligence  │ │ Services      │                     │    │
│  │ └───────────────┘ └───────────────┘                     │    │
│  └─────────────────────────────────────────────────────────┘    │
│                           │                                      │
│  LAYER 3: DATA FOUNDATION                                       │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ Data Lake │ Vector Store │ Knowledge Base │ Audit Logs  │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Service Selection by Use Case

| Use Case | Primary Service | Supporting Services |
|----------|-----------------|---------------------|
| **Conversational AI** | Azure OpenAI (GPT-4o) | AI Search, Copilot Studio |
| **Document Processing** | Document Intelligence | Azure OpenAI, Storage |
| **Knowledge Retrieval (RAG)** | AI Search + OpenAI | Blob Storage, Embeddings |
| **Custom ML Models** | Azure ML | Databricks, MLflow |
| **Voice/Speech** | Speech Services | Azure OpenAI |
| **Translation** | Translator | Azure OpenAI |
| **Vision/OCR** | Computer Vision | Document Intelligence |

### RAG Pattern (Primary Pattern)

For most enterprise AI use cases, we recommend the RAG (Retrieval-Augmented Generation) pattern:

![RAG (Retrieval-Augmented Generation) Architecture](../../diagrams/png/rag-architecture.png)

The diagram above shows both flows:

**Data Ingestion Flow (Left)**:
1. Documents from PDF, Word, SharePoint sources
2. Document Intelligence for chunking/extraction
3. Embedding Model (text-embedding-3-large) for vectorization
4. Azure AI Search as the vector store

**Query Flow (Right)**:
1. User query embedded using the same model
2. Vector search retrieves relevant context
3. Azure OpenAI GPT-4o generates response with retrieved context
4. Response returned to user

**Security**: All services operate within a Private Endpoints / VNet Integration boundary (green dashed box).

### Model Selection Guidelines

| Model | Use Case | Tokens/min | Cost Tier |
|-------|----------|------------|-----------|
| GPT-4o | Complex reasoning, multi-modal | 10K-150K | High |
| GPT-4o-mini | Cost-optimized chat | 10K-150K | Medium |
| text-embedding-3-large | High-quality embeddings | 10K-150K | Low |
| text-embedding-3-small | Cost-optimized embeddings | 10K-150K | Very Low |

### Security Requirements

All AI deployments must include:

1. **Private Endpoints**: No public internet exposure
2. **Content Filtering**: Azure OpenAI content filters enabled
3. **Audit Logging**: All API calls logged
4. **Rate Limiting**: Prevent abuse
5. **Data Residency**: Ensure models in required region

## Consequences

### Positive

1. **Clear Stack**: Developers know which services to use
2. **RAG by Default**: Proven pattern for knowledge AI
3. **Security First**: Enterprise requirements built in
4. **Cost Optimization**: Model selection guidance
5. **Azure Native**: Full platform integration

### Negative

1. **Model Availability**: Some models region-restricted
2. **Quota Management**: TPM limits require planning
3. **Cost Monitoring**: Token-based pricing needs tracking
4. **Skill Development**: New AI skills required

### Neutral

1. **Rapid Evolution**: Services change frequently
2. **Competitive Landscape**: Other cloud AI services exist
3. **Open Source Options**: Hugging Face, LangChain alternatives

## Alternatives Considered

### Option A: Custom LLM (Self-Hosted)

**Pros:**
- Full control
- No per-token costs
- Data stays on-premises

**Cons:**
- High infrastructure cost
- Maintenance burden
- Slower to adopt new models
- GPU availability challenges

**Decision:** Rejected. Azure OpenAI provides better value for most cases.

### Option B: Third-Party AI (OpenAI Direct, Anthropic)

**Pros:**
- Latest models immediately
- Different capabilities
- Competitive features

**Cons:**
- Data leaves Azure
- Separate security model
- Additional vendor
- Compliance complexity

**Decision:** Rejected. Azure OpenAI provides enterprise integration.

### Option C: Pre-Built Copilots Only

**Pros:**
- Fastest deployment
- No development needed
- Microsoft managed

**Cons:**
- Limited customization
- Fixed use cases
- Less differentiation

**Decision:** Rejected as primary, but included in stack where appropriate.

## Implementation Checklist

### Phase 1: Foundation

- [ ] Deploy Azure OpenAI in appropriate region
- [ ] Configure private endpoint
- [ ] Enable content filtering
- [ ] Set up audit logging
- [ ] Deploy embedding model

### Phase 2: Knowledge Base

- [ ] Deploy Azure AI Search
- [ ] Configure vector search
- [ ] Create data ingestion pipeline
- [ ] Implement chunking strategy
- [ ] Deploy semantic ranking

### Phase 3: Application

- [ ] Build RAG orchestration
- [ ] Implement prompt engineering
- [ ] Add response validation
- [ ] Deploy user interface
- [ ] Configure monitoring

### Phase 4: Operations

- [ ] Set up cost monitoring
- [ ] Configure rate limiting
- [ ] Implement caching
- [ ] Deploy A/B testing
- [ ] Establish feedback loop

## References

- [Azure OpenAI Service](https://learn.microsoft.com/azure/ai-services/openai/)
- [Azure AI Search](https://learn.microsoft.com/azure/search/)
- [RAG Pattern](https://learn.microsoft.com/azure/search/retrieval-augmented-generation-overview)
- [Azure Machine Learning](https://learn.microsoft.com/azure/machine-learning/)
- [Responsible AI](https://learn.microsoft.com/azure/ai-services/openai/concepts/content-filter)
