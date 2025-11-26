# Assessment Presentation Guide

Best practices for presenting Azure architecture assessment findings effectively.

---

## Presentation Philosophy

### Core Principles

1. **Data-Driven, Not Opinion-Based**
   - Lead with extracted evidence, not assumptions
   - Show specific numbers and configurations
   - Let data tell the story

2. **Perception vs. Reality**
   - Gently surface blind spots
   - Use "we found" not "you did wrong"
   - Position as discovery, not criticism

3. **Strategic Alignment**
   - Connect findings to business objectives
   - Frame recommendations in business value
   - Speak executive language to executives

4. **Actionable Outcomes**
   - Every finding has a recommendation
   - Every recommendation has an effort estimate
   - Provide a clear path forward

---

## Audience Tailoring

### Executive Presentation (30-45 min)

**Focus:** Strategic, business impact, investment decisions

| Include | Exclude |
|---------|---------|
| Overall maturity score | Technical implementation details |
| Key risks in business terms | Specific resource configurations |
| Financial impact (cost, savings) | Command-line outputs |
| Strategic roadmap | Detailed task lists |
| Investment ask | Technical jargon |

**Tone:** Confident, consultative, business-focused

**Key Messages:**
1. Here's where you are (maturity score)
2. Here are the key risks (top 3)
3. Here's the opportunity (savings, enablement)
4. Here's what we recommend (phased roadmap)
5. Here's the investment required

### Technical Leadership Presentation (60-90 min)

**Focus:** Detailed findings, technical recommendations, implementation path

| Include | Exclude |
|---------|---------|
| WAF pillar deep-dives | Executive summaries only |
| Specific findings with evidence | High-level generalizations |
| Architecture diagrams | Business platitudes |
| Technical recommendations | Non-technical explanations |
| Implementation details | Excessive context |

**Tone:** Peer-to-peer, technical, collaborative

**Key Messages:**
1. Here's what we found in each WAF pillar
2. Here are the specific gaps with evidence
3. Here's how to fix each issue
4. Here's the priority order and dependencies
5. Here's what we can help with

### Operations/Engineering Presentation (90 min)

**Focus:** Detailed findings, hands-on remediation, knowledge transfer

| Include | Exclude |
|---------|---------|
| Specific resource configurations | Business strategy |
| Script outputs and queries | Executive summaries |
| Step-by-step remediation | High-level roadmaps |
| IaC templates | Investment discussions |
| Hands-on demonstrations | Policy conversations |

**Tone:** Technical mentor, knowledge sharing, practical

---

## Presentation Structure

### Executive Presentation Outline

```
1. Introduction (5 min)
   └── Assessment overview and methodology

2. Executive Summary (10 min)
   ├── Overall maturity score
   ├── Key metrics at a glance
   └── Top 3 findings

3. Strategic Findings (10 min)
   ├── Strengths (what's working)
   ├── Opportunities (what needs attention)
   └── Risks (what could hurt)

4. Financial Analysis (5 min)
   ├── Current spend
   ├── Optimization opportunity
   └── Investment vs. return

5. Recommendations (10 min)
   ├── Prioritized roadmap
   ├── Investment summary
   └── Expected outcomes

6. Next Steps (5 min)
   └── Decision points and options
```

### Technical Presentation Outline

```
1. Assessment Overview (10 min)
   ├── Scope and methodology
   ├── Data sources used
   └── Framework applied

2. Current State Analysis (15 min)
   ├── Environment overview
   ├── Architecture observations
   └── Three-Layer classification

3. WAF Deep-Dive (30 min)
   ├── Reliability assessment
   ├── Security assessment
   ├── Cost assessment
   ├── Operations assessment
   └── Performance assessment

4. Gap Analysis (15 min)
   ├── Critical gaps
   ├── High-priority gaps
   └── Improvement opportunities

5. Recommendations (15 min)
   ├── Quick wins (with demos/examples)
   ├── Short-term initiatives
   ├── Strategic projects
   └── Implementation considerations

6. Q&A and Discussion (15 min)
```

---

## Slide Templates

### Title Slide

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│          AZURE ARCHITECTURE ASSESSMENT                          │
│                                                                  │
│          [Client Name]                                          │
│                                                                  │
│          [Date]                                                  │
│                                                                  │
│          Presented by: [Your Name]                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Executive Summary Slide

