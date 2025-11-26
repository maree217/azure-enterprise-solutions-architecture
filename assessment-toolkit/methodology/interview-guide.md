# Stakeholder Interview Guide

A structured approach to gathering strategic and technical context during Azure architecture assessments.

---

## Interview Preparation

### Before the Interview

- [ ] Review any existing documentation provided
- [ ] Understand the client's industry and business model
- [ ] Prepare role-specific questions
- [ ] Set up recording (with permission)
- [ ] Block 60-90 minutes per interview
- [ ] Send agenda and topics in advance

### Interview Objectives

1. Understand business drivers and strategic priorities
2. Identify current pain points and challenges
3. Gather context for technical findings
4. Uncover perception vs. reality gaps
5. Build relationships with key stakeholders

---

## Executive Stakeholder Questions

**Target Audience:** CTO, CIO, VP of Engineering, IT Director

### Strategic Context (10 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | What are the top 3 business priorities for the next 12-18 months? | |
| 2 | How does technology/cloud enable these business priorities? | |
| 3 | What does success look like for this assessment? | |
| 4 | Are there any initiatives currently in flight that we should be aware of? | |

### Current State Perception (10 min)

| # | Question | Notes |
|---|----------|-------|
| 5 | How would you rate your current Azure maturity on a scale of 1-5? | |
| 6 | What aspects of your Azure environment are you most confident about? | |
| 7 | What keeps you up at night regarding your cloud infrastructure? | |
| 8 | Have you had any significant incidents in the past 12 months? | |

### Investment & Constraints (10 min)

| # | Question | Notes |
|---|----------|-------|
| 9 | What is your current cloud budget? Is it growing, stable, or under pressure? | |
| 10 | Are there any budget constraints for remediation activities? | |
| 11 | What is your appetite for investment in optimization vs. new capabilities? | |
| 12 | Are there any regulatory or compliance requirements we should know about? | |

### Future State (10 min)

| # | Question | Notes |
|---|----------|-------|
| 13 | Where do you want to be in 12-24 months? | |
| 14 | Are there any specific capabilities you're looking to enable (AI, data analytics, etc.)? | |
| 15 | How important is innovation vs. operational excellence? | |
| 16 | What would make this engagement a success from your perspective? | |

### Wrap-up

| # | Question | Notes |
|---|----------|-------|
| 17 | Is there anything else we should know that we haven't covered? | |
| 18 | Who else should we speak to for technical details? | |

---

## Technical Stakeholder Questions

**Target Audience:** Cloud Architects, Platform Engineers, DevOps Leads

### Current Architecture (15 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | Can you walk us through your current Azure architecture at a high level? | |
| 2 | What is your subscription and management group structure? | |
| 3 | How is networking organized? (Hub-spoke, flat, etc.) | |
| 4 | What are your critical workloads and their tier classifications? | |
| 5 | Which Azure services do you rely on most heavily? | |

### Design Decisions (10 min)

| # | Question | Notes |
|---|----------|-------|
| 6 | What were the key design decisions made when building this environment? | |
| 7 | Are there any decisions you would make differently today? | |
| 8 | What constraints influenced the current architecture? | |
| 9 | Is there a landing zone pattern in use? (CAF, Enterprise-Scale, custom) | |

### Operations & Automation (15 min)

| # | Question | Notes |
|---|----------|-------|
| 10 | How is infrastructure deployed? (IaC, portal, hybrid) | |
| 11 | What percentage of your infrastructure is managed as code? | |
| 12 | Do you have CI/CD pipelines for infrastructure? | |
| 13 | What monitoring and alerting is in place? | |
| 14 | How are incidents detected and responded to? | |
| 15 | Are there documented runbooks for common operations? | |

### Security & Compliance (10 min)

| # | Question | Notes |
|---|----------|-------|
| 16 | How is identity and access managed? | |
| 17 | Is MFA enforced? For which user groups? | |
| 18 | How are secrets and certificates managed? | |
| 19 | What security tools are in use? (Defender, Sentinel, third-party) | |
| 20 | Are there specific compliance requirements? (ISO, SOC2, HIPAA, etc.) | |

