# Phase 1: Foundation

## Meridian Housing Group - Infrastructure Delivery

*Layer 3 implementation establishing the secure foundation for the Building Safety Platform.*

---

## Overview

Phase 1 establishes the Azure infrastructure, security controls, and connectivity required for the platform. This phase has no user-facing deliverables but is critical foundation work.

**Duration:** 12 weeks (Q2 2024)
**Team:** Solution Architect, Infrastructure Engineer, Security Specialist

---

## Sprint Breakdown

### Sprint 1-2: Azure Landing Zone (Weeks 1-4)

**Objective:** Establish governed Azure environment

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Create management group hierarchy | Infra Engineer | 2 days | Azure subscription |
| Create subscriptions (Platform, Connectivity) | Infra Engineer | 1 day | Management groups |
| Deploy resource groups | Infra Engineer | 1 day | Subscriptions |
| Configure Azure Policy (tagging, regions) | Infra Engineer | 3 days | Resource groups |
| Set up cost management alerts | Infra Engineer | 1 day | Subscriptions |
| Configure Azure Advisor | Infra Engineer | 1 day | Subscriptions |

**Deliverables:**
- Azure subscriptions operational
- Resource group structure deployed
- Governance policies active
- Cost alerts configured

**Exit Criteria:**
- [ ] Resources can only be created in UK South/UK West
- [ ] All resources require mandatory tags
- [ ] Daily cost alerts operational

---

### Sprint 3-4: Identity Configuration (Weeks 5-6)

**Objective:** Establish identity foundation and access controls

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Create security groups (SG-BSP-*) | Security Spec | 2 days | Entra ID access |
| Configure Conditional Access policies | Security Spec | 3 days | Security groups |
| Enable PIM for privileged roles | Security Spec | 2 days | Azure AD P2 |
| Create service principals | Security Spec | 1 day | Azure subscriptions |
| Configure MFA enforcement | Security Spec | 1 day | Conditional Access |
| Document access model | Security Spec | 1 day | All above |

**Deliverables:**
- Security groups created and populated
- Conditional Access policies active
- PIM configured for admin roles
- Service principals for integrations

**Exit Criteria:**
- [ ] MFA required for all users
- [ ] Admin access requires PIM activation
- [ ] Service principals tested with Key Vault

---

### Sprint 5-6: Network Infrastructure (Weeks 7-8)

**Objective:** Establish secure connectivity to on-premises

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design VNet and subnet structure | Architect | 2 days | Architecture approval |
| Deploy VNet and subnets | Infra Engineer | 1 day | Design complete |
| Configure NSGs | Infra Engineer | 2 days | VNet deployed |
| Deploy VPN Gateway | Infra Engineer | 1 day | VNet deployed |
| Configure Site-to-Site VPN | Infra Engineer | 3 days | On-prem coordination |
| Deploy Private Endpoints | Infra Engineer | 2 days | VNet deployed |
| Test connectivity | Infra Engineer | 2 days | VPN established |

**Deliverables:**
- VNet with subnets operational
- Site-to-Site VPN to Meridian network
- Private endpoints for PaaS services
- NSGs restricting traffic

**Exit Criteria:**
- [ ] Azure resources can reach Northgate server
- [ ] No public access to internal resources
- [ ] Connectivity test successful from Logic App

---

### Sprint 7-8: Integration Platform (Weeks 9-10)

**Objective:** Deploy integration infrastructure

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Deploy Key Vault | Infra Engineer | 1 day | VNet, identity |
| Store connection strings | Infra Engineer | 1 day | Key Vault deployed |
| Deploy API Management | Infra Engineer | 1 day | VNet |
| Configure APIM policies | Architect | 2 days | APIM deployed |
| Deploy Logic Apps (integration) | Architect | 2 days | Key Vault |
| Create test Logic App for Northgate | Architect | 2 days | VPN, Logic Apps |
| Deploy Storage Account | Infra Engineer | 1 day | VNet |

**Deliverables:**
- Key Vault with secrets
- API Management instance
- Logic Apps environment
- Storage for data landing

**Exit Criteria:**
- [ ] Logic App can authenticate to Key Vault
- [ ] Logic App can query Northgate (test query)
- [ ] API Management accessible internally

---

### Sprint 9-10: Northgate Connectivity (Weeks 11-12)

