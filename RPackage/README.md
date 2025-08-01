# ResearchPak

Secure research dataset management with comprehensive audit logging for sensitive data analysis in R.

## Features

- **Parquet-based data storage** for efficient compression and fast access
- **Comprehensive audit logging** of all data access operations
- **Lazy evaluation support** for large datasets
- **Metadata catalog** for dataset discovery
- **Clean abstraction layer** for converting to R dataframes
- **Built-in statistics** and dataset information utilities

## Installation

```r
# Install from GitHub
remotes::install_github("yourusername/ResearchPak")
```

## Quick Start

```r
library(ResearchPak)

# View available datasets
show_catalog()

# Load a dataset as dataframe
df <- as_dataframe("judicial_cases")

# Get dataset statistics
stats <- dataset_stats("judicial_cases")
print(stats)

# View recent audit log entries
view_audit_log()
```

## Usage Examples

### Basic Dataset Operations

```r
# List all available datasets
datasets <- list_datasets()

# Load dataset (returns Arrow table)
arrow_data <- load_dataset("judicial_cases")

# Convert to R dataframe
df <- as_dataframe("judicial_cases")

# Apply filters during conversion
df_filtered <- as_dataframe(
  "judicial_cases",
  filter_expr = quote(year >= 2020 & status == "closed")
)

# Select specific columns
df_subset <- as_dataframe(
  "judicial_cases",
  select_cols = c("case_id", "year", "outcome")
)
```

### Lazy Evaluation for Large Datasets

```r
# Create lazy dataset reference
lazy_df <- lazy_dataset("judicial_cases")

# Chain operations before collecting
result <- lazy_df |>
  filter(year > 2020) |>
  select(case_id, year, judge_id) |>
  group_by(judge_id) |>
  summarise(n_cases = n()) |>
  collect()  # Execute and bring into memory
```

### Dataset Information and Statistics

```r
# Get comprehensive metadata
metadata <- dataset_metadata("judicial_cases")

# Get basic statistics
stats <- dataset_stats("judicial_cases")

# Check last update time
last_update <- dataset_last_updated("judicial_cases")

# Show detailed catalog
show_catalog(detailed = TRUE)
```

### Audit Logging

```r
# View recent audit log
view_audit_log()

# Filter audit log by dataset
view_audit_log(dataset = "judicial_cases")

# Filter by operation type
view_audit_log(operation = "as_dataframe")

# View last 50 entries
view_audit_log(last_n = 50)
```

## Preparing Datasets

Convert your CSV files to parquet format:

```r
# Run from package root directory
source("data-raw/prepare-datasets.R")
```

This script will:
- Read CSV files from the `datasets/` directory
- Convert them to compressed parquet format
- Store them in `inst/extdata/datasets/`
- Handle decimal comma formatting (European locale)

## Configuration

### Log Directory

By default, logs are stored in a temporary directory. Set a permanent location:

```r
Sys.setenv(RESEARCHPAK_LOG_DIR = "/path/to/logs")
```

### Session Management

Each R session gets a unique ID for tracking operations:

```r
# Get current session ID
get_session_id()
```

## Package Structure

```
ResearchPak/
├── R/
│   ├── data-source.R         # Core data loading functions
│   ├── dataframe-abstraction.R # DataFrame conversion layer
│   ├── utils-stats.R         # Statistical utilities
│   ├── audit-logger.R        # Logging functionality
│   ├── catalog.R             # Data catalog functions
│   └── zzz.R                 # Package startup/shutdown
├── inst/extdata/datasets/    # Parquet files location
└── tests/                    # Unit tests
```

## Security Considerations

- All data access operations are logged with timestamp, user, and session ID
- Datasets are read-only within the package
- No direct SQL queries allowed - all access through package functions
- Audit logs are append-only and stored separately from data

## Development

```r
# Load package for development
devtools::load_all()

# Run tests
devtools::test()

# Check package
devtools::check()

# Build documentation
devtools::document()
```

## License

MIT
