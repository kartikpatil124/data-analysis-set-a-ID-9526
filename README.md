# Delivery Delay Analysis – Set A

**Name:** Kartik Patil  
**Student ID:** 9526
**Set:** Set A  
**Repo:** data-analysis-set-a-9526

## What is this about?

The business question is:  
*Which service type has the greatest delivery‑delay burden, and which hub needs priority attention?*

I analysed a small synthetic dataset of delivery records to find out.

## Files in data/raw

- `deliveries.csv` – 13 rows (includes one duplicate)
- `routes.csv` – 4 rows (lookup for route and service type)

## Data dictionary

**deliveries.csv**
- `record_id` – number
- `month` – Jan, Feb, Mar
- `route_id` – R1, R2, R3, R4
- `hub` – Mumbai, Chennai, Delhi
- `promised_days` – number
- `actual_days` – number

**routes.csv**
- `route_id` – R1 to R4
- `route` – route name
- `service_type` – Express or Standard

## Cleaning steps

1. Removed the duplicate row from deliveries. Now 12 rows.
2. Merged deliveries with routes using `route_id`.
3. Added `delay_days = MAX(actual_days - promised_days, 0)`.
4. Delay incidence rate = (rows where actual > promised) / total rows.

## Tools I used

- Excel
- MySQL 8.0
- Python 3.10
- Power BI Desktop
- Git

## Folder structure

```
data-analysis-set-d-123456/
├── README.md
├── requirements.txt
├── .gitignore
├── data/raw/
│   ├── deliveries.csv
│   └── routes.csv
├── excel/analysis.xlsx
├── sql/setup.sql
├── sql/queries.sql
├── python/analysis.py
├── powerbi/dashboard.pbix
└── outputs/
    ├── clean_data.csv
    ├── python_summary.csv
    ├── python_chart.png
    ├── powerbi_dashboard.png
    └── sql/
        ├── s2a_delay_by_service_type.csv
        ├── s2b_routes_over_8.csv
        ├── s2c_top_two_hubs.csv
        └── s3_route_id_integrity_check.csv
```

## How to run SQL

1. Open MySQL and run `sql/setup.sql` first.
2. Then run `sql/queries.sql`.
3. Results are saved in `outputs/sql/`.

## How to run Python

From the repo folder:

```bash
pip install -r requirements.txt
python python/analysis.py
```

This creates the chart and CSV files in `outputs/`.

## Excel sheets

- **Raw** – original 13 rows
- **Lookup** – routes data
- **Clean** – 12 rows with service_type and delay_days
- **Summary** – SUMIFS by hub, PivotTable by service type and month, column chart

## Power BI refresh

Open `powerbi/dashboard.pbix`.  
Go to Data source settings and change the paths to your `data/raw/` folder.  
Click Refresh. The report has cards, bar chart, monthly trend, and a hub slicer.

## Findings

1. **Standard** service type has the most delay: **22 delay days** (Express has 12).
2. **Mumbai** hub has the highest delay: **15 delay days** (Delhi 14, Chennai 5).

## Recommendation

Focus on route **R4 (Rural Feeder)** and hub **Mumbai**. R4 alone causes 14 out of 34 total delay days (41.18%). A quick review of scheduling or capacity there could help.

**Limitation:** Only 12 rows, so results are just for this exercise.

## Cross‑tool reconciliation

I checked total delay_days for **Standard** service type:

- Excel: 22
- SQL: 22
- Python: 22
- Power BI: 22

All match. No rounding issues.

## Video

Link: [paste your unlisted YouTube or Drive link]  
Duration: 7 minutes 30 seconds

## References

None. All work is my own.

## Authorship

All work in this repository is my own except where cited.
