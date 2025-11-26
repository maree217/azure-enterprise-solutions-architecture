# Assessment Discovery Checklist

A comprehensive checklist to ensure thorough discovery before and during an Azure architecture assessment.

---

## Pre-Engagement Checklist

### Client Information

- [ ] Client name and legal entity
- [ ] Industry sector
- [ ] Company size (employees, revenue)
- [ ] Geographic presence
- [ ] Primary contact details
- [ ] Technical contact details

### Scope Definition

- [ ] Azure subscriptions in scope (list subscription IDs)
- [ ] Tenant ID
- [ ] Regions in use
- [ ] Resource types to focus on
- [ ] Exclusions (anything out of scope)
- [ ] Timeline for assessment
- [ ] Assessment type (rapid, standard, comprehensive)

### Access Requirements

- [ ] Reader access to all in-scope subscriptions
- [ ] Security Reader role (for Defender data)
- [ ] Cost Management Reader role
- [ ] Microsoft.Graph permissions (for Entra ID data)
- [ ] Access method confirmed (guest account, dedicated account, PIM)
- [ ] VPN/network access if required
- [ ] MFA setup complete

### Stakeholder Identification

- [ ] Executive sponsor identified
- [ ] Technical lead identified
- [ ] Interview schedule confirmed
- [ ] Stakeholder roles documented:
  - [ ] CTO/CIO
  - [ ] Cloud Architect
  - [ ] Security lead
  - [ ] DevOps/Platform lead
  - [ ] FinOps/Finance contact
  - [ ] Application owners

### Documentation Request

- [ ] Existing architecture diagrams
- [ ] Network topology diagrams
- [ ] Previous assessment reports
- [ ] Compliance requirements documentation
- [ ] DR/BCP documentation
- [ ] Runbooks and operational procedures
- [ ] Cost reports (last 12 months)
- [ ] Incident history (last 12 months)
- [ ] SLA requirements
- [ ] Naming conventions

### Logistics

- [ ] Assessment kick-off meeting scheduled
- [ ] Interview slots confirmed
- [ ] Secure file sharing method established
- [ ] Communication channels established (Teams, Slack, email)
- [ ] Status reporting cadence agreed
- [ ] Final presentation date confirmed

---

## Day 1: Environment Access & Setup

### Access Verification

- [ ] Azure portal access confirmed
- [ ] Can view all in-scope subscriptions
- [ ] Can access Resource Graph
- [ ] Can access Microsoft Defender for Cloud
- [ ] Can access Cost Management
- [ ] Can access Azure Advisor
- [ ] Can access Azure Monitor

### Tooling Setup

- [ ] PowerShell environment ready
- [ ] Required modules installed:
  - [ ] Az
  - [ ] Az.ResourceGraph
  - [ ] Az.Security
  - [ ] Az.Advisor
  - [ ] Az.CostManagement
- [ ] Extraction scripts tested
- [ ] Output directory created
- [ ] Secure storage for assessment data confirmed

### Initial Discovery Commands

```powershell
# Run these to verify access and get initial overview

# 1. List accessible subscriptions
Get-AzSubscription | Select-Object Name, Id, State

# 2. Get resource count by type
Search-AzGraph -Query "Resources | summarize count() by type | order by count_ desc"

# 3. Get resource count by region
Search-AzGraph -Query "Resources | summarize count() by location | order by count_ desc"

# 4. Check Defender status
Get-AzSecurityPricing | Select-Object Name, PricingTier
```

---

## Data Extraction Checklist

### Inventory Extraction

- [ ] Run azure-inventory.ps1
- [ ] Verify all-resources.json generated
- [ ] Verify resource type breakdowns captured:
  - [ ] Virtual Networks
  - [ ] Storage Accounts
  - [ ] Virtual Machines
  - [ ] SQL Databases
  - [ ] AKS Clusters
  - [ ] App Services
  - [ ] Key Vaults
  - [ ] NSGs
  - [ ] Public IPs
- [ ] Verify resource groups captured
- [ ] Verify tags captured

### Security Extraction

- [ ] Run security-export.ps1
- [ ] Verify Secure Score captured
- [ ] Verify security assessments exported
- [ ] Verify security alerts exported
- [ ] Verify compliance status captured
- [ ] Verify recommendations exported

### Cost Extraction

