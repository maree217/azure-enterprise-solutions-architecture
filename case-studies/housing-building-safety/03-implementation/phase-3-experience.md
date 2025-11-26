# Phase 3: Experience

## Meridian Housing Group - Application Delivery

*Layer 1 implementation delivering user-facing applications on top of the data platform.*

---

## Overview

Phase 3 delivers the applications that staff and residents use daily. This phase realises the majority of user benefits and requires strong change management focus.

**Duration:** 24 weeks (Q1-Q2 2025)
**Team:** Power Platform Developer x2, UX Designer, BA, Change Lead

---

## Sprint Breakdown

### Sprint 19-20: Staff Portal Foundation (Weeks 1-4)

**Objective:** Model-driven app structure and navigation

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design information architecture | UX Designer | 3 days | User research |
| Create model-driven app | PP Developer | 2 days | Dataverse |
| Configure site map | PP Developer | 2 days | IA design |
| Create forms - Building | PP Developer | 3 days | Site map |
| Create views - Building list | PP Developer | 2 days | Forms |
| Configure navigation | PP Developer | 1 day | Views |
| Security role configuration | PP Developer | 2 days | App structure |
| Initial user testing | BA | 3 days | App |

**Deliverables:**
- Model-driven app shell
- Building entity forms and views
- Navigation structure
- Initial user feedback

**Exit Criteria:**
- [ ] Staff can browse buildings
- [ ] Security roles restrict data
- [ ] User feedback incorporated

---

### Sprint 21-22: Building Compliance Views (Weeks 5-8)

**Objective:** Complete building safety view

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Building compliance dashboard | PP Developer | 3 days | Sprint 19-20 |
| Fire Risk Assessment view | PP Developer | 2 days | Dashboard |
| FRA Actions sub-grid | PP Developer | 2 days | FRA view |
| Building Safety Case tab | PP Developer | 3 days | Dashboard |
| Documents tab (embed search) | PP Developer | 2 days | AI Search |
| Timeline view | PP Developer | 2 days | Dataverse |
| Business rules (alerts) | PP Developer | 2 days | Views |
| User testing | BA | 3 days | All above |

**Deliverables:**
- Complete building compliance view
- FRA and action management
- Document search integration
- Timeline of compliance events

**Exit Criteria:**
- [ ] All building data accessible
- [ ] FRA actions visible and editable
- [ ] Documents searchable from building
- [ ] User feedback positive

---

### Sprint 23-24: Property and Certificate Management (Weeks 9-12)

**Objective:** Property-level compliance views and workflows

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Property forms and views | PP Developer | 3 days | Sprint 21-22 |
| Certificate sub-grid | PP Developer | 2 days | Property |
| Certificate detail view | PP Developer | 2 days | Sub-grid |
| Expiry alert workflow | PP Developer | 2 days | Certificate |
| No-access tracking | PP Developer | 2 days | Property |
| Certificate upload | PP Developer | 2 days | Doc pipeline |
| Integration with Northgate | PP Developer | 3 days | APIM |
| User testing | BA | 3 days | All above |

**Deliverables:**
- Complete property compliance view
- Certificate management
- Automated expiry alerts
- No-access workflow

**Exit Criteria:**
- [ ] All certificates visible at property
- [ ] Expiry alerts generating
- [ ] No-access cases tracked
- [ ] Work order creation working

---

### Sprint 25-26: Mobile Surveyor App (Weeks 13-16)

**Objective:** Offline-capable mobile app for field workers

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design mobile screens | UX Designer | 3 days | User research |
| Create canvas app | PP Developer 2 | 3 days | Design |
| Configure offline mode | PP Developer 2 | 3 days | Canvas app |
| Inspection forms | PP Developer 2 | 3 days | Canvas app |
| Photo capture component | PP Developer 2 | 2 days | Forms |
| Signature capture | PP Developer 2 | 2 days | Forms |
| GPS tagging | PP Developer 2 | 1 day | Canvas app |
| Offline sync logic | PP Developer 2 | 2 days | Offline mode |
| Field testing | Surveyors | 3 days | All above |