```
┌─────────────────────────────────────────────────────────────────┐
│ EXECUTIVE SUMMARY                                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ Overall Maturity: [3.2/5]  ████████░░░░  DEFINED                │
│                                                                  │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐              │
│ │  RESOURCES   │ │   MONTHLY    │ │   SAVINGS    │              │
│ │     342      │ │    £45K      │ │   £8K/mo     │              │
│ └──────────────┘ └──────────────┘ └──────────────┘              │
│                                                                  │
│ TOP FINDINGS:                                                    │
│ ○ Security gaps require immediate attention                     │
│ ○ Significant cost optimization opportunity                     │
│ ○ Operational automation below industry standard                │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Maturity Radar Slide

```
┌─────────────────────────────────────────────────────────────────┐
│ WELL-ARCHITECTED FRAMEWORK MATURITY                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│                    Reliability                                   │
│                       3.8                                        │
│                        *                                         │
│                       /|\                                        │
│                      / | \                                       │
│     Performance    /  |  \    Security                          │
│         3.5      *    |    *     2.4                            │
│                   \   |   /                                      │
│                    \  |  /                                       │
│                     \ | /                                        │
│                      \|/                                         │
│                       *                                          │
│         Cost                Operations                           │
│          4.0                    2.8                              │
│                                                                  │
│ [Blue = Current]  [Gray = Target 4.0]                           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Finding Slide

```
┌─────────────────────────────────────────────────────────────────┐
│ FINDING: [Title]                                    [CRITICAL]  │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│ CURRENT STATE                                                    │
│ ─────────────                                                    │
│ [Description of what was found, with specific data]             │
│                                                                  │
│ EVIDENCE                                                         │
│ ─────────                                                        │
│ • [Specific metric or configuration]                            │
│ • [Screenshot or data excerpt]                                  │
│                                                                  │
│ IMPACT                                                           │
│ ─────────                                                        │
│ [Business impact if not addressed]                              │
│                                                                  │
│ RECOMMENDATION                                                   │
│ ─────────────                                                    │
│ [Specific action to take]                                       │
│                                                                  │
│ EFFORT: [Low/Med/High]     PRIORITY: [1-2-3]                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Roadmap Slide

```
┌─────────────────────────────────────────────────────────────────┐
│ IMPLEMENTATION ROADMAP                                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│    Month 1        Month 2        Month 3        Month 4+        │
│ ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐      │
│ │ PHASE 1  │   │ PHASE 2  │   │ PHASE 3  │   │ PHASE 4  │      │
│ │ Quick    │──▶│Foundation│──▶│ Optimize │──▶│Transform │      │
│ │ Wins     │   │          │   │          │   │          │      │
│ └──────────┘   └──────────┘   └──────────┘   └──────────┘      │
│                                                                  │
│ Key Deliverables:                                                │
│ • Phase 1: Security fixes, waste removal                        │
│ • Phase 2: Landing zone, IaC baseline                           │
│ • Phase 3: Monitoring, automation                               │
│ • Phase 4: AI enablement, innovation                            │
│                                                                  │
│ TOTAL INVESTMENT: £XXX    EXPECTED SAVINGS: £XXX/year           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Presentation Techniques

### Opening Strong

**Do:**
- Thank stakeholders for their time and access
- Acknowledge the work that's already been done
- Set expectations for the session
- Preview the key message

**Example Opening:**
> "Thank you for the opportunity to assess your Azure environment. Over the past two weeks, we've analyzed 342 resources across 5 subscriptions, interviewed 8 stakeholders, and evaluated your architecture against Microsoft's Well-Architected Framework. Today, I'll share what we found, what it means for your business, and a practical path forward."

### Handling Difficult Findings

**Do:**
- Use objective language ("we observed" not "you failed")
- Lead with data, not judgment
- Acknowledge context and constraints
- Focus on solutions, not blame

**Example:**
> "When we examined the network security group configurations, we observed that 23 rules allow inbound traffic from any source. This is common in environments that evolved organically, and the good news is this can be addressed quickly with minimal disruption."

**Don't:**
> "Your NSG rules are completely open and anyone could attack you."

### Addressing Objections

