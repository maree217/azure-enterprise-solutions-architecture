# Azure OpenAI RAG Patterns

## Retrieval-Augmented Generation for Enterprise

Production-ready patterns for building enterprise RAG applications with Azure OpenAI and Azure AI Search.

---

## Overview

RAG (Retrieval-Augmented Generation) combines the power of large language models with your organization's knowledge base, enabling AI assistants that provide accurate, grounded responses with citations.

---

## Reference Repositories

| Repository | Stars | Purpose |
|------------|-------|---------|
| [azure-search-openai-demo](https://github.com/maree217/azure-search-openai-demo) | 7,464 | Complete RAG reference implementation |
| [GPT-RAG](https://github.com/maree217/GPT-RAG) | 1,112 | Enterprise-scale secure RAG |

---

## Architecture Patterns

### Pattern 1: Basic RAG

Simple question-answering over documents.

```
┌─────────────────────────────────────────────────────────────────┐
│                         BASIC RAG                                │
└─────────────────────────────────────────────────────────────────┘

User Query: "What is the return policy?"
         │
         ↓
┌─────────────────┐
│  1. EMBED       │  Query → Vector [0.12, -0.34, ...]
│  (ada-002)      │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  2. RETRIEVE    │  Find top-k similar chunks
│  (AI Search)    │  Similarity threshold: 0.7
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  3. GENERATE    │  System: "Answer based on context only"
│  (GPT-4)        │  Context: [retrieved chunks]
└────────┬────────┘  Query: "What is the return policy?"
         │
         ↓
Response: "Our return policy allows..."
         + Citations: [doc1.pdf, page 5]
```

**Best for**: Internal knowledge bases, FAQ systems, documentation search

**Azure Services**:
- Azure OpenAI (ada-002 for embeddings, GPT-4 for generation)
- Azure AI Search (vector index)
- Azure Blob Storage (document storage)

---

### Pattern 2: Advanced RAG with Hybrid Search

Combines vector search with keyword search for better recall.

```
┌─────────────────────────────────────────────────────────────────┐
│                      HYBRID RAG                                  │
└─────────────────────────────────────────────────────────────────┘

User Query: "ISO 27001 compliance requirements"
         │
         ├──────────────────────┬───────────────────┐
         ↓                      ↓                   ↓
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│  VECTOR SEARCH  │  │  KEYWORD SEARCH │  │ SEMANTIC RANKING│
│  (Embeddings)   │  │  (BM25)         │  │  (Reranker)     │
└────────┬────────┘  └────────┬────────┘  └────────┬────────┘
         │                    │                    │
         └──────────┬─────────┴──────────┬─────────┘
                    ↓                    │
         ┌─────────────────┐             │
         │  RECIPROCAL     │←────────────┘
         │  RANK FUSION    │  Combine & rerank results
         └────────┬────────┘
                  ↓
         ┌─────────────────┐
         │  TOP-K CHUNKS   │  Best of both approaches
         └────────┬────────┘
                  ↓
         ┌─────────────────┐
         │  GENERATE       │
         │  (GPT-4)        │
         └─────────────────┘
```

**Best for**: Technical documentation, legal documents, mixed content types

**Configuration**:
```json
{
  "search": {
    "vectorWeight": 0.5,
    "keywordWeight": 0.3,
    "semanticWeight": 0.2
  },
  "retrieval": {
    "topK": 10,
    "minScore": 0.7
  }
}
```

---

### Pattern 3: Multi-Index RAG

Searches across multiple specialized indexes.

```
┌─────────────────────────────────────────────────────────────────┐
│                     MULTI-INDEX RAG                              │
└─────────────────────────────────────────────────────────────────┘

User Query: "What discounts apply to enterprise contracts?"
         │
         ↓
┌─────────────────┐
│  QUERY ROUTER   │  Analyze query intent
│  (GPT-4)        │  → [pricing, contracts, policies]
└────────┬────────┘
         │
    ┌────┴────┬──────────┐
    ↓         ↓          ↓
┌───────┐ ┌───────┐ ┌───────┐
│PRICING│ │CONTRACTS│ │POLICY│
│ INDEX │ │ INDEX  │ │INDEX │
└───┬───┘ └───┬───┘ └───┬───┘
    │         │         │
    └────┬────┴────┬────┘
         ↓         ↓
┌─────────────────────────┐
│  AGGREGATE & DEDUPE     │
│  Remove duplicates      │
│  Rank by relevance      │
└───────────┬─────────────┘
            ↓
┌─────────────────────────┐
│  GENERATE WITH CONTEXT  │
│  Include source index   │
└─────────────────────────┘
```

**Best for**: Large enterprises with domain-specific knowledge bases

---

### Pattern 4: Agentic RAG

AI agent decides when and how to retrieve information.

```
┌─────────────────────────────────────────────────────────────────┐
│                      AGENTIC RAG                                 │
└─────────────────────────────────────────────────────────────────┘

User: "Compare our Q3 results with competitors and suggest strategy"
         │
         ↓
┌─────────────────────────────────────────────────────────────────┐
│                    AI AGENT (GPT-4)                              │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  Planning:                                               │    │
│  │  1. Get our Q3 financial data                           │    │
│  │  2. Search for competitor reports                       │    │
│  │  3. Analyze market trends                               │    │
│  │  4. Generate strategic recommendations                  │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
         │
         ├──────────────┬──────────────┬──────────────┐
         ↓              ↓              ↓              ↓
    ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐
    │Financial│   │Competitor│   │ Market  │   │Strategy │
    │Database │   │ Reports │   │  News   │   │Templates│
    └─────────┘   └─────────┘   └─────────┘   └─────────┘
         │              │              │              │
         └──────────────┴──────────────┴──────────────┘
                              ↓
                    ┌─────────────────┐
                    │  SYNTHESIZE     │
                    │  Multi-step     │
                    │  reasoning      │
                    └─────────────────┘
```

**Best for**: Complex queries, multi-step reasoning, research tasks

**Technologies**: Semantic Kernel, LangChain, AutoGen

---

## Chunking Strategies

### Strategy Comparison

| Strategy | Chunk Size | Overlap | Best For |
|----------|------------|---------|----------|
| **Fixed Size** | 512-1024 tokens | 10-20% | General documents |
| **Sentence** | Variable | 1-2 sentences | Conversational content |
| **Paragraph** | Variable | None | Well-structured docs |
| **Semantic** | Variable | Context-aware | Technical documentation |
| **Hierarchical** | Parent/child | Linked | Long documents |

### Recommended Configuration

```python
# Optimal chunking for most use cases
chunking_config = {
    "strategy": "semantic",
    "max_chunk_size": 512,  # tokens
    "min_chunk_size": 100,  # tokens
    "overlap": 50,          # tokens
    "separators": ["\n\n", "\n", ". ", " "],
    "metadata_fields": ["title", "section", "page_number"]
}
```

### Hierarchical Chunking

```
┌─────────────────────────────────────────────────────────────────┐
│                    DOCUMENT                                      │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  PARENT CHUNK (2000 tokens)                              │   │
│  │  Contains full context for a section                     │   │
│  │                                                          │   │
│  │  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐        │   │
│  │  │   CHILD 1   │ │   CHILD 2   │ │   CHILD 3   │        │   │
│  │  │ (500 tokens)│ │ (500 tokens)│ │ (500 tokens)│        │   │
│  │  └─────────────┘ └─────────────┘ └─────────────┘        │   │
│  │                                                          │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘

Search: Match on child chunks
Return: Parent chunk for full context
```

---

## Prompt Engineering

### System Prompt Template

```
You are an AI assistant for [COMPANY NAME]. Your role is to help employees
find information from our internal knowledge base.

INSTRUCTIONS:
1. Only answer questions based on the provided context
2. If the context doesn't contain the answer, say "I don't have information about that"
3. Always cite your sources using [Source: document_name, page X]
4. Be concise but complete
5. If asked about topics outside the knowledge base, redirect appropriately

CONTEXT:
{retrieved_chunks}

CONVERSATION HISTORY:
{chat_history}

USER QUESTION:
{user_query}

Please provide a helpful, accurate response based on the context above.
```

### Few-Shot Examples

```
Example 1:
User: What's the vacation policy?
Assistant: According to our HR Policy Manual, employees receive:
- 15 days in year 1
- 20 days in years 2-5
- 25 days after 5 years

[Source: HR Policy Manual, Section 4.2]

Example 2:
User: What's the weather today?
Assistant: I'm designed to help with internal company information. For weather,
please check a weather service. Is there anything about company policies or
procedures I can help you with?
```

---

## Evaluation Framework

### Metrics to Track

| Metric | Description | Target |
|--------|-------------|--------|
| **Retrieval Precision** | Relevant docs in top-k | >80% |
| **Retrieval Recall** | All relevant docs found | >70% |
| **Answer Relevance** | Response addresses query | >90% |
| **Faithfulness** | Response grounded in context | >95% |
| **Citation Accuracy** | Correct source attribution | >98% |
| **Latency** | End-to-end response time | <3s |

### Evaluation Dataset

```json
{
  "test_cases": [
    {
      "id": "001",
      "query": "What is the return policy?",
      "expected_sources": ["returns_policy.pdf"],
      "expected_answer_contains": ["30 days", "full refund"],
      "category": "policy"
    },
    {
      "id": "002",
      "query": "How do I submit an expense report?",
      "expected_sources": ["expense_guide.pdf", "finance_faq.pdf"],
      "expected_answer_contains": ["Concur", "receipt", "approval"],
      "category": "process"
    }
  ]
}
```

### Automated Evaluation Pipeline

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Test       │ →  │  RAG        │ →  │  Evaluate   │
│  Dataset    │    │  System     │    │  (GPT-4)    │
└─────────────┘    └─────────────┘    └─────────────┘
                                            │
                                            ↓
                                    ┌─────────────┐
                                    │  Metrics    │
                                    │  Dashboard  │
                                    └─────────────┘
```

---

## Security Considerations

### Data Access Control

```
┌─────────────────────────────────────────────────────────────────┐
│                    SECURITY LAYERS                               │
└─────────────────────────────────────────────────────────────────┘

1. AUTHENTICATION
   └── Entra ID → User identity verified

2. AUTHORIZATION
   └── Security filters in AI Search
   └── Document-level permissions

3. DATA PROTECTION
   └── Encryption at rest (CMK)
   └── Encryption in transit (TLS 1.3)
   └── Private endpoints

4. AUDIT
   └── Query logging
   └── Access tracking
   └── Compliance reports
```

### Security Filters

```python
# Filter search results by user's security groups
security_filter = f"security_groups/any(g: g eq '{user_group}')"

search_results = search_client.search(
    query_vector=embedding,
    filter=security_filter,
    top=10
)
```

---

## Cost Optimization

### Token Management

| Component | Cost Driver | Optimization |
|-----------|-------------|--------------|
| **Embeddings** | Input tokens | Batch processing, caching |
| **Search** | Index size, queries | Optimize chunk size |
| **Generation** | Input + output tokens | Prompt compression |

### Cost Calculation Example

```
Monthly Usage: 100,000 queries
Average tokens per query: 2,000 (context) + 500 (response)

Embedding costs:
- 100K queries × 100 tokens/query = 10M tokens
- 10M tokens × $0.0001/1K = $1.00

Generation costs (GPT-4):
- Input: 100K × 2,000 tokens = 200M tokens × $0.03/1K = $6,000
- Output: 100K × 500 tokens = 50M tokens × $0.06/1K = $3,000

Total: ~$9,000/month

Optimizations:
- Cache frequent queries: -30%
- Compress prompts: -20%
- Use GPT-4-turbo: -40%
Optimized: ~$3,600/month
```

---

## Implementation Checklist

### Phase 1: Foundation (Week 1-2)

- [ ] Deploy Azure AI Search
- [ ] Deploy Azure OpenAI (ada-002, GPT-4)
- [ ] Set up Blob Storage for documents
- [ ] Configure Private Endpoints
- [ ] Set up authentication

### Phase 2: Data Pipeline (Week 3-4)

- [ ] Build document ingestion pipeline
- [ ] Implement chunking strategy
- [ ] Generate embeddings (batch)
- [ ] Create vector index
- [ ] Configure semantic ranking

### Phase 3: Application (Week 5-6)

- [ ] Build chat interface
- [ ] Implement RAG logic
- [ ] Add citation extraction
- [ ] Configure conversation memory
- [ ] Implement error handling

### Phase 4: Production (Week 7-8)

- [ ] Set up monitoring
- [ ] Implement evaluation pipeline
- [ ] Configure auto-scaling
- [ ] Security review
- [ ] User acceptance testing
- [ ] Documentation

---

## Key Resources

### Microsoft Documentation

- [Azure AI Search RAG Tutorial](https://learn.microsoft.com/azure/search/retrieval-augmented-generation-overview)
- [Azure OpenAI on your data](https://learn.microsoft.com/azure/ai-services/openai/concepts/use-your-data)
- [Vector Search](https://learn.microsoft.com/azure/search/vector-search-overview)

### Sample Code

- [azure-search-openai-demo](https://github.com/Azure-Samples/azure-search-openai-demo)
- [GPT-RAG](https://github.com/Azure/GPT-RAG)
- [chat-with-your-data-solution-accelerator](https://github.com/Azure-Samples/chat-with-your-data-solution-accelerator)

---

## Three-Layer Framework Mapping

| RAG Component | Framework Layer | Purpose |
|---------------|-----------------|---------|
| Vector Index | Layer 2 | Memory storage |
| Search Service | Layer 2 | Knowledge retrieval |
| LLM Generation | Layer 3 | Strategic intelligence |
| Chat Interface | Layer 1 | User experience |
| Security Filters | Governance | Access control |