**Deliverables:**
- Canvas app for iOS/Android
- Offline data capability
- Inspection forms with photos
- Signature capture
- GPS location logging

**Exit Criteria:**
- [ ] Works in basement (no signal)
- [ ] Photos attach to records
- [ ] Syncs when back online
- [ ] Surveyor approval

---

### Sprint 27-28: Staff Portal UAT and Pilot (Weeks 17-18)

**Objective:** Validate and pilot staff applications

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Prepare UAT scenarios | BA | 2 days | All above |
| Staff portal UAT | Compliance team | 4 days | Scenarios |
| Mobile app UAT | Surveyors | 3 days | Scenarios |
| Address UAT findings | PP Developers | 4 days | UAT |
| Pilot preparation | Change Lead | 2 days | UAT complete |
| Pilot (10 users) | Pilot users | 5 days | Preparation |
| Pilot feedback review | PM | 2 days | Pilot |

**Deliverables:**
- UAT sign-off
- Pilot report
- Refinement backlog

**Exit Criteria:**
- [ ] UAT scenarios pass
- [ ] Pilot users satisfied (>80%)
- [ ] Critical issues resolved
- [ ] Ready for rollout

---

### Sprint 29-30: Staff Portal Go-Live (Weeks 19-20)

**Objective:** Full rollout to compliance team and surveyors

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Final refinements | PP Developers | 3 days | Pilot feedback |
| Training delivery | Change Lead | 5 days | Training materials |
| Go-live preparation | PM | 2 days | Training |
| Staff portal go-live | Team | 1 day | Preparation |
| Mobile app go-live | Team | 1 day | Staff portal |
| Floor walking support | Champions | 5 days | Go-live |
| Issue resolution | PP Developers | 3 days | Support |

**Deliverables:**
- All compliance staff on portal
- All surveyors on mobile app
- Support model operational

**Exit Criteria:**
- [ ] >80% users active
- [ ] Critical issues <5
- [ ] Support tickets manageable

---

### Sprint 31-32: Resident Portal (Weeks 21-24)

**Objective:** External portal for resident engagement

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Design resident UX | UX Designer | 3 days | User research |
| Create Power Pages site | PP Developer | 2 days | Design |
| Configure authentication | PP Developer | 2 days | Entra B2C |
| Build "My Home" page | PP Developer | 3 days | Site |
| Build "My Building" page | PP Developer | 3 days | Site |
| Concern reporting form | PP Developer | 2 days | Site |
| Safety works page | PP Developer | 2 days | Site |
| Accessibility testing | UX Designer | 2 days | Site |
| Soft launch (1 building) | Team | 3 days | Testing |

**Deliverables:**
- Power Pages site live
- Resident authentication
- Building safety information
- Concern reporting

**Exit Criteria:**
- [ ] WCAG 2.1 AA compliant
- [ ] Authentication working
- [ ] Soft launch feedback positive

---

### Sprint 33-34: Compliance Copilot (Weeks 25-26)

**Objective:** AI assistant for compliance queries

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Configure Copilot Studio | PP Developer 2 | 2 days | Licence |
| Connect to AI Search | PP Developer 2 | 2 days | Search index |
| Configure RAG responses | PP Developer 2 | 3 days | AI Search |
| Create conversation flows | PP Developer 2 | 3 days | RAG |
| Integrate with Teams | PP Developer 2 | 1 day | Flows |
| Embed in staff portal | PP Developer 2 | 1 day | Portal |
| Test and refine responses | PP Developer 2 | 3 days | All above |
| User acceptance | Compliance team | 2 days | Testing |

**Deliverables:**
- Copilot answering compliance questions
- RAG from golden thread documents
- Available in Teams and portal