| Objection | Response Approach |
|-----------|-------------------|
| "We knew about that" | "That's great - this data can help prioritize when to address it" |
| "That's by design" | "Help me understand the context - there may be a safer way to achieve the same goal" |
| "We don't have budget" | "Let's focus on quick wins first - some items have zero cost" |
| "We don't have time" | "The roadmap is phased specifically for teams with limited capacity" |
| "The vendor told us to do it this way" | "Vendor defaults aren't always optimal - let's validate together" |

### Closing Strong

**Do:**
- Summarize the top 3 takeaways
- Clarify the decision being requested
- Offer specific next steps
- Express confidence in the path forward

**Example Closing:**
> "In summary: your environment has a solid foundation with some important security gaps to address. We've identified £96K in potential annual savings and a clear path to AI readiness. The question for your team is which option makes sense: addressing quick wins only, establishing the full foundation, or committing to the complete transformation. We're here to support whichever path you choose."

---

## Visual Best Practices

### Color Coding

| Color | Use For |
|-------|---------|
| Red | Critical findings, high severity |
| Orange/Yellow | High/medium findings, warnings |
| Green | Strengths, completed, good |
| Blue | Current state, neutral |
| Gray | Target state, comparison |

### Chart Selection

| Data Type | Chart Type |
|-----------|------------|
| Maturity scores | Radar chart |
| Resource distribution | Pie or bar chart |
| Spend trends | Line chart |
| Prioritization | 2x2 matrix |
| Timelines | Gantt or swimlane |
| Comparisons | Bar chart |

### Slide Design

- Maximum 6 bullet points per slide
- One key message per slide
- Use visuals where possible
- Consistent formatting throughout
- Include page numbers
- Add "Confidential" watermark

---

## Q&A Preparation

### Anticipated Questions

| Question | Prepared Response |
|----------|-------------------|
| "How does this compare to others in our industry?" | [Have benchmarks ready] |
| "What's the most critical thing to fix?" | [Have top 3 ready with rationale] |
| "How long will remediation take?" | [Reference roadmap phases] |
| "What if we do nothing?" | [Quantify risk and opportunity cost] |
| "Can your team help implement?" | [Have proposal options ready] |
| "Why didn't we catch this ourselves?" | [Non-judgmental, external perspective value] |

### Handling Unknown Questions

**Response Framework:**
1. Acknowledge the question
2. Admit if you don't know
3. Commit to follow-up
4. Note it visibly

**Example:**
> "That's a great question about the specific latency requirements for your trading system. I don't have that detail in the assessment data, but I'll follow up with a specific analysis by end of week."

---

## Post-Presentation Actions

### Immediate (Same Day)

- [ ] Send thank you note to attendees
- [ ] Share presentation slides
- [ ] Document questions asked
- [ ] Note any commitments made
- [ ] Schedule follow-up if requested

### Within 48 Hours

- [ ] Send formal deliverables package
- [ ] Provide answers to open questions
- [ ] Share proposal for next phase (if applicable)
- [ ] Request feedback on assessment

### Within 1 Week

- [ ] Follow up on decision status
- [ ] Offer clarification session if needed
- [ ] Provide additional resources requested

---

## Common Pitfalls to Avoid

| Pitfall | Prevention |
|---------|------------|
| Too technical for executives | Know your audience, adjust language |
| Too high-level for engineers | Prepare detailed appendices |
| Overwhelming with findings | Prioritize and phase |
| Negative/critical tone | Focus on solutions, not problems |
| Unrealistic recommendations | Ground in client's actual capacity |
| Missing the "so what" | Always connect to business impact |
| Running over time | Practice and time yourself |
| Reading from slides | Know your material |
| Ignoring audience cues | Watch body language, adjust |
| No clear ask at the end | Always have a call to action |

---

## Presentation Checklist

### Before

- [ ] Slides reviewed and finalized
- [ ] Technology tested (screen share, audio)
- [ ] Backup plan for tech issues
- [ ] Presentation timed (under limit)
- [ ] Key messages memorized
- [ ] Q&A responses prepared
- [ ] Next steps options ready

### During

- [ ] Start on time
- [ ] Introduce yourself and agenda
- [ ] Check in with audience periodically
- [ ] Manage time actively
- [ ] Note questions for follow-up
- [ ] End with clear call to action

### After

- [ ] Thank attendees
- [ ] Share materials
- [ ] Follow up on commitments
- [ ] Request feedback
- [ ] Archive materials

---

*Azure Enterprise Solutions Architecture Assessment Toolkit*
*github.com/maree217/azure-enterprise-solutions-architecture*
