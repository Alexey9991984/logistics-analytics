# Logistics Transport — Data Analytics Project

An end-to-end data analytics project for a logistics company focused on tracking truck trips, trailer usage, driver assignments, and route efficiency across Europe.

Built with **PostgreSQL** and visualized in **Power BI**.

> 🚧 **Project Status: In Development**
>
> This project is actively being expanded and improved. New datasets, analytical views, KPIs, and Power BI dashboards are continuously being added.

---

## Dashboard Preview

![Dashboard Overview](screenshots/dashboard_overview.PNG)

![Empty KM Analysis](screenshots/dashboard_empty_km.PNG)

---

## Project Structure

```text
├── SQL/
│   ├── DDL_schema.sql
│   ├── drivers.sql
│   ├── addtrucks.sql
│   ├── addtrailers.sql
│   ├── trip2026_03_22-2026_04_03.sql
│   ├── trip2026_04_12-2026_04_24.sql
│   ├── trip2026_05_25-2026_06_12.sql
│   ├── vw_trip_analysis_logistic.sql
│   └── DML_queries.sql
│
├── screenshots/
│
├── powerbi/
│   └── logistic.pbix
│
└── README.md
```

---

## Database Schema

### Core Tables

* **drivers** — driver registry
* **trucks** — truck registry
* **trailers** — trailer registry
* **trips** — trip records linking drivers, trucks, and trailers
* **trip_events** — operational event log
* **truck_driver_assignments** — driver-truck assignment history
* **truck_trailer_assignments** — truck-trailer assignment history

### Analytical View

The core analytical view **vw_trip_analysis_logistic** joins all operational tables and provides:

* Event sequencing using SQL window functions
* Distance calculations between logistics events
* Loaded vs Empty movement classification
* Operational cycle tracking
* Stop duration analysis
* Wash station efficiency monitoring

Additional calculated fields include:

* `km_from_previous_event`
* `km_to_next_event`
* `movement_type`
* `full_operational_cycle`

---

## Key Metrics

| Metric           | Description                                   |
| ---------------- | --------------------------------------------- |
| Total KM         | Total distance travelled                      |
| Loaded KM        | Distance driven with cargo                    |
| Empty KM         | Distance driven without cargo                 |
| Empty %          | Share of empty distance                       |
| Average Empty KM | Average empty leg distance                    |
| Stop Duration    | Time spent at locations                       |
| Wash Efficiency  | Detection of inefficient wash-station detours |

---

## Power BI Dashboard

### Page 1 — Overview

* Fleet activity summary
* Trip details table
* Filters by truck, trailer, driver, and date

### Page 2 — Empty KM Analysis

* Empty KM by location
* Empty movement analysis
* Detailed operational table

### Page 3 — Additional Analytics *(currently under development)*

Planned features:

* Driver performance metrics
* Trailer utilization analysis
* Route efficiency comparison
* Cost-related logistics KPIs

---

## How to Run

### 1. Create Schema

```sql
CREATE SCHEMA logistic;
```

### 2. Execute SQL Files

Run files in the following order:

```text
DDL_schema.sql
drivers.sql
addtrucks.sql
addtrailers.sql
trip2026_03_22-2026_04_03.sql
trip2026_04_12-2026_04_24.sql
trip2026_05_25-2026_06_12.sql
vw_trip_analysis_logistic.sql
```

### 3. Open Power BI

Open:

```text
powerbi/logistic.pbix
```

Update PostgreSQL connection settings:

```text
Host: localhost
Database: postgres
Schema: logistic
```

---

## Tech Stack

* PostgreSQL 16
* SQL & Window Functions
* Database Modeling
* DBeaver
* Power BI Desktop
* Business Intelligence & Data Analytics

---

## Roadmap

* Additional logistics KPIs
* Driver utilization metrics
* Trailer utilization dashboard
* Route optimization analysis
* Cost and profitability reporting
* Enhanced Power BI dashboard design

---

## Author

Portfolio project created to demonstrate practical skills in:

* SQL Data Modeling
* PostgreSQL
* Power BI
* Business Intelligence
* Logistics Data Analytics

The project is continuously evolving as new business requirements and analytical scenarios are implemented.


---

## Author

Built as a portfolio project demonstrating SQL data modeling and BI reporting for logistics operations.
