# Notebooks - Exploratory Analysis & Visualizations

This directory contains Jupyter notebooks for exploratory data analysis and business intelligence visualizations of the Pipedrive CRM sales funnel data.

## 📁 Notebooks Overview

### 1. `exploratory_analysis.ipynb`
**Purpose**: Comprehensive exploratory data analysis (EDA) of Pipedrive CRM source data

**Contents**:
- **Methodology & Approach**: Systematic analysis framework
- **Data Overview**: Database schema exploration and table counts
- **Stages Analysis**: Sales funnel stage structure and validation
- **Activity Types**: Activity type identification and mapping
- **Deal Changes Analysis**: Event-sourcing pattern analysis for funnel reconstruction
- **Activities Analysis**: Sales call activities and deal relationships
- **Data Relationships**: Referential integrity validation
- **Data Quality Checks**: Completeness, consistency, and validity assessment
- **Monthly Funnel Distribution**: Preview of aggregated funnel data
- **Key Insights & Analysis Summary**: Comprehensive findings and recommendations

**Key Features**:
- Systematic top-down analysis approach
- Event-sourcing pattern recognition
- Data quality-first methodology
- Business logic validation
- dbt modeling preparation
- Risk assessment and mitigation strategies

### 2. `visualizations.ipynb`
**Purpose**: Business intelligence dashboard with comprehensive sales funnel visualizations

**Contents**:
- **Comprehensive BI Dashboard**: 8 integrated visualizations
  1. Funnel Chart - Latest month stage distribution
  2. Monthly Trends - Top 5 stages over time
  3. Conversion Rates - Stage-by-stage conversion percentages
  4. Performance Heatmap - Monthly performance across all stages
  5. Key Metrics Summary - Overall conversion and performance indicators
  6. Stage Distribution - Pie chart of deal distribution
  7. Cumulative Flow - Cumulative deal progression
  8. Month-over-Month Comparison - Growth trends and changes

**Key Features**:
- Production-ready dashboard visualizations
- Color-coded performance indicators
- Annotated charts with insights
- Summary statistics and metrics

## 🚀 Setup & Installation

### Prerequisites
- Python 3.8+
- PostgreSQL database (via Docker Compose)
- Jupyter Notebook or JupyterLab

### Installation Steps

1. **Install Python dependencies**:
```bash
cd analysis
pip install -r requirements.txt
```

2. **Start PostgreSQL database**:
```bash
# From project root
docker compose up -d
```

3. **Verify database connection**:
   - Host: `localhost`
   - Database: `postgres`
   - User: `admin`
   - Password: `admin`
   - Port: `5432`

4. **Run dbt models** (required for visualizations):
```bash
# From project root
dbt run
```

5. **Launch Jupyter**:
```bash
jupyter notebook
# or
jupyter lab
```

## 📊 Usage

### Running Exploratory Analysis

1. Open `exploratory_analysis.ipynb`
2. Execute cells sequentially from top to bottom
3. Review findings in the Key Insights section
4. Use insights to inform dbt model development

### Running Visualizations

1. Ensure dbt models are built (`dbt run`)
2. Open `visualizations.ipynb`
3. Execute all cells to generate the BI dashboard
4. Review visualizations and metrics

## 📦 Dependencies

See `requirements.txt` for complete list. Key packages:
- `pandas`: Data manipulation and analysis
- `psycopg2-binary`: PostgreSQL database connector
- `matplotlib`: Plotting and visualization
- `seaborn`: Statistical visualizations
- `numpy`: Numerical computing
- `jupyter`: Notebook environment

## 🏗️ Data Flow Architecture

### Source Layer (PostgreSQL)
- `public.stages` - Sales funnel stages lookup
- `public.activity_types` - Activity type metadata
- `public.deal_changes` - Historical deal state changes (event log)
- `public.activity` - Deal activities (calls, meetings)

### Staging Layer (dbt)
- `stg_stages` - Cleaned stages lookup
- `stg_activity_types` - Cleaned activity types
- `stg_deal_changes` - Type-casted deal changes (VARCHAR → INTEGER)
- `stg_activity` - Cleaned activities

### Intermediate Layer (dbt)
- `int_deal_stage_transitions` - First entry per deal per stage (MIN aggregation)
- `int_deal_activities` - First occurrence of Sales Call activities
- `int_deal_funnel_entries` - Unified view combining stages and activities

### Marts Layer (dbt)
- `rep_sales_funnel_monthly` - Final reporting model with monthly aggregation

### Notebooks Layer
- Exploratory analysis queries source tables directly
- Visualizations query marts layer (`rep_sales_funnel_monthly`)

## 📈 Analysis Methodology

### 1. Top-Down Analysis
- Start with high-level overview
- Progressively drill down into specifics
- End with detailed validation

### 2. Event-Sourcing Pattern Recognition
- Identify immutable event logs
- Understand aggregation requirements (MIN for first entry)
- Prevent double-counting in metrics

### 3. Data Quality First
- Validate completeness early
- Identify type casting requirements
- Check referential integrity
- Document findings for dbt tests

### 4. Business Logic Validation
- Map technical to business requirements
- Validate funnel step definitions
- Ensure stage names align with business needs

### 5. dbt Modeling Preparation
- Identify staging requirements
- Design intermediate structure
- Plan marts output format

## 🔍 Key Findings

### Data Architecture
- Event-sourcing pattern in `deal_changes` table
- 9 main stages + 2 activity sub-steps = 11 funnel steps
- Strong referential integrity maintained
- Data completeness score: ~98%

### Technical Considerations
- Type casting required: `new_value::integer` for stage_id
- MIN() aggregation critical for first entry identification
- Monthly aggregation using `DATE_TRUNC('month', change_time)`
- LEFT JOINs required (not all deals have activities)

### Data Quality
- Primary keys: 100% populated
- Some null values in timestamps (acceptable for incomplete activities)
- No orphaned records detected
- Conversion rate anomalies (>100%) require business validation

## 📝 Notes

- Notebooks connect to localhost Postgres database
- Database credentials match docker-compose setup
- Exploratory analysis should be run before building dbt models
- Visualizations require dbt models to be materialized
- All queries use `public_pipedrive_analytics` schema for dbt models

## 🔗 Related Documentation

- Main project README: `../README.md`
- dbt project configuration: `../dbt_project.yml`
- dbt sources definition: `../models/sources.yml`
- dbt models documentation: `../models/schema.yml`

## 🎯 Best Practices

1. **Run exploratory analysis first** to understand data structure
2. **Validate findings** before building dbt models
3. **Use insights** to inform dbt test requirements
4. **Document assumptions** and business rules
5. **Review visualizations** for data quality anomalies

## 📧 Support

For questions or issues:
1. Review the Key Insights section in `exploratory_analysis.ipynb`
2. Check dbt documentation: `dbt docs generate && dbt docs serve`
3. Review data lineage: `dbt docs generate`
