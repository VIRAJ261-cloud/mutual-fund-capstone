# Data Dictionary

## Project

**Bluestock Mutual Fund Data**

This document describes the tables, columns, data types, business definitions, and source datasets used in the SQLite star schema.

---

# 1. Dimension Table: dim_fund

**Source:** `01_fund_master.csv`

| Column             | Data Type | Business Definition                                  |
| ------------------ | --------- | ---------------------------------------------------- |
| fund_id            | INTEGER   | Surrogate primary key for each mutual fund.          |
| amfi_code          | INTEGER   | Unique AMFI code identifying the mutual fund scheme. |
| fund_house         | TEXT      | Name of the asset management company (AMC).          |
| scheme_name        | TEXT      | Name of the mutual fund scheme.                      |
| category           | TEXT      | Fund category (e.g., Equity, Debt, Hybrid).          |
| sub_category       | TEXT      | Sub-category of the mutual fund.                     |
| plan               | TEXT      | Investment plan (Direct/Regular, Growth/IDCW, etc.). |
| launch_date        | DATE      | Date on which the scheme was launched.               |
| benchmark          | TEXT      | Benchmark index used for comparison.                 |
| fund_manager       | TEXT      | Name of the fund manager.                            |
| risk_category      | TEXT      | Risk classification of the fund.                     |
| sebi_category_code | TEXT      | SEBI category code of the scheme.                    |

---

# 2. Dimension Table: dim_date

**Source:** Derived from all date columns across the datasets.

| Column     | Data Type | Business Definition                         |
| ---------- | --------- | ------------------------------------------- |
| date_id    | INTEGER   | Surrogate primary key for each unique date. |
| full_date  | DATE      | Complete calendar date.                     |
| day        | INTEGER   | Day of the month.                           |
| month      | INTEGER   | Month number (1-12).                        |
| month_name | TEXT      | Name of the month.                          |
| quarter    | INTEGER   | Quarter of the year (1-4).                  |
| year       | INTEGER   | Calendar year.                              |

---

# 3. Fact Table: fact_nav

**Source:** `02_nav_history.csv`

| Column  | Data Type | Business Definition                                  |
| ------- | --------- | ---------------------------------------------------- |
| nav_id  | INTEGER   | Primary key for NAV records.                         |
| fund_id | INTEGER   | Foreign key referencing dim_fund.                    |
| date_id | INTEGER   | Foreign key referencing dim_date.                    |
| nav     | REAL      | Net Asset Value (NAV) of the scheme on a given date. |

---

# 4. Fact Table: fact_transactions

**Source:** `08_investor_transactions.csv`

| Column             | Data Type | Business Definition                             |
| ------------------ | --------- | ----------------------------------------------- |
| transaction_id     | INTEGER   | Primary key for each transaction.               |
| fund_id            | INTEGER   | Foreign key referencing dim_fund.               |
| date_id            | INTEGER   | Foreign key referencing dim_date.               |
| transaction_type   | TEXT      | Type of transaction (SIP, Lumpsum, Redemption). |
| amount_inr         | REAL      | Transaction amount in Indian Rupees.            |
| investor_id        | TEXT      | Unique investor identifier.                     |
| state              | TEXT      | Investor's state.                               |
| city               | TEXT      | Investor's city.                                |
| city_tier          | TEXT      | Classification of city (Tier-1, Tier-2, etc.).  |
| age_group          | TEXT      | Investor age group.                             |
| gender             | TEXT      | Investor gender.                                |
| annual_income_lakh | REAL      | Annual income in lakhs of INR.                  |
| payment_mode       | TEXT      | Mode of payment used for the transaction.       |
| kyc_status         | TEXT      | Investor KYC verification status.               |

---

# 5. Fact Table: fact_performance

**Source:** `07_scheme_performance.csv`

| Column             | Data Type | Business Definition                           |
| ------------------ | --------- | --------------------------------------------- |
| performance_id     | INTEGER   | Primary key for performance records.          |
| fund_id            | INTEGER   | Foreign key referencing dim_fund.             |
| return_1yr_pct     | REAL      | One-year annual return percentage.            |
| return_3yr_pct     | REAL      | Three-year annual return percentage.          |
| return_5yr_pct     | REAL      | Five-year annual return percentage.           |
| benchmark_3yr_pct  | REAL      | Three-year benchmark return percentage.       |
| alpha              | REAL      | Risk-adjusted excess return over benchmark.   |
| beta               | REAL      | Measure of volatility compared to the market. |
| sharpe_ratio       | REAL      | Risk-adjusted return metric.                  |
| sortino_ratio      | REAL      | Downside risk-adjusted return metric.         |
| std_dev_ann_pct    | REAL      | Annualized standard deviation of returns.     |
| max_drawdown_pct   | REAL      | Maximum observed decline from peak value.     |
| expense_ratio_pct  | REAL      | Annual expense ratio charged by the fund.     |
| aum_crore          | REAL      | Assets Under Management (AUM) in crore INR.   |
| morningstar_rating | INTEGER   | Morningstar fund rating.                      |
| risk_grade         | TEXT      | Overall risk grade assigned to the scheme.    |

---

# 6. Fact Table: fact_aum

**Source:** `03_aum_by_fund_house.csv`

| Column         | Data Type | Business Definition                               |
| -------------- | --------- | ------------------------------------------------- |
| aum_id         | INTEGER   | Primary key for AUM records.                      |
| date_id        | INTEGER   | Foreign key referencing dim_date.                 |
| fund_house     | TEXT      | Name of the Asset Management Company (AMC).       |
| aum_lakh_crore | REAL      | Total Assets Under Management in lakh crore INR.  |
| aum_crore      | REAL      | Total Assets Under Management in crore INR.       |
| num_schemes    | INTEGER   | Number of mutual fund schemes managed by the AMC. |

---

# Source References

| Dataset                      | Description                       |
| ---------------------------- | --------------------------------- |
| 01_fund_master.csv           | Mutual fund master information    |
| 02_nav_history.csv           | Historical NAV values             |
| 03_aum_by_fund_house.csv     | Fund house AUM statistics         |
| 04_monthly_sip_inflows.csv   | Monthly SIP inflow data           |
| 05_category_inflows.csv      | Mutual fund category-wise inflows |
| 06_industry_folio_count.csv  | Industry folio count statistics   |
| 07_scheme_performance.csv    | Fund performance metrics          |
| 08_investor_transactions.csv | Investor transaction records      |
| 09_portfolio_holdings.csv    | Portfolio holdings by scheme      |
| 10_benchmark_indices.csv     | Benchmark index closing values    |

---

**Database:** SQLite

**Schema Type:** Star Schema

**Primary Dimensions:** `dim_fund`, `dim_date`

**Fact Tables:** `fact_nav`, `fact_transactions`, `fact_performance`, `fact_aum`
