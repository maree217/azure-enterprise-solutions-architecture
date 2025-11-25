# Zero Trust Security Architecture for Azure

## Enterprise Security Patterns

Production-ready security patterns implementing Zero Trust principles across Azure infrastructure.

---

## Zero Trust Principles

### The Three Pillars

```
┌─────────────────────────────────────────────────────────────────┐
│                    ZERO TRUST PILLARS                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│                 │  │                 │  │                 │
│    VERIFY       │  │     LEAST       │  │    ASSUME       │
│   EXPLICITLY    │  │   PRIVILEGE     │  │    BREACH       │
│                 │  │                 │  │                 │
│ • Strong auth   │  │ • JIT/JEA       │  │ • Segment       │
│ • MFA always    │  │ • RBAC          │  │ • Encrypt       │
│ • Device health │  │ • Time-limited  │  │ • Monitor       │
│ • Location      │  │ • Scope-limited │  │ • Detect        │
│                 │  │                 │  │                 │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## Architecture Overview

### Zero Trust Network Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     INTERNET                                     │
└─────────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┴─────────┐
                    │   Azure Front     │
                    │   Door + WAF      │
                    └─────────┬─────────┘
                              │
┌─────────────────────────────────────────────────────────────────┐
│                    PERIMETER NETWORK                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │   Azure     │  │   Azure     │  │   DDoS      │             │
│  │   Firewall  │  │   Bastion   │  │ Protection  │             │
│  └─────────────┘  └─────────────┘  └─────────────┘             │
└─────────────────────────────────────────────────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         │                    │                    │
         ↓                    ↓                    ↓
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   APPLICATION   │  │      DATA       │  │   MANAGEMENT    │
│   SEGMENT       │  │    SEGMENT      │  │    SEGMENT      │
│                 │  │                 │  │                 │
│ • App Service   │  │ • SQL Database  │  │ • Automation    │
│ • AKS           │  │ • Cosmos DB     │  │ • Key Vault     │
│ • Functions     │  │ • Storage       │  │ • Monitor       │
│                 │  │                 │  │                 │
│ Private         │  │ Private         │  │ Private         │
│ Endpoints Only  │  │ Endpoints Only  │  │ Endpoints Only  │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## Identity Security

### Microsoft Entra ID Configuration

```
┌─────────────────────────────────────────────────────────────────┐
│                    IDENTITY LAYER                                │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    CONDITIONAL ACCESS                            │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  IF: User + App + Device + Location + Risk              │    │
│  │  THEN: Allow / Block / Require MFA / Require Compliant  │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         ↓                    ↓                    ↓
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│      MFA        │  │    DEVICE       │  │    RISK         │
│                 │  │   COMPLIANCE    │  │   DETECTION     │
│ • Authenticator │  │ • Intune        │  │ • Sign-in risk  │
│ • FIDO2         │  │ • Hybrid join   │  │ • User risk     │
│ • Passkeys      │  │ • Compliant     │  │ • Real-time     │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

### Privileged Identity Management (PIM)

```
┌─────────────────────────────────────────────────────────────────┐
│                    PIM WORKFLOW                                  │
└─────────────────────────────────────────────────────────────────┘

Regular User State
         │
         ↓
┌─────────────────┐
│  REQUEST        │  User requests elevated role
│  ELEVATION      │  Provides justification
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  APPROVAL       │  Manager/Admin approves (optional)
│  (if required)  │  Time-limited activation
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  ACTIVATED      │  Role active for X hours
│  ROLE           │  Full audit trail
└────────┬────────┘
         │
         ↓ (auto-expire)
┌─────────────────┐
│  DEACTIVATED    │  Back to regular permissions
│                 │  Access review required
└─────────────────┘
```

### PIM Configuration Checklist

- [ ] Enable PIM for all privileged roles
- [ ] Configure approval workflows for Global Admin
- [ ] Set maximum activation duration (8 hours recommended)
- [ ] Require MFA for activation
- [ ] Enable notifications for activations
- [ ] Configure access reviews (quarterly)
- [ ] Set up emergency access accounts

