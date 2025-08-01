# ResearchPak Roles and User Stories

## Table of Contents
1. [Role Definitions](#role-definitions)
2. [User Stories by Role](#user-stories-by-role)
3. [Epic Grouping Matrix](#epic-grouping-matrix)
4. [RACI Matrix](#raci-matrix)

## Role Definitions

### Primary Roles

| Role | Description | Key Responsibilities |
|------|-------------|---------------------|
| **Data Controller** | Official authorized to make decisions about data processing | • Approve research plans<br>• Ensure regulatory compliance<br>• Define data retention policies |
| **Research Applicant/PI** | Researcher who submits research plans and leads projects | • Define research requirements<br>• Manage team access<br>• Ensure research scope compliance |
| **Named Researcher** | Individual researchers granted access under specific permit | • Conduct approved analysis<br>• Export anonymized results<br>• Maintain research documentation |
| **Data Steward/Processor** | Technical role for data preparation and packaging | • Extract and transform data<br>• Apply pseudonymization<br>• Create ResearchPak packages |

### Governance & Oversight Roles

| Role | Description | Key Responsibilities |
|------|-------------|---------------------|
| **Data Protection Officer** | Oversees sensitive data processing operations | • Review audit logs<br>• Ensure GDPR compliance<br>• Handle data subject requests |
| **Information Security Officer** | Manages security aspects of the environment | • Approve software/packages<br>• Monitor security events<br>• Incident response |
| **Audit Reviewer** | Independent review of processing activities | • Validate data usage<br>• Generate compliance reports<br>• Verify anonymization |

### Technical Support Roles

| Role | Description | Key Responsibilities |
|------|-------------|---------------------|
| **System Administrator** | Manages infrastructure and user provisioning | • Maintain RStudio Server<br>• Handle access controls<br>• System updates/patches |
| **Package Curator** | Manages approved R package repository | • Test package security<br>• Maintain package whitelist<br>• Document capabilities |

### Extended Stakeholder Roles

| Role | Description | Key Responsibilities |
|------|-------------|---------------------|
| **Data Subject Representative** | Represents individuals whose data is processed | • Review consent compliance<br>• Validate anonymization<br>• Advocate for privacy |
| **Research Ethics Committee** | Reviews research plans for ethical compliance | • Approve research protocols<br>• Monitor ethical compliance<br>• Review significant changes |

## User Stories by Role

### Data Controller Stories

| ID | Story | Priority |
|----|-------|----------|
| US-001 | As a **Data Controller**, I want to review and approve research data requests so that I can ensure data usage complies with legal requirements and consent specifications. | High |
| US-002 | As a **Data Controller**, I want to define data retention periods and access expiration dates so that data is not retained longer than necessary for the approved research. | High |
| US-003 | As a **Data Controller**, I want to receive alerts about unusual data access patterns so that I can investigate potential misuse promptly. | Medium |

### Research Applicant/Principal Investigator Stories

| ID | Story | Priority |
|----|-------|----------|
| US-101 | As a **Research Applicant**, I want to submit a detailed research plan specifying required cohorts and variables so that I can obtain approval for data access. | High |
| US-102 | As a **Principal Investigator**, I want to manage my research team's access permissions so that named researchers can collaborate while maintaining security. | High |
| US-103 | As a **Principal Investigator**, I want to monitor my team's data usage and remaining compute resources so that I can manage the research project efficiently. | Medium |
| US-104 | As a **Principal Investigator**, I want to extend access periods before expiration so that research can continue without interruption. | Medium |

### Named Researcher Stories

| ID | Story | Priority |
|----|-------|----------|
| US-201 | As a **Named Researcher**, I want to access the secure R environment with my institutional credentials so that I can begin analysis without complex setup procedures. | High |
| US-202 | As a **Named Researcher**, I want to run predefined analytical queries on the cohort data so that I can perform statistical analysis within approved parameters. | High |
| US-203 | As a **Named Researcher**, I want to save my R scripts and intermediate results within the secure environment so that I can iterate on my analysis across sessions. | High |
| US-204 | As a **Named Researcher**, I want to export anonymized statistical results and visualizations so that I can include them in publications and reports. | High |
| US-205 | As a **Named Researcher**, I want to access comprehensive documentation and code examples so that I can use ResearchPak effectively without extensive training. | Medium |

### Data Steward/Processor Stories

| ID | Story | Priority |
|----|-------|----------|
| US-301 | As a **Data Steward**, I want to extract and transform registry data according to approved specifications so that research datasets contain only necessary information. | High |
| US-302 | As a **Data Steward**, I want to apply consistent pseudonymization across linked datasets so that researchers can perform analysis while protecting individual identity. | High |
| US-303 | As a **Data Steward**, I want to validate data packages against schema requirements so that researchers receive quality-assured datasets. | High |
| US-304 | As a **Data Steward**, I want to version control data packages so that research reproducibility is maintained and updates are tracked. | Medium |

### Data Protection Officer Stories

| ID | Story | Priority |
|----|-------|----------|
| US-401 | As a **Data Protection Officer**, I want to access comprehensive audit logs of all data processing activities so that I can demonstrate GDPR compliance. | High |
| US-402 | As a **Data Protection Officer**, I want to receive automated compliance reports so that I can identify and address privacy risks proactively. | Medium |
| US-403 | As a **Data Protection Officer**, I want to verify that data minimization principles are enforced so that researchers cannot access unnecessary personal information. | High |
| US-404 | As a **Data Protection Officer**, I want to handle data subject access requests efficiently so that individual rights are respected within legal timeframes. | Medium |

### Information Security Officer Stories

| ID | Story | Priority |
|----|-------|----------|
| US-501 | As an **Information Security Officer**, I want to review and approve new R package requests so that only secure, validated packages are available in the environment. | High |
| US-502 | As an **Information Security Officer**, I want to monitor real-time security events and anomalies so that I can respond to threats immediately. | High |
| US-503 | As an **Information Security Officer**, I want to enforce automatic session timeouts and access controls so that unauthorized access risks are minimized. | High |
| US-504 | As an **Information Security Officer**, I want to conduct regular security assessments of the environment so that vulnerabilities are identified and remediated. | Medium |

### System Administrator Stories

| ID | Story | Priority |
|----|-------|----------|
| US-601 | As a **System Administrator**, I want to provision RStudio Server instances automatically so that approved researchers get access quickly. | High |
| US-602 | As a **System Administrator**, I want to monitor system performance and resource usage so that I can ensure optimal performance for all users. | Medium |
| US-603 | As a **System Administrator**, I want to apply security patches and updates without disrupting active research sessions so that the environment remains secure and stable. | High |
| US-604 | As a **System Administrator**, I want to configure automated backups of the secure environment so that research work is protected against data loss. | Medium |

### Audit Reviewer Stories

| ID | Story | Priority |
|----|-------|----------|
| US-701 | As an **Audit Reviewer**, I want to query processing history by various criteria (user, date, data type) so that I can verify compliance with approved purposes. | High |
| US-702 | As an **Audit Reviewer**, I want to generate compliance reports for specific time periods so that I can support regulatory inspections. | High |
| US-703 | As an **Audit Reviewer**, I want to verify that exported results meet anonymization requirements so that no personal data leaves the secure environment. | High |

### Package Curator Stories

| ID | Story | Priority |
|----|-------|----------|
| US-801 | As a **Package Curator**, I want to test new R packages in an isolated environment so that I can verify compatibility and security before approval. | Medium |
| US-802 | As a **Package Curator**, I want to maintain a whitelist of approved packages with version controls so that researchers have access to stable, tested tools. | High |
| US-803 | As a **Package Curator**, I want to document package capabilities and limitations so that researchers can select appropriate tools for their analysis. | Medium |

### Cross-Functional Stories

| ID | Story | Priority |
|----|-------|----------|
| US-901 | As a **Research Team**, we want to collaborate on analysis within the same project space so that we can share code and insights securely. | Medium |
| US-902 | As a **New User** (any role), I want to complete role-specific onboarding training so that I understand my responsibilities and the platform's capabilities. | High |
| US-903 | As an **Authorized User**, I want to receive notifications about system maintenance and updates so that I can plan my work accordingly. | Medium |

## Epic Grouping Matrix

| Epic | Description | User Stories | Primary Roles |
|------|-------------|--------------|---------------|
| **Access Management & Authentication** | User provisioning, authentication, and access control | US-001, US-102, US-201, US-601, US-602 | Data Controller, PI, System Admin |
| **Data Preparation & Quality** | Data extraction, transformation, and packaging | US-301, US-302, US-303, US-304 | Data Steward |
| **Research Operations** | Core research activities and analysis | US-101, US-202, US-203, US-204, US-205, US-901 | Research Applicant, Named Researcher |
| **Compliance & Audit** | GDPR compliance and audit trail management | US-401, US-402, US-403, US-404, US-701, US-702, US-703 | DPO, Audit Reviewer |
| **Security Operations** | Security monitoring and incident response | US-003, US-501, US-502, US-503, US-504 | Info Security Officer |
| **Platform Administration** | System maintenance and package management | US-603, US-604, US-801, US-802, US-803 | System Admin, Package Curator |
| **User Experience & Support** | Training, documentation, and notifications | US-103, US-104, US-902, US-903 | All Roles |

### Epic Priority Matrix

| Epic | Strategic Value | Implementation Complexity | Priority | Dependencies |
|------|----------------|--------------------------|----------|--------------|
| Access Management & Authentication | High | Medium | 1 | None |
| Data Preparation & Quality | High | High | 2 | Access Management |
| Security Operations | High | Medium | 3 | Access Management |
| Research Operations | High | Medium | 4 | Data Prep, Security |
| Compliance & Audit | High | Low | 5 | All Core Functions |
| Platform Administration | Medium | Low | 6 | Access Management |
| User Experience & Support | Medium | Low | 7 | All Functions |

## RACI Matrix

### Key ResearchPak Processes

**Legend:**
- **R** = Responsible (performs the work)
- **A** = Accountable (ultimately answerable)
- **C** = Consulted (provides input)
- **I** = Informed (kept up-to-date)

| Process | Data Controller | Research PI | Named Researcher | Data Steward | DPO | Info Sec Officer | System Admin | Audit Reviewer | Package Curator |
|---------|----------------|-------------|------------------|--------------|-----|-----------------|--------------|----------------|-----------------|
| **Research Plan Approval** | A | R | I | C | C | C | - | I | - |
| **Data Extraction & Packaging** | A | C | - | R | C | I | I | I | - |
| **User Access Provisioning** | A | R | I | I | I | C | R | I | - |
| **Data Analysis** | I | A | R | - | I | I | - | I | - |
| **Result Export Approval** | C | A | R | - | C | C | - | C | - |
| **Security Monitoring** | I | I | - | - | C | R/A | C | I | - |
| **Audit Log Review** | I | I | - | - | R | C | - | R/A | - |
| **Package Approval** | I | C | C | - | I | A | - | - | R |
| **System Maintenance** | I | I | I | I | I | C | R/A | - | - |
| **Incident Response** | A | I | I | I | C | R/A | R | C | - |
| **Compliance Reporting** | C | I | - | I | R/A | C | I | R | - |
| **Data Retention Management** | A | C | - | R | C | I | I | I | - |
| **User Training** | I | C | C | C | C | C | R | - | C |
| **Access Review** | A | C | - | - | C | R | I | R | - |
| **Backup & Recovery** | I | - | - | - | I | C | R/A | - | - |

### Critical Process Details

#### Research Plan Approval Process
- **Trigger**: Research Applicant submits plan
- **Key Decision Points**: Data Controller approval, DPO privacy review, Info Sec risk assessment
- **Output**: Approved data specification for Data Steward

#### Data Analysis Process
- **Trigger**: Named Researcher logs into ResearchPak
- **Key Controls**: Predefined queries only, audit logging, session monitoring
- **Output**: Statistical results ready for export review

#### Result Export Approval Process
- **Trigger**: Researcher requests result export
- **Key Decision Points**: Anonymization verification, PI approval, audit review
- **Output**: Approved anonymized results

### Escalation Paths

| Issue Type | Level 1 | Level 2 | Level 3 |
|------------|---------|---------|---------|
| Access Issues | System Admin | Research PI | Data Controller |
| Security Events | Info Sec Officer | Data Controller | External CSIRT |
| Privacy Concerns | DPO | Data Controller | Regulatory Authority |
| Technical Problems | System Admin | Package Curator | Vendor Support |
| Compliance Issues | Audit Reviewer | DPO | Data Controller |

## Implementation Roadmap

### Phase 1: Foundation (Months 1-3)
- Implement Access Management & Authentication epic
- Establish basic Security Operations
- Deploy core Platform Administration

### Phase 2: Core Research (Months 4-6)
- Complete Data Preparation & Quality epic
- Enable Research Operations features
- Initial User Experience elements

### Phase 3: Compliance & Maturity (Months 7-9)
- Full Compliance & Audit implementation
- Advanced Security Operations
- Complete User Experience & Support

### Phase 4: Optimization (Months 10-12)
- Performance tuning
- Advanced analytics features
- Continuous improvement based on user feedback
