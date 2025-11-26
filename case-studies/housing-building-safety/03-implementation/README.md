# Implementation

## Meridian Housing Group - Delivery Approach

*Implementation following the [Three-Layer Framework](../../../three-layer-overlay/README.md) phased delivery methodology.*

---

## Overview

The Building Safety Platform was delivered using a phased approach, building from infrastructure (Layer 3) through intelligence (Layer 2) to experience (Layer 1). Each phase delivered measurable value while establishing foundations for subsequent phases.

**Delivery Principles:**
- Foundation before features
- Incremental value delivery
- Risk-based prioritisation
- User-centric design
- Continuous integration

---

## Implementation Documents

| Document | Purpose | Audience |
|----------|---------|----------|
| [Delivery Roadmap](delivery-roadmap.md) | Phase timeline and milestones | PMO, Stakeholders |
| [Phase 1: Foundation](phase-1-foundation.md) | Infrastructure and connectivity | IT, Architecture |
| [Phase 2: Intelligence](phase-2-intelligence.md) | Data platform build | Data, Integration |
| [Phase 3: Experience](phase-3-experience.md) | Application delivery | Development, UX |
| [Change Management](change-management.md) | User adoption approach | Change, Training |

---

## Programme Structure

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     PROGRAMME STRUCTURE                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  STEERING GROUP                                                              │
│  ├── Sponsor: Director of Housing                                           │
│  ├── Senior User: Director of Building Safety (Sarah Chen)                  │
│  ├── Senior Supplier: IT Manager (James Morton)                             │
│  └── Meets: Monthly                                                         │
│                                                                              │
│  PROJECT BOARD                                                               │
│  ├── Project Manager: [PM Name]                                             │
│  ├── Technical Lead: [Tech Lead]                                            │
│  ├── Business Lead: Marcus Williams (Building Safety Manager)               │
│  └── Meets: Fortnightly                                                     │
│                                                                              │
│  DELIVERY TEAM                                                               │
│  ├── Solution Architect (Partner)                                           │
│  ├── Data Engineer (Partner)                                                │
│  ├── Power Platform Developer x2 (Partner)                                  │
│  ├── Integration Developer (Partner)                                        │
│  ├── Business Analyst                                                       │
│  ├── Test Lead                                                              │
│  └── Change Lead                                                            │
│                                                                              │
│  WORKSTREAMS                                                                 │
│  ├── Infrastructure & Security                                              │
│  ├── Data & Integration                                                     │
│  ├── Application Development                                                │
│  └── Change & Adoption                                                      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Timeline Summary

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        IMPLEMENTATION TIMELINE                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  2024                                                                        │
│  │                                                                          │
│  │  Q1: ASSESSMENT & PLANNING                                               │
│  │  ├── Jan: Stakeholder interviews, requirements                          │
│  │  ├── Feb: Architecture design, business case                            │
│  │  └── Mar: Procurement, team mobilisation                                │
│  │                                                                          │
│  │  Q2: PHASE 1 - FOUNDATION (Layer 3)                                     │
│  │  ├── Apr: Azure Landing Zone deployment                                 │
│  │  ├── May: Security configuration, Northgate connectivity                │
│  │  └── Jun: Integration platform, monitoring                              │
│  │                                                                          │
│  │  Q3: PHASE 2a - INTELLIGENCE (Layer 2)                                  │
│  │  ├── Jul: Fabric Lakehouse, Bronze layer                               │
│  │  ├── Aug: Silver/Gold layers, data quality                             │
│  │  └── Sep: Document platform, AI Search                                  │
│  │                                                                          │
│  │  Q4: PHASE 2b - INTELLIGENCE CONTINUED                                  │
│  │  ├── Oct: Dataverse configuration, sync                                 │
│  │  ├── Nov: Analytics, Power BI dashboards                                │
│  │  └── Dec: Phase 2 UAT, go-live preparation                              │
│  │                                                                          │
│  2025                                                                        │
│  │                                                                          │
│  │  Q1: PHASE 3a - EXPERIENCE (Layer 1)                                    │
│  │  ├── Jan: Staff portal development                                      │
│  │  ├── Feb: Mobile app development                                        │
│  │  └── Mar: Staff portal UAT, pilot                                       │
│  │                                                                          │
│  │  Q2: PHASE 3b - EXPERIENCE CONTINUED                                    │
│  │  ├── Apr: Resident portal development                                   │
│  │  ├── May: Compliance Copilot, refinements                               │
│  │  └── Jun: Full rollout, project closure                                 │
│  │                                                                          │
│  ▼                                                                          │
│  HYPERCARE & TRANSITION TO SUPPORT                                          │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Phase Summary

### Phase 1: Foundation (Q2 2024)

| Deliverable | Description | Duration |
|-------------|-------------|----------|
| Azure Landing Zone | Subscriptions, resource groups, governance | 4 weeks |
| Identity Configuration | Security groups, Conditional Access, PIM | 2 weeks |
| Network Connectivity | VPN to on-premises, private endpoints | 3 weeks |
| Integration Platform | Logic Apps, API Management, Key Vault | 3 weeks |
| Monitoring | Log Analytics, alerts, dashboards | 2 weeks |

**Phase 1 Exit Criteria:**
- [ ] Secure connectivity to Northgate established
- [ ] Test data flow from Northgate to Azure validated
- [ ] Security controls in place and tested
- [ ] Monitoring operational

---

### Phase 2: Intelligence (Q3-Q4 2024)

