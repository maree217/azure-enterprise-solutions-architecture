# Architecture Diagrams

Visual representations of key Azure enterprise architecture patterns.

---

## Directory Structure

```
diagrams/
├── png/                    # PNG images for documentation
├── pdf/                    # PDF documents and whitepapers
├── svg/                    # SVG vectors (future)
└── drawio/                 # Source files (future)
```

---

## Available Diagrams

### Core Framework

| Diagram | Description | Use Case |
|---------|-------------|----------|
| [Three-Layer Architecture Overview](png/three-layer-architecture-overview.png) | Complete view of Layer 1/2/3 with Azure services | Executive presentations, framework introduction |
| [Three-Layer Framework Whitepaper](pdf/three-layer-framework-whitepaper.pdf) | Comprehensive 21-page framework guide | Business leaders, decision makers |

### Infrastructure & Networking

| Diagram | Description | Use Case |
|---------|-------------|----------|
| [Hub-Spoke Landing Zone Topology](png/hub-spoke-landing-zone-topology.png) | Enterprise network architecture with hub VNet and spoke segmentation | Network design, landing zone planning |
| [Management Group Hierarchy](png/management-group-hierarchy.png) | Azure management group structure with policy inheritance | Governance planning, subscription organization |

### Data & AI

| Diagram | Description | Use Case |
|---------|-------------|----------|
| [RAG Architecture](png/rag-architecture.png) | Retrieval-Augmented Generation pattern with Azure OpenAI and AI Search | AI solution design, knowledge base implementation |
| [Medallion Data Architecture](png/medallion-data-architecture.png) | Bronze/Silver/Gold data layers with Azure data services | Data platform design, lakehouse architecture |

### Industry-Specific

| Diagram | Description | Use Case |
|---------|-------------|----------|
| [Healthcare HIPAA Architecture](png/healthcare-hipaa-architecture.png) | HIPAA/HITRUST compliant architecture with Azure Health Data Services | Healthcare solution design, compliance planning |
| [Financial Services PCI-DSS Architecture](png/financial-services-pci-dss-architecture.png) | PCI-DSS network segmentation with three security zones | Financial services, payment processing |

---

## Usage Guidelines

### Embedding in Documentation

```markdown
![Three-Layer Architecture](diagrams/png/three-layer-architecture-overview.png)
```

### Presentations

- Use PNG files for slide decks
- PDF whitepaper for detailed handouts
- High resolution suitable for print

### Customization

For custom modifications:
1. Contact repository maintainers
2. Reference original design specifications
3. Maintain Azure brand guidelines

---

## Design Standards

All diagrams follow:

- **Azure Architecture Icons**: Official Microsoft icon set
- **Color Palette**: Azure blue (#0078D4), supporting gradients
- **Typography**: Clean sans-serif fonts
- **Resolution**: Minimum 1920x1080 for PNG
- **Versioning**: Date stamps in diagram corners

---

## Related Documentation

- [Three-Layer Architecture Framework](../docs/frameworks/three-layer-architecture.md)
- [Landing Zone Patterns](../landing-zones/README.md)
- [Industry Solutions](../industry-solutions/README.md)
- [Architecture Decision Records](../docs/architecture-decisions/README.md)

---

*Diagrams created: November 2024*
*Repository: azure-enterprise-solutions-architecture*
