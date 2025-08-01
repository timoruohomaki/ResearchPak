# ResearchPak: Secure R Processing Environment for Sensitive Research Data

[![Security: Audited](https://img.shields.io/badge/Security-Audited-green.svg)](TECHNICAL-SECURITY-REFERENCE.md)
[![GDPR: Compliant](https://img.shields.io/badge/GDPR-Compliant-blue.svg)](docs/compliance.md)
[![R: 4.3+](https://img.shields.io/badge/R-4.3+-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

ResearchPak is a **secure processing environment** that enables controlled access to sensitive research data while maintaining comprehensive audit trails and preventing unauthorized data exfiltration. Built on R package architecture and deployed within RStudio Server, ResearchPak implements the principle of **"bringing researchers to the data"** rather than releasing data to researchers.

### Key Features

- 🔒 **Closed Environment with No Direct Internet Access** - Complete network isolation for sensitive data processing
- 🔐 **Multi-Factor Authentication Required** - Strong authentication using institutional credentials
- 📊 **Pre-approved R Package Ecosystem** - Curated repository of validated analytical tools
- 📝 **Comprehensive Audit Logging** - Complete processing and event history for all data operations
- 🎯 **Data Minimization by Design** - Access only to approved cohorts and variables
- 🔍 **Pseudonymized Data Handling** - Automatic de-identification of personal identifiers
- ✅ **Result Verification Process** - Only anonymized results can leave the environment
- 🏛️ **GDPR Article 32 Compliant** - Technical and organizational measures for data protection

## Architecture

ResearchPak operates as a controlled-access analytical workspace within a secure RStudio Server environment:

```
┌─────────────────────────────────────────┐
│          External Network               │
└────────────────┬────────────────────────┘
                 │ HTTPS/TLS 1.3
         ┌───────┴───────┐
         │  Auth Proxy   │ ← OAuth2/SAML
         └───────┬───────┘
                 │ Internal Network Only
    ┌────────────┼────────────────────┐
    │   ┌────────┴────────┐           │
    │   │ RStudio Server  │           │
    │   │  + ResearchPak  │           │
    │   └────────┬────────┘           │
    │            │                    │
    │   ┌────────┴────────┐           │
    │   │ Encrypted Data  │           │
    │   │   (Parquet)     │           │
    │   └─────────────────┘           │
    └─────────────────────────────────┘
         Isolated Container
```

## Use Cases

ResearchPak supports secure research on sensitive data including:

- **Health and Social Care Research** - Analysis of patient records, treatment outcomes, and population health
- **Biomedical Studies** - Genomic data analysis, clinical trial data processing
- **Social Science Research** - Longitudinal studies with personal data
- **Public Policy Analysis** - Government registry data analysis
- **Educational Research** - Student performance data with privacy protection

## Getting Started

### For Researchers

1. **Obtain Research Approval**
   - Submit your research plan to the Data Controller
   - Specify required cohorts and variables
   - Await permit approval

2. **Access the Environment**
   ```r
   # After approval, load ResearchPak in RStudio
   library(ResearchPak)
   
   # Authenticate (automatic with SSO)
   authenticate_researcher()
   
   # View available datasets
   list_approved_datasets()
   ```

3. **Perform Analysis**
   ```r
   # Load your approved cohort
   cohort_data <- load_research_data("cohort_2024_001")
   
   # Use pre-approved packages for analysis
   library(dplyr)
   library(ggplot2)
   
   # All operations are automatically logged
   summary_stats <- cohort_data %>%
     group_by(treatment_group) %>%
     summarise(mean_outcome = mean(outcome_variable))
   ```

4. **Export Results**
   ```r
   # Request export of anonymized results
   export_results(
     data = summary_stats,
     description = "Treatment group comparison",
     output_file = "results_summary.csv"
   )
   # Results undergo verification before approval
   ```

### For Data Controllers

1. **Package Creation**
   ```r
   # Create a new research package
   create_research_package(
     source_data = "registry_extract.csv",
     research_plan = "approved_plan_2024_001.pdf",
     cohort_definition = cohort_spec,
     retention_days = 365
   )
   ```

2. **Access Management**
   ```r
   # Grant researcher access
   grant_access(
     researcher_id = "jane.doe@university.edu",
     package_id = "research_pkg_2024_001",
     expiry_date = "2025-12-31"
   )
   ```

### For System Administrators

See the [deployment guide](docs/deployment.md) for detailed installation instructions.

## Security Features

### Data Protection
- **Encryption at Rest**: AES-256-GCM for all stored data
- **Encryption in Transit**: TLS 1.3 minimum for all connections
- **Key Management**: Integration with HashiCorp Vault or AWS KMS
- **Secure Deletion**: NIST 800-88 compliant data disposal

### Access Control
- **Role-Based Access Control (RBAC)**: Granular permissions by research role
- **Project-Specific Environments**: Isolated workspaces per research project
- **Automatic Session Timeout**: Configurable idle and maximum session limits
- **IP Address Restrictions**: Access only from approved networks

### Audit & Compliance
- **Comprehensive Audit Trail**: Who accessed what data, when, and how
- **Real-time Security Monitoring**: Anomaly detection and alerting
- **GDPR Compliance Tools**: Built-in privacy impact assessment support
- **Automated Compliance Reports**: Regular reports for oversight bodies

## System Requirements

### Server Requirements
- **OS**: Ubuntu 20.04+ or RHEL 8+
- **CPU**: Minimum 8 cores (16+ recommended)
- **RAM**: Minimum 32GB (64GB+ recommended)
- **Storage**: 500GB+ SSD for data and logs
- **R**: Version 4.3.0 or higher
- **RStudio Server**: Version 2023.12.0 or higher

### Client Requirements
- Modern web browser (Chrome, Firefox, Edge)
- Stable internet connection
- Institutional authentication credentials

## Documentation

- [Technical Security Reference](TECHNICAL-SECURITY-REFERENCE.md) - Detailed security architecture and controls
- [Roles and User Stories](ROLES-AND-USER-STORIES.md) - User roles and functionality overview
- [Terminology Guide](TERMINOLOGY.md) - Industry-standard terminology and concepts
- [API Documentation](docs/api-reference.md) - Package function reference
- [Deployment Guide](docs/deployment.md) - Installation and configuration
- [Compliance Guide](docs/compliance.md) - GDPR and regulatory compliance

## Logging and Monitoring

ResearchPak integrates with enterprise logging infrastructure:

```r
# Example log entry (JSON format)
{
  "timestamp": "2025-01-31 14:23:45",
  "level": "AUDIT",
  "event_type": "DATA_ACCESS",
  "user": "researcher01",
  "session_id": "550e8400-e29b-41d4-a716",
  "project": "cohort_2024_001",
  "action": "query_execution",
  "query_hash": "a7b9c3d2",
  "rows_affected": 1523,
  "execution_time_ms": 245
}
```

Integration supported with:
- NXLog for centralized log management
- Splunk, ELK Stack, or Azure Sentinel for SIEM
- Prometheus + Grafana for metrics

## Contributing

We welcome contributions that enhance security, usability, or analytical capabilities. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup
```bash
# Clone the repository
git clone https://github.com/your-org/researchpak.git

# Install development dependencies
cd researchpak
R -e "devtools::install_deps()"

# Run tests
R CMD check .
```

## Support

- **Technical Issues**: [GitHub Issues](https://github.com/your-org/researchpak/issues)
- **Security Concerns**: security@your-organization.com
- **General Inquiries**: researchpak-support@your-organization.com

## License

ResearchPak is released under the [MIT License](LICENSE). See the license file for details.

## Acknowledgments

ResearchPak's secure processing model is inspired by established platforms like [Findata Kapseli®](https://findata.fi/en/kapseli/) and follows industry best practices for sensitive data environments.

## Compliance

ResearchPak is designed to support compliance with:
- EU General Data Protection Regulation (GDPR)
- National data protection legislation
- ISO 27001 Information Security Standards
- Research ethics requirements

---

**ResearchPak** - Enabling Secure Research on Sensitive Data

*Secure. Audited. Compliant.*