**Exit Criteria:**
- [ ] Answers >80% of test questions correctly
- [ ] Response time <5 seconds
- [ ] Users find it helpful

---

### Sprint 35-36: Full Go-Live and Closure (Weeks 27-28)

**Objective:** Complete rollout and project closure

| Task | Owner | Duration | Dependencies |
|------|-------|----------|--------------|
| Resident portal full launch | Team | 2 days | Soft launch |
| Resident communications | Change Lead | 3 days | Launch |
| Final refinements | PP Developers | 3 days | Feedback |
| Documentation handover | Architect | 2 days | All complete |
| Support transition | PM | 2 days | Handover |
| Benefits baseline capture | BA | 2 days | Go-live |
| Project closure report | PM | 2 days | All above |
| Celebration | Team | 1 day | Closure |

**Deliverables:**
- All applications live
- Documentation complete
- Support model operational
- Project closed

**Exit Criteria:**
- [ ] All users onboarded
- [ ] Documentation accepted
- [ ] Support team trained
- [ ] Benefits baseline recorded

---

## User Interface Standards

### Design System

| Element | Specification |
|---------|---------------|
| Primary colour | Meridian Blue (#005A9C) |
| Secondary colour | Safety Orange (#FF6B00) |
| Font | Segoe UI (M365 standard) |
| Icons | Fluent UI icons |
| Responsive | Mobile-first design |

### Accessibility Requirements

| Requirement | Standard | Testing |
|-------------|----------|---------|
| Contrast ratio | 4.5:1 minimum | Colour checker |
| Keyboard navigation | Full support | Manual test |
| Screen reader | Compatible | NVDA testing |
| Focus indicators | Visible | Visual test |
| Error messages | Descriptive | User testing |
| WCAG level | 2.1 AA | Automated + manual |

---

## Integration Points

### Staff Portal Integrations

| Integration | Purpose | Method |
|-------------|---------|--------|
| Dataverse | All data | Native |
| Power BI | Embedded reports | Embed |
| AI Search | Document search | Custom connector |
| Northgate | Work order creation | API via APIM |
| SharePoint | Document storage | Native |

### Mobile App Integrations

| Integration | Purpose | Method |
|-------------|---------|--------|
| Dataverse | Data (offline) | Native offline |
| Camera | Photo capture | Device API |
| GPS | Location logging | Device API |
| Signature | Sign-off capture | Component |

### Resident Portal Integrations

| Integration | Purpose | Method |
|-------------|---------|--------|
| Entra B2C | Authentication | Native |
| Dataverse | Data (read) | Web API |
| SharePoint | Document download | Secure link |

---

## Phase 3 Acceptance

### Technical Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| All apps functional | PP Developers | Test results |
| Performance acceptable | PP Developers | Load test |
| Security tested | Security Spec | Pen test |
| Accessibility compliant | UX Designer | WCAG audit |

### Business Acceptance

| Criterion | Verified By | Evidence |
|-----------|-------------|----------|
| Staff portal approved | Marcus Williams | UAT sign-off |
| Mobile app approved | Surveyors | Field testing |
| Resident portal approved | Sarah Chen | Review |
| Copilot useful | Compliance team | User testing |

---

## Post Go-Live

### Hypercare Period (4 weeks)

| Week | Focus | Support Level |
|------|-------|---------------|
| Week 1 | Critical issues | Full team |
| Week 2 | Refinements | Developers + support |
| Week 3 | Optimisation | Support + champion |
| Week 4 | Transition | Support only |

### Knowledge Transfer

| Session | Audience | Content |
|---------|----------|---------|
| Admin training | IT team | Configuration, monitoring |
| Support training | Service desk | Troubleshooting, escalation |
| Champion training | Champions | Advanced features, support |
| Documentation review | All | User guides, runbooks |

---

*Phase 3 Specification Version: 1.0*
*Last Updated: [Date]*
