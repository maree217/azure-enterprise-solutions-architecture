# ADR-002: Azure Landing Zone Pattern Selection

## Status
Accepted

## Date
2024-01-15

## Context

Organizations deploying to Azure need a consistent, secure foundation. Microsoft provides multiple landing zone patterns:

1. **Azure Landing Zones (Enterprise-Scale)** - Full CAF implementation
2. **CAF Terraform Modules** - Terraform-based landing zone
3. **ALZ-Bicep** - Bicep-based landing zone
4. **Start Small** - Minimal viable landing zone
5. **Custom** - Organization-specific implementation

The choice impacts:
- Time to first workload
- Long-term maintainability
- Governance capabilities
- Team skill requirements
- Vendor lock-in

We need to decide which pattern to recommend as the default for enterprise clients.

## Decision

We adopt a **tiered recommendation approach** based on organizational maturity:

### Tier 1: Enterprise (>500 users, complex requirements)

**Recommendation:** Azure Landing Zones (Enterprise-Scale) via Terraform

```
Management Groups
├── Tenant Root Group
│   ├── Platform
│   │   ├── Management
│   │   ├── Connectivity
│   │   └── Identity
│   ├── Landing Zones
│   │   ├── Corp
│   │   └── Online
│   └── Decommissioned
```

**Rationale:**
- Full governance capabilities
- Comprehensive policy baseline
- Proven at scale
- Microsoft supported
- Terraform provides multi-cloud option

### Tier 2: Mid-Market (100-500 users)

**Recommendation:** ALZ-Bicep with simplified hierarchy

```
Management Groups
├── Tenant Root Group
│   ├── Platform
│   ├── Landing Zones
│   └── Sandbox
```

**Rationale:**
- Native Azure tooling (no external state)
- Simpler management group structure
- Faster to deploy
- Lower skill requirements

### Tier 3: Small Business (<100 users)

**Recommendation:** Start Small pattern with single subscription

```
Single Subscription
├── Resource Groups
│   ├── rg-networking
│   ├── rg-security
│   ├── rg-workload-prod
│   └── rg-workload-dev
```

**Rationale:**
- Minimal complexity
- Fast to implement
- Easy to manage
- Can evolve to Tier 2 later

### Implementation Priorities (All Tiers)

1. Hub-spoke networking
2. Centralized logging
3. Baseline Azure Policies
4. Key Vault for secrets
5. Defender for Cloud

## Consequences

### Positive

1. **Right-Sized Solutions**: Organizations get appropriate complexity
2. **Clear Guidance**: Reduces decision paralysis
3. **Upgrade Path**: Smaller orgs can grow into larger patterns
4. **Best Practices**: All tiers include security fundamentals
5. **IaC Ready**: All patterns support infrastructure as code

### Negative

1. **Assessment Required**: Must evaluate organization to select tier
2. **Training Varies**: Different skills for different tiers
3. **Migration Complexity**: Moving between tiers is non-trivial
4. **Maintenance**: Keeping up with Microsoft updates

### Neutral

1. **Microsoft Alignment**: Follows CAF recommendations
2. **Documentation**: Extensive Microsoft docs available
3. **Community**: Large community for all patterns

## Alternatives Considered

### Option A: Always Use Enterprise-Scale

**Pros:**
- Consistent approach
- Maximum governance
- Future-proof

**Cons:**
- Overkill for small orgs
- Complex for simple needs
- Higher skill requirements
- Slower time to value

**Decision:** Rejected. Not all organizations need full Enterprise-Scale.

### Option B: Always Use Custom

**Pros:**
- Tailored to each client
- No unnecessary complexity
- Flexible

**Cons:**
- No standardization
- Each implementation unique
- Higher maintenance
- No community support

**Decision:** Rejected. Standardization provides efficiency.

### Option C: Third-Party Landing Zone (Gruntwork, Pulumi)

**Pros:**
- Multi-cloud consistency
- Community support
- Different abstractions

**Cons:**
- Less Azure-native
- May lag Microsoft features
- Additional vendor relationship
- Different support model

**Decision:** Rejected. Microsoft-native patterns preferred for Azure-focused clients.

## Implementation Checklist

### All Tiers

- [ ] Define management group structure
- [ ] Deploy hub VNet with firewall/NVA
- [ ] Configure spoke VNet peering
- [ ] Enable Azure Monitor + Log Analytics
- [ ] Deploy Azure Policy baseline
- [ ] Configure Defender for Cloud
- [ ] Set up Key Vault
- [ ] Document naming conventions
- [ ] Implement tagging strategy

### Tier 1 Additional

- [ ] Configure PIM
- [ ] Deploy Sentinel
- [ ] Implement multi-region DR
- [ ] Configure regulatory compliance
- [ ] Deploy Azure Blueprints

### Tier 2 Additional

- [ ] Configure Conditional Access
- [ ] Deploy basic Sentinel
- [ ] Implement backup strategy

## References

- [Azure Landing Zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Enterprise-Scale Reference](https://github.com/Azure/Enterprise-Scale)
- [CAF Terraform Modules](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale)
- [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep)
- [Start Small](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options)