### Pain Points (10 min)

| # | Question | Notes |
|---|----------|-------|
| 21 | What are the top 3 technical challenges you face? | |
| 22 | Are there any recurring issues or incidents? | |
| 23 | What takes longer than it should? | |
| 24 | Are there any skill gaps in the team? | |
| 25 | What would make your job easier? | |

### Future Plans (5 min)

| # | Question | Notes |
|---|----------|-------|
| 26 | Are there any upcoming migrations or new deployments planned? | |
| 27 | Any plans to adopt new Azure services? | |
| 28 | Is there interest in AI/ML capabilities? | |

---

## Security Stakeholder Questions

**Target Audience:** CISO, Security Architects, Security Engineers

### Security Posture (10 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | How would you rate your current security posture? | |
| 2 | What is your current Defender Secure Score? | |
| 3 | Are you aware of any current vulnerabilities or risks? | |
| 4 | Have you had any security incidents in the past 12 months? | |

### Identity & Access (10 min)

| # | Question | Notes |
|---|----------|-------|
| 5 | Is MFA enforced for all users? | |
| 6 | How is privileged access managed? (PIM, JIT, manual) | |
| 7 | How are service accounts and managed identities used? | |
| 8 | What is your approach to third-party/vendor access? | |
| 9 | Is there a regular access review process? | |

### Network Security (10 min)

| # | Question | Notes |
|---|----------|-------|
| 10 | Is there network segmentation in place? | |
| 11 | How is north-south and east-west traffic controlled? | |
| 12 | Are private endpoints used for PaaS services? | |
| 13 | What is your approach to public endpoints? | |
| 14 | Is there a WAF in front of web applications? | |

### Data Protection (10 min)

| # | Question | Notes |
|---|----------|-------|
| 15 | Is data classified according to sensitivity? | |
| 16 | Is encryption at rest enabled for all storage? | |
| 17 | How is encryption key management handled? | |
| 18 | Are there data loss prevention controls? | |
| 19 | How is data residency managed? | |

### Compliance & Governance (10 min)

| # | Question | Notes |
|---|----------|-------|
| 20 | What compliance frameworks apply? (ISO, SOC2, GDPR, HIPAA) | |
| 21 | How is compliance monitored and reported? | |
| 22 | Are Azure Policies in use? | |
| 23 | Is there a security baseline defined? | |
| 24 | How are security exceptions managed? | |

### Detection & Response (5 min)

| # | Question | Notes |
|---|----------|-------|
| 25 | Is Microsoft Sentinel or a SIEM in use? | |
| 26 | What is the process for security incident response? | |
| 27 | Are there security automation/playbooks? | |

---

## FinOps / Finance Stakeholder Questions

**Target Audience:** Finance Manager, FinOps Lead, Cost Center Owners

### Current Spend (10 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | What is your current monthly Azure spend? | |
| 2 | How has spend trended over the past 12 months? | |
| 3 | Is spend within budget? | |
| 4 | What are the top 3 cost drivers? | |

### Cost Management (10 min)

| # | Question | Notes |
|---|----------|-------|
| 5 | How are costs allocated across teams/projects? | |
| 6 | Is there a tagging strategy for cost attribution? | |
| 7 | Are budgets and alerts configured? | |
| 8 | How often are costs reviewed? | |
| 9 | Is there a FinOps practice or team? | |

### Optimization (10 min)

| # | Question | Notes |
|---|----------|-------|
| 10 | Are Reserved Instances or Savings Plans in use? | |
| 11 | What is your RI coverage percentage? | |
| 12 | Have rightsizing exercises been done? | |
| 13 | Are there known areas of waste? | |
| 14 | What is the approval process for new resources? | |

### Future (5 min)

| # | Question | Notes |
|---|----------|-------|
| 15 | Is the cloud budget expected to grow? | |
| 16 | Are there cost reduction targets? | |
| 17 | What would "optimized" look like to you? | |

---

## DevOps / Platform Team Questions

**Target Audience:** DevOps Engineers, Platform Engineers, SREs