---

## Network Security

### Network Segmentation

```
┌─────────────────────────────────────────────────────────────────┐
│                    HUB VNET (10.0.0.0/16)                        │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  GatewaySubnet    │  AzureFirewallSubnet  │  Bastion    │    │
│  │  10.0.0.0/24      │  10.0.1.0/24          │  10.0.2.0/24│    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
         │                    │                    │
    Peering              Peering              Peering
         │                    │                    │
         ↓                    ↓                    ↓
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│  PROD SPOKE     │  │   DEV SPOKE     │  │   DATA SPOKE    │
│  10.1.0.0/16    │  │  10.2.0.0/16    │  │  10.3.0.0/16    │
│                 │  │                 │  │                 │
│ ┌─────────────┐ │  │ ┌─────────────┐ │  │ ┌─────────────┐ │
│ │  App Tier   │ │  │ │  App Tier   │ │  │ │  Data Tier  │ │
│ │ 10.1.1.0/24 │ │  │ │ 10.2.1.0/24 │ │  │ │ 10.3.1.0/24 │ │
│ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │
│ ┌─────────────┐ │  │ ┌─────────────┐ │  │ ┌─────────────┐ │
│ │  Data Tier  │ │  │ │  Data Tier  │ │  │ │  Compute    │ │
│ │ 10.1.2.0/24 │ │  │ │ 10.2.2.0/24 │ │  │ │ 10.3.2.0/24 │ │
│ └─────────────┘ │  │ └─────────────┘ │  │ └─────────────┘ │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

### Network Security Groups (NSG)

```
┌─────────────────────────────────────────────────────────────────┐
│                    NSG RULES (Example: App Tier)                 │
└─────────────────────────────────────────────────────────────────┘

INBOUND RULES:
┌──────┬──────────┬────────────┬──────────┬────────────┬────────┐
│ Prio │  Name    │   Source   │  Dest    │   Port     │ Action │
├──────┼──────────┼────────────┼──────────┼────────────┼────────┤
│ 100  │ AllowLB  │ AzureLB    │ Any      │ 443        │ Allow  │
│ 110  │ AllowApp │ AppGW      │ Any      │ 443        │ Allow  │
│ 200  │ AllowMgt │ Bastion    │ Any      │ 22,3389    │ Allow  │
│ 4096 │ DenyAll  │ Any        │ Any      │ Any        │ Deny   │
└──────┴──────────┴────────────┴──────────┴────────────┴────────┘

OUTBOUND RULES:
┌──────┬──────────┬────────────┬──────────┬────────────┬────────┐
│ Prio │  Name    │   Source   │  Dest    │   Port     │ Action │
├──────┼──────────┼────────────┼──────────┼────────────┼────────┤
│ 100  │ AllowSQL │ Any        │ DataTier │ 1433       │ Allow  │
│ 110  │ AllowKV  │ Any        │ KeyVault │ 443        │ Allow  │
│ 120  │ AllowMon │ Any        │ Monitor  │ 443        │ Allow  │
│ 4096 │ DenyAll  │ Any        │ Any      │ Any        │ Deny   │
└──────┴──────────┴────────────┴──────────┴────────────┴────────┘
```

### Private Endpoints

Eliminate public internet exposure for Azure services.

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRIVATE ENDPOINT PATTERN                      │
└─────────────────────────────────────────────────────────────────┘

Before (Public):
Application → Internet → storage.blob.core.windows.net → Storage

After (Private):
Application → VNet → Private Endpoint (10.1.1.10) → Storage
                          │
                    Private DNS Zone
                    (privatelink.blob.core.windows.net)
```

### Services to Enable Private Endpoints

| Service | Priority | DNS Zone |
|---------|----------|----------|
| Azure SQL | P0 | privatelink.database.windows.net |
| Storage | P0 | privatelink.blob/dfs/queue.core.windows.net |
| Key Vault | P0 | privatelink.vaultcore.azure.net |
| Azure OpenAI | P0 | privatelink.openai.azure.com |
| AI Search | P1 | privatelink.search.windows.net |
| Cosmos DB | P1 | privatelink.documents.azure.com |
| App Service | P1 | privatelink.azurewebsites.net |