**Objective:** Validate end-to-end data flow from Northgate

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Create Northgate read-only SQL user | IT/Vendor | 3 days | Vendor engagement |
| Create Northgate views | IT/Vendor | 3 days | SQL user |
| Configure Logic App with connection | Architect | 2 days | Views, Key Vault |
| Test property data extraction | Architect | 2 days | Logic App |
| Land test data in Storage | Architect | 1 day | Logic App |
| Validate data quality | Architect | 2 days | Data landed |
| Document integration pattern | Architect | 1 day | Testing complete |

**Deliverables:**
- Northgate views for property, tenancy, contact
- Logic App extracting Northgate data
- Test data landed in Azure Storage
- Integration documentation

**Exit Criteria:**
- [ ] Property data extracted successfully
- [ ] Data matches Northgate source
- [ ] Extraction repeatable (scheduled)

---

### Sprint 11-12: Monitoring and Security (Weeks 13-14)

**Objective:** Establish operational visibility and security monitoring

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Deploy Log Analytics workspace | Infra Engineer | 1 day | Subscription |
| Configure diagnostic settings | Infra Engineer | 2 days | Log Analytics |
| Create monitoring dashboards | Infra Engineer | 2 days | Log Analytics |
| Configure alert rules | Infra Engineer | 2 days | Log Analytics |
| Enable Defender for Cloud | Security Spec | 1 day | Subscriptions |
| Conduct security review | Security Spec | 2 days | All above |
| Penetration test preparation | Security Spec | 2 days | All above |

**Deliverables:**
- Log Analytics collecting all logs
- Monitoring dashboards for IT
- Alert rules for critical failures
- Defender for Cloud enabled
- Security review report

**Exit Criteria:**
- [ ] All resources logging to Log Analytics
- [ ] Integration failure alerts working
- [ ] Defender Secure Score >70%

---

## Technical Specifications

### Resource Naming

| Resource | Name | Notes |
|----------|------|-------|
| Subscription (Platform) | sub-meridian-platform | Production workloads |
| Resource Group | rg-bsp-prod-uks | Production resources |
| VNet | vnet-bsp-prod-uks | 10.100.0.0/16 |
| Key Vault | kv-bsp-prod-uks | Secrets, certificates |
| Storage Account | stbspproduk | Data landing |
| Log Analytics | log-bsp-prod-uks | Monitoring |
| API Management | apim-bsp-prod-uks | Developer tier |

### Network Configuration

| Subnet | CIDR | Purpose | NSG |
|--------|------|---------|-----|
| snet-integration | 10.100.1.0/24 | Logic Apps, APIM | nsg-integration |
| snet-privatelink | 10.100.2.0/24 | Private Endpoints | nsg-privatelink |
| GatewaySubnet | 10.100.0.0/27 | VPN Gateway | (none) |

### Key Vault Secrets

| Secret Name | Purpose | Rotation |
|-------------|---------|----------|
| NorthgateDbConnectionString | Northgate SQL connection | Annual |
| StorageAccountKey | Azure Storage access | Annual |
| ApimSubscriptionKey | API authentication | Annual |

---

## Risk Mitigation

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Northgate vendor delays | Medium | High | Early engagement, escalation path |
| VPN configuration issues | Medium | Medium | Test environment first |
| Insufficient permissions | Low | Medium | PIM approval process |
| Data in transit security | Low | High | TLS 1.3, encryption |

---

## Phase 1 Acceptance

### Technical Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| Azure resources deployed | Infra Engineer | Resource group screenshot |
| Northgate connectivity | Architect | Successful data extraction log |
| Security controls active | Security Spec | Defender score, CA policies |
| Monitoring operational | Infra Engineer | Dashboard showing metrics |

### Business Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| No business disruption | IT Manager | No incident reports |
| Within budget | PM | Cost report vs baseline |
| Security compliant | Security Spec | Review report |

---

## Handover to Phase 2

| Item | Owner | Recipient |
|------|-------|-----------|
| Infrastructure documentation | Architect | Data Engineer |
| Key Vault access | Security Spec | Data Engineer |
| Northgate Logic App | Architect | Data Engineer |
| Monitoring runbook | Infra Engineer | IT Team |

---

*Phase 1 Specification Version: 1.0*
*Last Updated: [Date]*