### Deployment & Automation (15 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | What tools do you use for CI/CD? (Azure DevOps, GitHub Actions, etc.) | |
| 2 | How are application deployments managed? | |
| 3 | How is infrastructure deployed? (Terraform, Bicep, ARM, portal) | |
| 4 | What is the deployment frequency? | |
| 5 | How are environments managed? (Dev, Test, Prod) | |
| 6 | Is there environment parity? | |

### Monitoring & Observability (10 min)

| # | Question | Notes |
|---|----------|-------|
| 7 | What monitoring tools are in use? | |
| 8 | Are logs centralized? | |
| 9 | How are alerts managed? Is there alert fatigue? | |
| 10 | Are dashboards used? For whom? | |
| 11 | Is APM (Application Insights) in use? | |

### Incident Management (10 min)

| # | Question | Notes |
|---|----------|-------|
| 12 | What is the incident response process? | |
| 13 | What was the last major incident? What happened? | |
| 14 | How are post-incident reviews handled? | |
| 15 | Are there documented runbooks? | |
| 16 | What is the on-call rotation like? | |

### Challenges (10 min)

| # | Question | Notes |
|---|----------|-------|
| 17 | What are your biggest operational challenges? | |
| 18 | What takes too long or is too manual? | |
| 19 | Are there reliability concerns? | |
| 20 | What would improve your team's effectiveness? | |

---

## Application Owner Questions

**Target Audience:** Application Owners, Product Managers, Business Analysts

### Application Overview (10 min)

| # | Question | Notes |
|---|----------|-------|
| 1 | What does this application do? Who uses it? | |
| 2 | How critical is this application? (Tier 1/2/3) | |
| 3 | What are the SLA requirements? | |
| 4 | What Azure services does it use? | |

### Performance & Reliability (10 min)

| # | Question | Notes |
|---|----------|-------|
| 5 | How does the application perform? Any issues? | |
| 6 | Are there peak usage periods? | |
| 7 | Has there been downtime in the past year? | |
| 8 | What is the disaster recovery capability? | |

### Future Needs (5 min)

| # | Question | Notes |
|---|----------|-------|
| 9 | Are there upcoming changes or enhancements? | |
| 10 | Any new capabilities needed? (AI, integrations, etc.) | |
| 11 | Are there scalability concerns? | |

---

## Interview Summary Template

Complete after each interview:

### Interview Details

| Field | Value |
|-------|-------|
| Interviewee | |
| Role | |
| Date | |
| Duration | |
| Interviewer | |

### Key Takeaways

1.
2.
3.

### Perception vs. Reality Insights

| Topic | Stakeholder Belief | Likely Reality | Validation Needed |
|-------|-------------------|----------------|-------------------|
| | | | |
| | | | |

### Pain Points Mentioned

1.
2.
3.

### Strategic Priorities

1.
2.
3.

### Follow-up Actions

- [ ]
- [ ]

### Quotes to Reference

> "[Notable quote from stakeholder]"

---

## Best Practices

### During the Interview

1. **Listen more than talk** - Let the stakeholder share their perspective
2. **Take detailed notes** - Capture specific examples and quotes
3. **Ask follow-up questions** - Dig deeper when something interesting emerges
4. **Watch for body language** - Notice hesitation, frustration, enthusiasm
5. **Validate understanding** - Summarize back to confirm accuracy

### After the Interview

1. **Debrief immediately** - Capture insights while fresh
2. **Identify themes** - Look for patterns across interviews
3. **Note discrepancies** - Different stakeholders may have different views
4. **Update assessment focus** - Adjust technical analysis based on context
5. **Share with team** - Align on findings before presenting

### Common Anti-Patterns to Avoid

| Don't | Do |
|-------|-----|
| Lead with technical jargon | Use business language |
| Make assumptions | Ask clarifying questions |
| Promise specific outcomes | Set appropriate expectations |
| Focus only on problems | Acknowledge strengths too |
| Rush through questions | Allow time for thoughtful answers |

---

*Azure Enterprise Solutions Architecture Assessment Toolkit*
*github.com/maree217/azure-enterprise-solutions-architecture*
