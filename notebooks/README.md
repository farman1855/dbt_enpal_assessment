# Exploratory Analysis Notebook

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Make sure your Postgres database is running (via docker compose)

3. Open the notebook:
```bash
jupyter notebook exploratory_analysis.ipynb
```

## What's Included

The notebook covers:
- Data overview and table counts
- Stages analysis
- Activity types exploration
- Deal changes analysis (key for funnel)
- Activities analysis
- Data relationships
- Data quality checks
- Monthly funnel distribution preview
- Key insights and findings

## Notes

- Connects to localhost Postgres database
- Uses credentials from docker-compose setup
- Shows the analysis process used to understand the data before building dbt models