---

## Data Security

### Encryption Strategy

```
┌─────────────────────────────────────────────────────────────────┐
│                    ENCRYPTION LAYERS                             │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    IN TRANSIT                                    │
│  • TLS 1.3 minimum                                              │
│  • Certificate pinning for critical apps                        │
│  • Mutual TLS for service-to-service                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    AT REST                                       │
│  • Platform-managed keys (default)                              │
│  • Customer-managed keys (CMK) for sensitive data              │
│  • Double encryption for highest sensitivity                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    IN USE (Advanced)                             │
│  • Confidential computing                                       │
│  • Secure enclaves                                              │
│  • Always Encrypted (SQL)                                       │
└─────────────────────────────────────────────────────────────────┘
```

### Key Vault Best Practices

```
┌─────────────────────────────────────────────────────────────────┐
│                    KEY VAULT ARCHITECTURE                        │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────┐      ┌─────────────────┐
│   Application   │      │   Key Vault     │
│                 │ ←──→ │                 │
│ Managed Identity│      │ • Secrets       │
│ (No passwords!) │      │ • Keys          │
└─────────────────┘      │ • Certificates  │
                         │                 │
                         │ Access Policies │
                         │ or RBAC         │
                         └─────────────────┘

Best Practices:
✅ Use Managed Identity (no secrets in code)
✅ Enable soft-delete and purge protection
✅ Use RBAC instead of access policies
✅ Enable diagnostic logging
✅ Use separate vaults per environment
✅ Enable private endpoints
```

---

## Security Monitoring

### Microsoft Defender for Cloud

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEFENDER FOR CLOUD                            │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    SECURE SCORE                                  │
│                                                                  │
│  ████████████████████████████░░░░░░░░  78/100                   │
│                                                                  │
│  Recommendations:                                                │
│  ⚠️  Enable MFA for accounts with owner permissions (High)      │
│  ⚠️  Enable encryption at rest for SQL databases (Medium)       │
│  ⚠️  Enable DDoS Protection Standard (Medium)                   │
└─────────────────────────────────────────────────────────────────┘

Enable Defender Plans:
├── Defender for Servers         ✅ (P1 or P2)
├── Defender for Containers      ✅
├── Defender for SQL             ✅
├── Defender for Storage         ✅
├── Defender for Key Vault       ✅
├── Defender for Resource Manager✅
├── Defender for DNS             ✅
└── Defender for APIs            ✅
```

### Microsoft Sentinel

```
┌─────────────────────────────────────────────────────────────────┐
│                    SENTINEL ARCHITECTURE                         │
└─────────────────────────────────────────────────────────────────┘

         ┌─────────────────────────────────────────┐
         │           DATA CONNECTORS               │
         │  Azure AD │ M365 │ Azure │ 3rd Party   │
         └─────────────────────────────────────────┘
                              │
                              ↓
         ┌─────────────────────────────────────────┐
         │           LOG ANALYTICS                 │
         │         (Data Retention)                │
         └─────────────────────────────────────────┘
                              │
         ┌────────────────────┼────────────────────┐
         ↓                    ↓                    ↓
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   ANALYTICS     │  │   HUNTING       │  │   AUTOMATION    │
│   RULES         │  │   QUERIES       │  │   (SOAR)        │
│                 │  │                 │  │                 │
│ • Scheduled     │  │ • KQL queries   │  │ • Playbooks     │
│ • NRT           │  │ • Bookmarks     │  │ • Logic Apps    │
│ • ML-based      │  │ • Livestream    │  │ • Auto-response │
└────────┬────────┘  └─────────────────┘  └────────┬────────┘
         │                                         │
         └──────────────────┬──────────────────────┘
                            ↓
                   ┌─────────────────┐
                   │   INCIDENTS     │
                   │   & RESPONSE    │
                   └─────────────────┘
