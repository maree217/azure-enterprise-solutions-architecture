# Well-Architected Framework Scorecard

A structured assessment template for scoring Azure environments against the five WAF pillars.

---

## Scoring Guide

| Score | Level | Description |
|-------|-------|-------------|
| **1** | Initial | Ad-hoc, no standard processes |
| **2** | Developing | Basic practices, inconsistent |
| **3** | Defined | Documented standards, partial adoption |
| **4** | Managed | Consistent implementation, measured |
| **5** | Optimized | Continuous improvement, automated |

---

## Assessment Summary

| Pillar | Weight | Score (1-5) | Weighted Score | Key Gap |
|--------|--------|-------------|----------------|---------|
| Reliability | 20% | ___ | ___ | |
| Security | 25% | ___ | ___ | |
| Cost Optimization | 15% | ___ | ___ | |
| Operational Excellence | 20% | ___ | ___ | |
| Performance Efficiency | 20% | ___ | ___ | |
| **TOTAL** | **100%** | | **___/5.00** | |

---

## Pillar 1: Reliability (20%)

### Assessment Questions

| # | Control Area | Question | Evidence Required | Score | Notes |
|---|--------------|----------|-------------------|-------|-------|
| R1 | **High Availability** | Are critical workloads deployed across availability zones? | Resource configs showing zone deployment | | |
| R2 | **High Availability** | Is there regional redundancy for tier-1 applications? | Multi-region deployment evidence | | |
| R3 | **Disaster Recovery** | Is there a documented DR plan? | DR runbook documentation | | |
| R4 | **Disaster Recovery** | Has DR been tested in the last 12 months? | DR test results | | |
| R5 | **Disaster Recovery** | Are RTO/RPO targets defined and achievable? | SLA documentation, test results | | |
| R6 | **Backup & Recovery** | Are all critical data stores backed up? | Backup policy configs | | |
| R7 | **Backup & Recovery** | Are backup restore procedures tested? | Restore test logs | | |
| R8 | **Resilience** | Are retry policies implemented for transient failures? | Application code/config review | | |
| R9 | **Resilience** | Is there circuit breaker pattern implementation? | Architecture documentation | | |
| R10 | **Monitoring** | Are health probes configured for all endpoints? | Load balancer/App Gateway configs | | |

### Reliability Score Calculation

| Question | Score |
|----------|-------|
| R1 | |
| R2 | |
| R3 | |
| R4 | |
| R5 | |
| R6 | |
| R7 | |
| R8 | |
| R9 | |
| R10 | |
| **Average** | **___/5** |

### Key Findings - Reliability

**Strengths:**
1.
2.

**Gaps:**
1.
2.

**Recommendations:**
1.
2.

---

## Pillar 2: Security (25%)

### Assessment Questions

| # | Control Area | Question | Evidence Required | Score | Notes |
|---|--------------|----------|-------------------|-------|-------|
| S1 | **Identity** | Is MFA enforced for all users? | Conditional Access policies | | |
| S2 | **Identity** | Are service principals using managed identities? | Resource identity configs | | |
| S3 | **Identity** | Is Privileged Identity Management (PIM) enabled? | PIM configuration | | |
| S4 | **Network** | Are network security groups properly configured? | NSG rules export | | |
| S5 | **Network** | Is there network segmentation (Hub-Spoke)? | VNet topology | | |
| S6 | **Network** | Are private endpoints used for PaaS services? | Private endpoint configs | | |
| S7 | **Data** | Is encryption at rest enabled for all storage? | Storage account settings | | |
| S8 | **Data** | Is TLS 1.2+ enforced for data in transit? | Service configs | | |
| S9 | **Data** | Are Key Vaults used for secret management? | Key Vault inventory | | |
| S10 | **Compliance** | Is Microsoft Defender for Cloud enabled? | Defender settings | | |
| S11 | **Compliance** | What is the current Secure Score? | Defender dashboard | | |
| S12 | **Compliance** | Are regulatory compliance standards tracked? | Compliance dashboard | | |

### Security Score Calculation

| Question | Score |
|----------|-------|
| S1 | |
| S2 | |
| S3 | |
| S4 | |
| S5 | |
| S6 | |
| S7 | |
| S8 | |
| S9 | |
| S10 | |
| S11 | |
| S12 | |
| **Average** | **___/5** |

### Key Findings - Security

**Strengths:**
1.
2.

**Gaps:**
1.
2.

**Recommendations:**
1.
2.

---

## Pillar 3: Cost Optimization (15%)

### Assessment Questions

| # | Control Area | Question | Evidence Required | Score | Notes |
|---|--------------|----------|-------------------|-------|-------|
| C1 | **Visibility** | Are costs tracked by cost center/project? | Cost Management tags | | |
| C2 | **Visibility** | Are budgets and alerts configured? | Budget configurations | | |
| C3 | **Rightsizing** | Are VM sizes appropriate for workloads? | Advisor recommendations | | |
| C4 | **Rightsizing** | Are there idle/orphaned resources? | Unattached disk/IP report | | |
| C5 | **Commitments** | Are Reserved Instances utilized? | RI coverage report | | |
| C6 | **Commitments** | Is Savings Plan implemented? | Savings Plan coverage | | |
| C7 | **Optimization** | Are auto-shutdown policies in place for dev/test? | Automation configs | | |
| C8 | **Optimization** | Is spot pricing used where appropriate? | VM configurations | | |
| C9 | **Governance** | Are spending limits enforced? | Policy assignments | | |
| C10 | **FinOps** | Is there a FinOps practice/team? | Process documentation | | |

