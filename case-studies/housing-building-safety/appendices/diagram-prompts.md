# NanoBanana Pro Diagram Prompts

## Meridian Housing Group - Hero Diagram Generation

*Prompts for generating professional architecture diagrams using NanoBanana Pro or similar AI diagram tools.*

---

## Overview

These prompts are designed for use with AI-powered diagram generation tools to create consistent, professional architecture visuals for the Building Safety Platform case study.

---

## Diagram 1: Three-Layer Architecture Overview

### Purpose
Hero diagram showing the complete Building Safety Platform architecture across all three layers.

### NanoBanana Pro Prompt

```
Create a professional enterprise architecture diagram for a Building Safety Platform using a three-layer framework.

LAYOUT: Vertical stack with three horizontal layers, bottom to top.

LAYER 3 (Bottom) - INFRASTRUCTURE FOUNDATION:
- Title: "Layer 3: Infrastructure" with subtitle "30-50% savings"
- Color scheme: Blue tones (#0078D4)
- Components in rounded rectangles:
  - Azure Landing Zone (icon: cloud with shield)
  - API Management (icon: API gateway)
  - Logic Apps & Data Factory (icon: workflow)
  - Azure Monitor (icon: chart)
  - Key Vault (icon: key)
  - Entra ID (icon: identity)
- Below layer: Source systems as boxes (Northgate HMS, Keystone, Promaster, Gas-Track, SharePoint)
- Connection lines showing data flow upward

LAYER 2 (Middle) - INTELLIGENCE:
- Title: "Layer 2: Intelligence" with subtitle "2-4x ROI"
- Color scheme: Purple tones (#5C2D91)
- Central component: Microsoft Fabric Lakehouse (large, prominent)
  - Inside: Bronze → Silver → Gold medallion flow
- Surrounding components:
  - Dataverse (icon: database)
  - Azure AI Search (icon: magnifying glass)
  - Document Intelligence (icon: document scan)
  - Power BI (icon: chart)
- Connection lines to Layer 1 above

LAYER 1 (Top) - EXPERIENCE:
- Title: "Layer 1: Experience" with subtitle "5-10x ROI"
- Color scheme: Green tones (#107C10)
- Five application tiles:
  - Building Safety Portal (Power Apps icon)
  - Resident Portal (Power Pages icon)
  - Executive Dashboard (Power BI icon)
  - Mobile Surveyor App (phone icon)
  - Compliance Copilot (AI chat icon)
- Show user personas above: Staff, Residents, Executives, Surveyors

STYLE:
- Clean, modern enterprise style
- White background
- Consistent iconography (Fluent UI style)
- Subtle shadows for depth
- Clear flow arrows between layers
- Professional, suitable for executive presentations
```

---

## Diagram 2: Data Flow Architecture

### Purpose
Detailed view of data flows from source systems through the intelligence layer.

### NanoBanana Pro Prompt

```
Create a data flow architecture diagram showing integration patterns for a Building Safety Platform.

LAYOUT: Left to right flow with vertical groupings.

LEFT SECTION - SOURCE SYSTEMS:
- Title: "Source Systems"
- Vertical stack of system boxes:
  - Northgate (SQL icon, label: "Properties, Tenancies")
  - Keystone (database icon, label: "Fire Risk Assessments")
  - Gas-Track (cloud icon, label: "Gas Certificates")
  - Promaster (cloud icon, label: "Asbestos Surveys")
  - SharePoint (folder icon, label: "Documents")
- Each box shows data volume (e.g., "28,000 records")

MIDDLE SECTION - INTEGRATION:
- Title: "Integration Layer"
- Azure API Management gateway at top
- Logic Apps flows (show as workflow icons)
- Data Factory pipelines (show as ETL arrows)
- Transformation icons between source and destination

RIGHT SECTION - DATA PLATFORM:
- Title: "Microsoft Fabric Lakehouse"
- Three horizontal tiers:
  - Bronze (raw, copper color): "Raw Data"
  - Silver (cleansed, silver color): "Conformed Data"
  - Gold (analytics, gold color): "Business Ready"
- Arrows showing transformation flow downward (Bronze → Silver → Gold)
- Output arrows to:
  - Dataverse (operational)
  - Power BI (analytics)
  - AI Search (documents)

FLOW ARROWS:
- Solid lines for batch flows
- Dashed lines for real-time/event flows
- Labels on arrows showing frequency (Daily, Hourly, Real-time)

STYLE:
- Technical but accessible
- Color-coded by system type
- Clear directional flow
- Include small icons for data types
- Azure blue for integration components
```

---

## Diagram 3: User Experience Map

### Purpose
Show how different user personas interact with the platform applications.

### NanoBanana Pro Prompt