```

### Essential KQL Queries

```kql
// Failed sign-ins by location
SigninLogs
| where ResultType != 0
| summarize FailedAttempts = count() by Location, UserPrincipalName
| where FailedAttempts > 10
| order by FailedAttempts desc

// Unusual resource creation
AzureActivity
| where OperationNameValue contains "Microsoft.Compute/virtualMachines/write"
| where ActivityStatusValue == "Success"
| summarize count() by Caller, CallerIpAddress
| where count_ > 5

// Data exfiltration detection
StorageBlobLogs
| where OperationName == "GetBlob"
| summarize TotalBytes = sum(ResponseBodySize) by CallerIpAddress, bin(TimeGenerated, 1h)
| where TotalBytes > 1000000000  // 1 GB
```

---

## Compliance Automation

### Azure Policy for Security

```bicep
// Enforce HTTPS for Storage
resource httpsPolicy 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'enforce-https-storage'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9'
    scope: subscription().id
    enforcementMode: 'Default'
  }
}

// Require encryption for SQL
resource sqlEncryptionPolicy 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'enforce-sql-encryption'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a8793640-60f7-487c-b5c3-1d37215905c4'
    scope: subscription().id
    enforcementMode: 'Default'
  }
}
```

### Security Baseline Policies

| Policy | Effect | Purpose |
|--------|--------|---------|
| Require HTTPS for storage | Deny | Enforce encryption in transit |
| Require TDE for SQL | DeployIfNotExists | Enforce encryption at rest |
| Require NSG on subnets | Deny | Enforce network segmentation |
| Allowed locations | Deny | Data residency compliance |
| Require resource tags | Deny | Asset management |
| Require private endpoints | Audit → Deny | Eliminate public exposure |

---

## Implementation Checklist

### Week 1-2: Identity Foundation

- [ ] Configure Entra ID security defaults
- [ ] Enable MFA for all users
- [ ] Set up Conditional Access policies
- [ ] Configure PIM for privileged roles
- [ ] Create emergency access accounts
- [ ] Enable Identity Protection

### Week 3-4: Network Security

- [ ] Deploy hub-spoke network topology
- [ ] Configure Azure Firewall
- [ ] Set up Azure Bastion
- [ ] Deploy Private Endpoints for critical services
- [ ] Configure NSGs with deny-all default
- [ ] Enable DDoS Protection

### Week 5-6: Data Protection

- [ ] Enable encryption at rest (CMK where required)
- [ ] Configure Key Vault
- [ ] Enable TLS 1.3 minimum
- [ ] Set up certificate management
- [ ] Configure data classification
- [ ] Enable Microsoft Purview

### Week 7-8: Monitoring & Response

- [ ] Enable Microsoft Defender for Cloud (all plans)
- [ ] Deploy Microsoft Sentinel
- [ ] Configure data connectors
- [ ] Create analytics rules
- [ ] Set up playbooks for auto-response
- [ ] Configure alert notifications

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Secure Score** | >90% | Defender for Cloud |
| **MFA Coverage** | 100% | Entra ID reports |
| **Private Endpoint Coverage** | >95% | Azure Policy |
| **Incidents MTTD** | <1 hour | Sentinel metrics |
| **Incidents MTTR** | <4 hours | Sentinel metrics |
| **Policy Compliance** | >98% | Azure Policy |

---

## Key Resources

### Microsoft Documentation

- [Zero Trust Deployment Guide](https://learn.microsoft.com/security/zero-trust/)
- [Microsoft Defender for Cloud](https://learn.microsoft.com/azure/defender-for-cloud/)
- [Microsoft Sentinel](https://learn.microsoft.com/azure/sentinel/)
- [Conditional Access](https://learn.microsoft.com/entra/identity/conditional-access/)

### GitHub Repositories

- [Microsoft Sentinel](https://github.com/Azure/Azure-Sentinel) - Detection rules and hunting queries
- [Azure Security Benchmark](https://github.com/MicrosoftDocs/SecurityBenchmarks) - Security baselines
