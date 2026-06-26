CREATE TABLE dim_fund (
    fund_id INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code INTEGER UNIQUE NOT NULL,
    fund_house TEXT,
    scheme_name TEXT,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date DATE,
    benchmark TEXT,
    fund_manager TEXT,
    risk_category TEXT,
    sebi_category_code TEXT
);

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_date DATE UNIQUE,
    day INTEGER,
    month INTEGER,
    month_name TEXT,
    quarter INTEGER,
    year INTEGER
);

CREATE TABLE fact_nav (
    nav_id INTEGER PRIMARY KEY AUTOINCREMENT,

    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,

    nav REAL NOT NULL,

    FOREIGN KEY (fund_id)
        REFERENCES dim_fund(fund_id),

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

CREATE TABLE fact_transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,

    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,

    transaction_type TEXT,
    amount_inr REAL,

    investor_id TEXT,

    state TEXT,
    city TEXT,
    city_tier TEXT,

    age_group TEXT,
    gender TEXT,

    annual_income_lakh REAL,

    payment_mode TEXT,

    kyc_status TEXT,

    FOREIGN KEY (fund_id)
        REFERENCES dim_fund(fund_id),

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);

CREATE TABLE fact_performance (
    performance_id INTEGER PRIMARY KEY AUTOINCREMENT,

    fund_id INTEGER NOT NULL,

    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,

    benchmark_3yr_pct REAL,

    alpha REAL,
    beta REAL,

    sharpe_ratio REAL,
    sortino_ratio REAL,

    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,

    expense_ratio_pct REAL,

    aum_crore REAL,

    morningstar_rating INTEGER,

    risk_grade TEXT,

    FOREIGN KEY (fund_id)
        REFERENCES dim_fund(fund_id)
);

CREATE TABLE fact_aum (
    aum_id INTEGER PRIMARY KEY AUTOINCREMENT,

    date_id INTEGER NOT NULL,

    fund_house TEXT,

    aum_lakh_crore REAL,

    aum_crore REAL,

    num_schemes INTEGER,

    FOREIGN KEY (date_id)
        REFERENCES dim_date(date_id)
);