| Deliverable | Description | Duration |
|-------------|-------------|----------|
| Fabric Lakehouse | Bronze/Silver/Gold layers | 6 weeks |
| Data Integrations | Northgate, Gas-Track, Keystone, Promaster | 8 weeks |
| Document Platform | SharePoint structure, Document Intelligence | 4 weeks |
| AI Search | Golden thread index, semantic search | 3 weeks |
| Dataverse | Operational data store, sync | 4 weeks |
| Analytics | Power BI semantic model, dashboards | 4 weeks |

**Phase 2 Exit Criteria:**
- [ ] All source systems integrated and syncing
- [ ] Data quality metrics meeting targets (>95%)
- [ ] Executive dashboard operational
- [ ] Document search functional

---

### Phase 3: Experience (Q1-Q2 2025)

| Deliverable | Description | Duration |
|-------------|-------------|----------|
| Staff Portal | Model-driven app for compliance team | 8 weeks |
| Mobile App | Canvas app with offline for surveyors | 6 weeks |
| Resident Portal | Power Pages for resident engagement | 6 weeks |
| Compliance Copilot | AI assistant in Teams/Portal | 4 weeks |
| Contractor Portal | Upload portal for external partners | 3 weeks |

**Phase 3 Exit Criteria:**
- [ ] Staff portal in use by compliance team
- [ ] Mobile app deployed to all surveyors
- [ ] Resident portal launched to high-rise residents
- [ ] User satisfaction >80%

---

## Governance

### Decision Log

| ID | Decision | Date | Rationale | Impact |
|----|----------|------|-----------|--------|
| D001 | Keep Northgate as core HMS | Jan 2024 | Staff familiarity, cost avoidance | Integrate not replace |
| D002 | Use Microsoft Fabric over Synapse | Feb 2024 | Right-sized, Power Platform native | Simpler architecture |
| D003 | Power Platform for all apps | Feb 2024 | Speed, M365 integration | Skills development needed |
| D004 | Phase resident portal after staff | Mar 2024 | Foundation data quality first | Delayed resident benefit |

### Risk Register (Top Risks)

| ID | Risk | Likelihood | Impact | Mitigation |
|----|------|------------|--------|------------|
| R001 | Northgate integration complexity | Medium | High | Early proof of concept |
| R002 | Data quality worse than assessed | Medium | High | Extended cleansing phase |
| R003 | User adoption resistance | Medium | Medium | Early engagement, champions |
| R004 | Skills gap in IT team | High | Medium | Partner-led, knowledge transfer |
| R005 | Scope creep | Medium | Medium | Strong change control |

### Change Control

All scope changes follow the process:
1. Change Request raised (any team member)
2. Impact Assessment (Tech Lead, BA)
3. Board Review (if cost >£5K or timeline impact)
4. Decision recorded in Change Log
5. Backlog updated

---

## Quality Approach

### Testing Strategy

| Test Type | Scope | Timing | Responsibility |
|-----------|-------|--------|----------------|
| Unit Testing | Individual components | During build | Developers |
| Integration Testing | End-to-end data flow | Post integration | Test Lead |
| System Testing | Full platform | Pre-UAT | Test Lead |
| UAT | Business scenarios | Per phase | Business users |
| Performance Testing | Load and stress | Pre-go-live | Partner |
| Security Testing | Penetration test | Post Phase 1 | External |

### Definition of Done

- [ ] Code/configuration complete and peer reviewed
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] Documentation updated
- [ ] Security review completed
- [ ] Acceptance criteria verified
- [ ] Deployed to test environment
- [ ] Test cases executed and passed

---

## Budget Summary

### Capital Costs (Implementation)

| Category | Budget | Notes |
|----------|--------|-------|
| Partner Delivery | £180,000 | Architecture, development, PM |
| Internal Resources | £60,000 | BA, Test Lead, Change Lead |
| Licences (Year 1) | £30,000 | Power Platform, additional |
| Infrastructure | £10,000 | Initial Azure setup |
| **Total Capital** | **£280,000** | |

### Operational Costs (Ongoing)

| Category | Annual | Notes |
|----------|--------|-------|
| Azure Consumption | £30,600 | Fabric, AI, Logic Apps |
| Power Platform Licences | £28,400 | Per-user and capacity |
| Support Contract | £24,000 | Partner support |
| **Total Annual** | **~£83,000** | |

---

## Success Metrics

### Phase 1 Success Metrics

| Metric | Target | Measure |
|--------|--------|---------|
| Northgate connectivity | 99.9% uptime | Azure Monitor |
| Data refresh latency | <1 hour | Pipeline metrics |
| Security incidents | 0 critical | Defender for Cloud |

### Phase 2 Success Metrics

| Metric | Target | Measure |
|--------|--------|---------|
| Data quality score | >95% | DQ dashboard |
| Integration success rate | >99% | Pipeline metrics |
| Dashboard load time | <5 seconds | Power BI metrics |

### Phase 3 Success Metrics

| Metric | Target | Measure |
|--------|--------|---------|
| User adoption (staff) | >80% | Portal analytics |
| User satisfaction | >80% | Survey |
| Time to answer compliance query | <5 minutes | User feedback |
| Resident portal registrations | 30% of eligible | Portal analytics |

---

## Next Steps

1. Review [Delivery Roadmap](delivery-roadmap.md) for detailed milestones
2. Understand [Phase 1: Foundation](phase-1-foundation.md) activities
3. See [Change Management](change-management.md) for adoption approach

---

*Implementation Version: 1.0*
*Last Updated: [Date]*