### Cost Score Calculation

| Question | Score |
|----------|-------|
| C1 | |
| C2 | |
| C3 | |
| C4 | |
| C5 | |
| C6 | |
| C7 | |
| C8 | |
| C9 | |
| C10 | |
| **Average** | **___/5** |

### Key Findings - Cost

**Current Monthly Spend:** £___
**Identified Savings Opportunity:** £___/month (___%)
**Waste Categories:**
- Orphaned resources: £___
- Oversized VMs: £___
- Missing reservations: £___

**Recommendations:**
1.
2.

---

## Pillar 4: Operational Excellence (20%)

### Assessment Questions

| # | Control Area | Question | Evidence Required | Score | Notes |
|---|--------------|----------|-------------------|-------|-------|
| O1 | **Monitoring** | Is Azure Monitor configured comprehensively? | Monitor settings | | |
| O2 | **Monitoring** | Are alerts actionable and not causing fatigue? | Alert rules review | | |
| O3 | **Monitoring** | Are dashboards available for key metrics? | Dashboard inventory | | |
| O4 | **Logging** | Is centralized logging implemented? | Log Analytics config | | |
| O5 | **Logging** | Are diagnostic settings enabled on resources? | Diagnostic settings | | |
| O6 | **Automation** | Is infrastructure deployed as code? | IaC repository | | |
| O7 | **Automation** | Are CI/CD pipelines in place? | Pipeline configs | | |
| O8 | **Change Management** | Is there a change management process? | Process documentation | | |
| O9 | **Incident Response** | Are runbooks documented? | Runbook inventory | | |
| O10 | **Documentation** | Is architecture documented and current? | Documentation review | | |

### Operational Excellence Score Calculation

| Question | Score |
|----------|-------|
| O1 | |
| O2 | |
| O3 | |
| O4 | |
| O5 | |
| O6 | |
| O7 | |
| O8 | |
| O9 | |
| O10 | |
| **Average** | **___/5** |

### Key Findings - Operations

**Strengths:**
1.
2.

**Gaps:**
1.
2.

**Recommendations:**
1.
2.

---

## Pillar 5: Performance Efficiency (20%)

### Assessment Questions

| # | Control Area | Question | Evidence Required | Score | Notes |
|---|--------------|----------|-------------------|-------|-------|
| P1 | **Scaling** | Is autoscaling configured for variable workloads? | Scale set configs | | |
| P2 | **Scaling** | Are scale triggers appropriate? | Scale rule review | | |
| P3 | **Caching** | Is caching implemented appropriately? | Redis/CDN configs | | |
| P4 | **Caching** | Are cache hit ratios monitored? | Metrics review | | |
| P5 | **Database** | Are database performance tiers appropriate? | DTU/vCore utilization | | |
| P6 | **Database** | Are indexes optimized? | Query performance insights | | |
| P7 | **Network** | Is CDN used for static content? | CDN configuration | | |
| P8 | **Network** | Are resources in optimal regions? | Latency analysis | | |
| P9 | **Compute** | Are premium storage tiers used where needed? | Disk configurations | | |
| P10 | **Testing** | Is load testing performed regularly? | Test results | | |

### Performance Score Calculation

| Question | Score |
|----------|-------|
| P1 | |
| P2 | |
| P3 | |
| P4 | |
| P5 | |
| P6 | |
| P7 | |
| P8 | |
| P9 | |
| P10 | |
| **Average** | **___/5** |

### Key Findings - Performance

**Strengths:**
1.
2.

**Gaps:**
1.
2.

**Recommendations:**
1.
2.

---

## Overall Assessment

### Maturity Radar

```
            Reliability (___/5)
                   *
                  /|\
                 / | \
                /  |  \
Performance   /   |   \   Security
(___/5)  ----*----+----*---- (___/5)
              \   |   /
               \  |  /
                \ | /
                 \|/
                  *
         Cost (___/5)    Operations (___/5)
```

### Final Weighted Score

| Pillar | Weight | Score | Weighted |
|--------|--------|-------|----------|
| Reliability | 20% | | |
| Security | 25% | | |
| Cost Optimization | 15% | | |
| Operational Excellence | 20% | | |
| Performance Efficiency | 20% | | |
| **TOTAL** | **100%** | | **___/5.00** |

### Maturity Level

| Score Range | Level | Description |
|-------------|-------|-------------|
| 1.0 - 1.9 | Initial | Significant gaps, high risk |
| 2.0 - 2.9 | Developing | Basic practices, inconsistent |
| 3.0 - 3.9 | Defined | Good foundation, room for improvement |
| 4.0 - 4.5 | Managed | Strong practices, well-controlled |
| 4.6 - 5.0 | Optimized | Industry-leading, continuous improvement |

**Current Maturity Level:** _______________

---

## Appendix A: Evidence Checklist

| Item | Collected | Location |
|------|-----------|----------|
| Resource Graph export | [ ] | |
| Security assessment export | [ ] | |
| Cost Management export | [ ] | |
| Advisor recommendations | [ ] | |
| Network topology diagram | [ ] | |
| Application architecture | [ ] | |
| DR documentation | [ ] | |
| Runbooks | [ ] | |

---

## Appendix B: Assessment Team

| Role | Name | Organization |
|------|------|--------------|
| Lead Architect | | |
| Security Reviewer | | |
| Client Sponsor | | |
| Technical Contact | | |

**Assessment Date:** _______________
**Report Version:** 1.0
