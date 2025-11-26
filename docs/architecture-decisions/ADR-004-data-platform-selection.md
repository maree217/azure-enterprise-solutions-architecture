# ADR-004: Modern Data Platform Selection

## Status
Accepted

## Date
2024-01-15

## Context

Layer 2 (Organizational Intelligence) requires a modern data platform. Azure offers multiple options:

1. **Azure Synapse Analytics** - Unified analytics service
2. **Azure Databricks** - Apache Spark-based platform
3. **Microsoft Fabric** - SaaS unified analytics
4. **Azure Data Factory** - ETL/ELT orchestration
5. **Hybrid approaches** - Combinations of the above

The choice impacts:
- Data engineering capabilities
- Analytics and BI performance
- Machine learning integration
- Cost model
- Skill requirements
- Vendor relationship

## Decision

We adopt a **workload-based selection approach** with three patterns:

### Pattern A: Synapse-Centric (Enterprise Data Warehouse Focus)

```
┌─────────────────────────────────────────────────────────────────┐
│                    SYNAPSE-CENTRIC PATTERN                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                 AZURE SYNAPSE ANALYTICS                   │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │ Dedicated   │  │ Serverless  │  │   Spark     │       │   │
│  │  │ SQL Pool    │  │ SQL Pool    │  │   Pool      │       │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘       │   │
│  │  ┌─────────────┐  ┌─────────────┐                        │   │
│  │  │ Pipelines   │  │ Data        │                        │   │
│  │  │             │  │ Explorer    │                        │   │
│  │  └─────────────┘  └─────────────┘                        │   │
│  └──────────────────────────────────────────────────────────┘   │
│                           │                                      │
│                    ┌──────▼──────┐                              │
│                    │  ADLS Gen2  │                              │
│                    │  (Bronze,   │                              │
│                    │  Silver,    │                              │
│                    │  Gold)      │                              │
│                    └─────────────┘                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Best For:**
- SQL-heavy workloads
- Enterprise data warehouse modernization
- T-SQL skill sets
- Power BI integration
- Predictable query patterns

### Pattern B: Databricks-Centric (Data Engineering/ML Focus)

```
┌─────────────────────────────────────────────────────────────────┐
│                   DATABRICKS-CENTRIC PATTERN                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                   AZURE DATABRICKS                        │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │ Data        │  │ Machine     │  │ SQL         │       │   │
│  │  │ Engineering │  │ Learning    │  │ Analytics   │       │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘       │   │
│  │  ┌─────────────┐  ┌─────────────┐                        │   │
│  │  │ Delta       │  │ Unity       │                        │   │
│  │  │ Live Tables │  │ Catalog     │                        │   │
│  │  └─────────────┘  └─────────────┘                        │   │
│  └──────────────────────────────────────────────────────────┘   │
│                           │                                      │
│                    ┌──────▼──────┐                              │
│                    │  Delta Lake │                              │
│                    │  (ADLS Gen2)│                              │
│                    └─────────────┘                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Best For:**
- Complex data engineering
- Machine learning workloads
- Python/Scala skill sets
- Real-time streaming
- Multi-cloud requirements

### Pattern C: Microsoft Fabric (SaaS-First)

```
┌─────────────────────────────────────────────────────────────────┐
│                    FABRIC-CENTRIC PATTERN                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                   MICROSOFT FABRIC                        │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │ Data        │  │ Data        │  │ Data        │       │   │
│  │  │ Factory     │  │ Engineering │  │ Warehouse   │       │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘       │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │ Data        │  │ Real-Time   │  │ Power BI    │       │   │
│  │  │ Science     │  │ Analytics   │  │             │       │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘       │   │
│  └──────────────────────────────────────────────────────────┘   │
│                           │                                      │
│                    ┌──────▼──────┐                              │
│                    │  OneLake    │                              │
│                    │  (Unified)  │                              │
│                    └─────────────┘                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

**Best For:**
- Simplified administration
- Power BI-centric organizations
- Quick time to value
- Lower complexity tolerance
- Copilot integration

### Selection Matrix

| Criteria | Synapse | Databricks | Fabric |
|----------|---------|------------|--------|
| Data Warehouse | Excellent | Good | Good |
| Data Engineering | Good | Excellent | Good |
| Machine Learning | Good | Excellent | Good |
| Real-Time | Good | Excellent | Good |
| Administration | Moderate | Complex | Simple |
| Cost Model | Pay-per-use + reserved | DBU-based | Capacity |
| Power BI Integration | Native | Good | Native |
| Multi-Cloud | No | Yes | No |

## Consequences

### Positive

1. **Right Tool for Job**: Pattern matches workload requirements
2. **Clear Guidance**: Reduces decision paralysis
3. **Flexibility**: All patterns can coexist
4. **Evolution Path**: Can migrate between patterns
5. **Microsoft Alignment**: All are Microsoft strategic

### Negative

1. **Assessment Needed**: Must evaluate workload patterns
2. **Skill Variation**: Different platforms require different skills
3. **Integration Complexity**: Hybrid scenarios add complexity
4. **Cost Modeling**: Different billing models to understand

### Neutral

1. **Market Evolution**: Fabric is newest, still maturing
2. **Feature Parity**: Gaps between platforms narrowing
3. **Documentation**: All have extensive Microsoft docs

## Alternatives Considered

### Option A: Single Platform (Synapse Only)

**Pros:**
- Simpler training
- Unified experience
- Consistent cost model

**Cons:**
- Not optimal for all workloads
- Limited ML capabilities
- May not fit existing skills

**Decision:** Rejected. One size doesn't fit all.

### Option B: Non-Microsoft (Snowflake, BigQuery)

**Pros:**
- Multi-cloud native
- Strong communities
- Different feature sets

**Cons:**
- Additional vendor relationship
- Less Azure integration
- Separate governance

**Decision:** Rejected. Azure-native preferred for Azure-centric clients.

### Option C: Build Custom

**Pros:**
- Exact requirements match
- Full control
- No platform constraints

**Cons:**
- High build cost
- Maintenance burden
- Missing platform innovations

**Decision:** Rejected. Platforms provide significant value.

## Implementation: Medallion Architecture

All patterns should implement medallion architecture:

```
┌─────────────────────────────────────────────────────────────────┐
│                    MEDALLION ARCHITECTURE                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐         │
│  │   BRONZE    │───▶│   SILVER    │───▶│    GOLD     │         │
│  │   (Raw)     │    │  (Cleansed) │    │  (Curated)  │         │
│  │             │    │             │    │             │         │
│  │ • As-is     │    │ • Validated │    │ • Aggregated│         │
│  │ • Full      │    │ • Dedupe    │    │ • Modeled   │         │
│  │   history   │    │ • Conformed │    │ • Optimized │         │
│  └─────────────┘    └─────────────┘    └─────────────┘         │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## References

- [Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/)
- [Azure Databricks](https://learn.microsoft.com/azure/databricks/)
- [Microsoft Fabric](https://learn.microsoft.com/fabric/)
- [Medallion Architecture](https://learn.microsoft.com/azure/databricks/lakehouse/medallion)
- [Data Platform Comparison](https://learn.microsoft.com/azure/architecture/data-guide/)