```
Create a user experience map showing how different personas use the Building Safety Platform.

LAYOUT: Radial or hub-spoke design with platform in center.

CENTER HUB:
- Building Safety Platform logo/icon
- Subtitle: "Unified Compliance Platform"
- Circular design with Dataverse at core

PERSONA SPOKES (5 segments around center):

1. COMPLIANCE TEAM (Top, blue):
- Persona: Staff icon with "50 users"
- Application: Building Safety Portal
- Key tasks: "Manage compliance, Track actions, Search documents"
- Device: Desktop icon

2. SURVEYORS (Top-right, green):
- Persona: Hard hat icon with "25 users"
- Application: Mobile Surveyor App
- Key tasks: "Inspections, Photo capture, Offline access"
- Device: Phone/tablet icon

3. EXECUTIVES (Right, purple):
- Persona: Executive icon with "10 users"
- Application: Executive Dashboard
- Key tasks: "KPI monitoring, Board reporting, Risk oversight"
- Device: Desktop/tablet icon

4. RESIDENTS (Bottom, orange):
- Persona: Family icon with "8,500 potential"
- Application: Resident Portal
- Key tasks: "Building safety info, Report concerns, View certificates"
- Device: Phone icon

5. ALL STAFF (Left, teal):
- Persona: Group icon with "450 users"
- Application: Compliance Copilot
- Key tasks: "Ask questions, Find documents, Get guidance"
- Device: Teams icon

CONNECTING ELEMENTS:
- Lines from each persona to center showing data flow
- Icons showing key features for each (search, alerts, mobile)
- Satisfaction scores or adoption rates as small badges

STYLE:
- Friendly, business-appropriate
- Persona illustrations (simple, inclusive)
- Warm colors for external users, cool for internal
- Clean, not cluttered
- Suitable for stakeholder presentations
```

---

## Diagram 4: Building Safety Act Compliance Mapping

### Purpose
Show how platform capabilities map to Building Safety Act requirements.

### NanoBanana Pro Prompt

```
Create a compliance mapping diagram showing Building Safety Act requirements and platform capabilities.

LAYOUT: Two-column mapping with connecting lines.

LEFT COLUMN - BSA REQUIREMENTS:
- Title: "Building Safety Act 2022"
- UK Government crest icon
- Requirement boxes (formal, document style):
  1. "Building Safety Cases for all higher-risk buildings"
  2. "Golden Thread of building information"
  3. "Resident Engagement Strategy"
  4. "Mandatory Occurrence Reporting"
  5. "Regulator Information Requests"
  6. "Competent Person records"

RIGHT COLUMN - PLATFORM CAPABILITIES:
- Title: "Platform Capabilities"
- Technology icons
- Capability boxes (modern, tech style):
  1. "BSC Module in Staff Portal"
  2. "Fabric Lakehouse + Document Repository"
  3. "Resident Portal + Concern Reporting"
  4. "Automated Alert Workflows"
  5. "Compliance Copilot + Export Tools"
  6. "Training Record Storage"

CONNECTING LINES:
- Match requirements to capabilities with curved lines
- Color-code: Green = fully met, Amber = partially met
- Show compliance status icon at each connection

FOOTER:
- Status summary: "47/47 buildings compliant"
- Last assessment date
- Regulator submission ready icon

STYLE:
- Professional, regulatory appropriate
- UK Government design language for requirements
- Modern tech style for capabilities
- Clear visual mapping
- Suitable for compliance documentation
```

---

## Diagram 5: Implementation Timeline

### Purpose
Visual roadmap of the 18-month implementation journey.

### NanoBanana Pro Prompt

```
Create a Gantt-style implementation timeline for an 18-month enterprise platform programme.

LAYOUT: Horizontal timeline with phase swim lanes.

TIMELINE:
- X-axis: Months (Jan 2024 to Jun 2025)
- Quarter markers: Q1 2024, Q2 2024, Q3 2024, Q4 2024, Q1 2025, Q2 2025
- Today marker if applicable

PHASE SWIM LANES:

ROW 1 - ASSESSMENT (Jan-Mar 2024):
- Color: Gray
- Bar spanning 3 months
- Key milestones: "Interviews", "Architecture", "Business Case"
- End milestone: Diamond icon "Assessment Complete"

ROW 2 - LAYER 3: INFRASTRUCTURE (Apr-Jun 2024):
- Color: Blue
- Bar spanning 3 months
- Key activities: "Landing Zone", "Security", "Connectivity"
- End milestone: Diamond icon "Foundation Live"

ROW 3 - LAYER 2: INTELLIGENCE (Jul-Dec 2024):
- Color: Purple
- Bar spanning 6 months
- Key activities: "Fabric", "Integrations", "Analytics", "Documents"
- End milestone: Diamond icon "Data Platform Live"

ROW 4 - LAYER 1: EXPERIENCE (Jan-Jun 2025):
- Color: Green
- Bar spanning 6 months
- Key activities: "Staff Portal", "Mobile App", "Resident Portal", "Copilot"
- End milestone: Diamond icon "Full Go-Live"

ROW 5 - CHANGE MANAGEMENT (Ongoing):
- Color: Orange
- Spanning full timeline
- Key activities: "Communications", "Training", "Adoption"

MILESTONE CALLOUTS:
- Show key deliverables at major milestones
- ROI indicators at each phase end

STYLE:
- Clean Gantt chart style
- Phase colors matching three-layer framework
- Clear milestone diamonds
- Suitable for steering group presentations
```

---

## Usage Notes

### Tool Compatibility

These prompts are optimised for:
- NanoBanana Pro
- DALL-E 3 (with architecture prompt engineering)
- Midjourney (with --style raw flag)
- Stable Diffusion (with diagram LoRA)

### Customisation

When using these prompts:
1. Replace "Meridian Housing Group" with actual client name
2. Adjust user numbers to match reality
3. Update colors to match brand guidelines
4. Modify component names for actual technology choices

### Export Formats

Request outputs in:
- SVG for scalability
- PNG at 4K resolution for presentations
- PDF for documentation

---

*Diagram Prompts Version: 1.0*
*Last Updated: [Date]*