- [ ] Run cost-export.ps1
- [ ] Verify Advisor cost recommendations captured
- [ ] Verify resource distribution data captured
- [ ] Verify unattached disk list generated
- [ ] Verify unattached public IP list generated
- [ ] Verify VM inventory for sizing captured

### Full Assessment

- [ ] Run run-full-assessment.ps1
- [ ] Verify master summary generated
- [ ] All phase outputs complete:
  - [ ] /inventory populated
  - [ ] /security populated
  - [ ] /cost populated
- [ ] Verify JSON exports are valid
- [ ] Verify CSV exports are readable

---

## Interview Checklist

### Executive Interviews

- [ ] CTO/CIO interview completed
- [ ] Business priorities documented
- [ ] Budget constraints understood
- [ ] Strategic direction captured
- [ ] Success criteria defined

### Technical Interviews

- [ ] Cloud Architect interview completed
- [ ] Platform/DevOps lead interview completed
- [ ] Security lead interview completed
- [ ] Key application owners interviewed
- [ ] Pain points documented
- [ ] Technical debt identified

### Interview Outputs

- [ ] All interview notes compiled
- [ ] Perception vs. Reality matrix started
- [ ] Key quotes captured
- [ ] Follow-up questions identified
- [ ] Theme analysis completed

---

## Analysis Checklist

### Well-Architected Framework Assessment

#### Reliability Pillar

- [ ] Availability zone usage assessed
- [ ] Regional redundancy evaluated
- [ ] DR plan existence verified
- [ ] DR testing history checked
- [ ] Backup policies reviewed
- [ ] Health probe configuration verified
- [ ] Reliability score assigned (1-5)

#### Security Pillar

- [ ] Defender Secure Score recorded
- [ ] MFA status verified
- [ ] PIM configuration checked
- [ ] NSG rules reviewed
- [ ] Private endpoint usage assessed
- [ ] Encryption settings verified
- [ ] Key Vault usage reviewed
- [ ] Security score assigned (1-5)

#### Cost Optimization Pillar

- [ ] Monthly spend documented
- [ ] Spend trend analyzed
- [ ] Tagging coverage assessed
- [ ] Budget alerts verified
- [ ] RI/SP coverage calculated
- [ ] Orphaned resources identified
- [ ] Rightsizing opportunities found
- [ ] Cost score assigned (1-5)

#### Operational Excellence Pillar

- [ ] IaC coverage assessed
- [ ] CI/CD pipelines reviewed
- [ ] Monitoring coverage evaluated
- [ ] Alerting effectiveness assessed
- [ ] Runbook documentation reviewed
- [ ] Change management process evaluated
- [ ] Operations score assigned (1-5)

#### Performance Efficiency Pillar

- [ ] Auto-scaling configuration reviewed
- [ ] Caching implementation assessed
- [ ] Database performance evaluated
- [ ] CDN usage checked
- [ ] Load testing evidence reviewed
- [ ] Performance score assigned (1-5)

### Three-Layer Classification

- [ ] All resources classified to layers
- [ ] Layer 1 (UX) components identified
- [ ] Layer 2 (Intelligence) components identified
- [ ] Layer 3 (Infrastructure) components identified
- [ ] Cross-cutting governance assessed
- [ ] Layer integration points evaluated
- [ ] Strategic gaps identified

### Gap Analysis

- [ ] All findings documented
- [ ] Gaps categorized by severity
- [ ] Gaps categorized by WAF pillar
- [ ] Impact assessments complete
- [ ] Remediation recommendations drafted
- [ ] Effort estimates assigned
- [ ] Prioritization matrix complete

---

## Documentation Collection Tracker

| Document | Requested | Received | Reviewed | Notes |
|----------|-----------|----------|----------|-------|
| Architecture diagrams | [ ] | [ ] | [ ] | |
| Network diagrams | [ ] | [ ] | [ ] | |
| Previous assessments | [ ] | [ ] | [ ] | |
| DR/BCP documentation | [ ] | [ ] | [ ] | |
| Runbooks | [ ] | [ ] | [ ] | |
| Cost reports | [ ] | [ ] | [ ] | |
| Incident reports | [ ] | [ ] | [ ] | |
| Compliance requirements | [ ] | [ ] | [ ] | |
| SLA documentation | [ ] | [ ] | [ ] | |
| Naming conventions | [ ] | [ ] | [ ] | |
| Tagging standards | [ ] | [ ] | [ ] | |
| Security policies | [ ] | [ ] | [ ] | |

---

## Quality Assurance Checklist

### Data Quality

- [ ] No empty/null critical fields
- [ ] Resource counts match expected
- [ ] No obvious data gaps
- [ ] JSON files parse correctly
- [ ] CSV files open correctly

### Analysis Quality

- [ ] All WAF pillars scored
- [ ] Scores supported by evidence
- [ ] Findings are specific and actionable
- [ ] Recommendations are practical
- [ ] Effort estimates are realistic

### Report Quality

- [ ] Executive summary is concise
- [ ] Technical details are accurate
- [ ] Diagrams are clear
- [ ] Roadmap is realistic
- [ ] Investment figures are justified

### Presentation Readiness

- [ ] Key messages identified
- [ ] Story flow logical
- [ ] Visuals prepared
- [ ] Demo data ready (if applicable)
- [ ] Q&A preparation complete

---

## Final Deliverables Checklist

### Core Deliverables

- [ ] Executive Summary document
- [ ] Full Assessment Report
- [ ] Gap Analysis document
- [ ] Implementation Roadmap
- [ ] Findings workbook (detailed)

### Supporting Materials

- [ ] Resource inventory exports
- [ ] Security findings exports
- [ ] Cost analysis exports
- [ ] Updated architecture diagrams
- [ ] Maturity radar visualization

### Optional Deliverables

- [ ] IaC templates for quick wins
- [ ] Policy definitions
- [ ] Runbook templates
- [ ] Training recommendations

### Handover

- [ ] All documents in final format
- [ ] Files uploaded to secure share
- [ ] Presentation rehearsed
- [ ] Client questions anticipated
- [ ] Next steps prepared

---

## Post-Assessment Checklist

### Immediate Actions

- [ ] Assessment data securely stored
- [ ] Client access to deliverables confirmed
- [ ] Presentation completed
- [ ] Q&A addressed
- [ ] Immediate next steps agreed

### Follow-up

- [ ] Proposal for remediation work (if requested)
- [ ] Schedule follow-up session (if needed)
- [ ] Gather feedback on assessment
- [ ] Update methodology based on lessons learned
- [ ] Archive assessment materials

### Knowledge Capture

- [ ] New patterns/findings documented
- [ ] Toolkit improvements identified
- [ ] Team debrief completed
- [ ] Case study material captured (with permission)

---

## Common Issues to Watch For

### Technical Issues

| Issue | Detection | Resolution |
|-------|-----------|------------|
| Insufficient permissions | Extraction fails | Request elevated access |
| Missing modules | Script errors | Install missing PowerShell modules |
| Large environment | Script timeouts | Run queries in batches |
| Multi-tenant setup | Incomplete data | Query each tenant separately |
| Private endpoints | Can't access resources | Use authorized machine |

### Process Issues

| Issue | Detection | Resolution |
|-------|-----------|------------|
| Stakeholder unavailability | Interview gaps | Reschedule early, have backup contacts |
| Missing documentation | Can't validate findings | Rely on extracted data, note gaps |
| Scope creep | Expanding requirements | Refer to agreed scope |
| Tight timeline | Incomplete analysis | Prioritize critical findings |
| Data sensitivity | Client hesitation | Agree on data handling procedures |

---

## Quick Reference: Key Queries

```powershell
# Resource count
Search-AzGraph -Query "Resources | count"

# Resources by type
Search-AzGraph -Query "Resources | summarize count() by type | order by count_ desc | take 20"

# Security assessments status
Search-AzGraph -Query "securityresources | where type == 'microsoft.security/assessments' | extend status = properties.status.code | summarize count() by tostring(status)"

# Unmanaged disks
Search-AzGraph -Query "Resources | where type == 'microsoft.compute/disks' | where isnull(managedBy) | project name, resourceGroup, diskSizeGB = properties.diskSizeGB"

# Public IPs without assignment
Search-AzGraph -Query "Resources | where type == 'microsoft.network/publicipaddresses' | where isnull(properties.ipConfiguration) | project name, resourceGroup"

# VMs without availability zones
Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where isnull(zones) | project name, resourceGroup, location"
```

---

*Azure Enterprise Solutions Architecture Assessment Toolkit*
*github.com/maree217/azure-enterprise-solutions-architecture*
