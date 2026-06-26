-- =====================================================
-- Query 1 : Top 5 Funds by AUM
-- =====================================================

SELECT
    df.scheme_name,
    fp.aum_crore
FROM fact_performance fp
JOIN dim_fund df
ON fp.fund_id = df.fund_id
ORDER BY fp.aum_crore DESC
LIMIT 5;


-- =====================================================
-- Query 2 : Average NAV per Month
-- =====================================================

SELECT
    dd.year,
    dd.month,
    ROUND(AVG(fn.nav),2) AS average_nav
FROM fact_nav fn
JOIN dim_date dd
ON fn.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;


-- =====================================================
-- Query 3 : Total Transactions by State
-- =====================================================

SELECT
    state,
    COUNT(*) AS total_transactions
FROM fact_transactions
GROUP BY state
ORDER BY total_transactions DESC;


-- =====================================================
-- Query 4 : Total Transaction Amount by State
-- =====================================================

SELECT
    state,
    ROUND(SUM(amount_inr),2) AS total_amount
FROM fact_transactions
GROUP BY state
ORDER BY total_amount DESC;


-- =====================================================
-- Query 5 : Funds with Expense Ratio less than 1%
-- =====================================================

SELECT
    df.scheme_name,
    fp.expense_ratio_pct
FROM fact_performance fp
JOIN dim_fund df
ON fp.fund_id = df.fund_id
WHERE fp.expense_ratio_pct < 1
ORDER BY fp.expense_ratio_pct;


-- =====================================================
-- Query 6 : Top 10 Funds by Sharpe Ratio
-- =====================================================

    SELECT
        df.scheme_name,
        fp.sharpe_ratio
    FROM fact_performance fp
    JOIN dim_fund df
    ON fp.fund_id = df.fund_id
    ORDER BY fp.sharpe_ratio DESC
    LIMIT 10;


-- =====================================================
-- Query 7 : Average 3-Year Return by Category
-- =====================================================

SELECT
    df.category,
    ROUND(AVG(fp.return_3yr_pct),2) AS avg_return_3yr
FROM fact_performance fp
JOIN dim_fund df
ON fp.fund_id = df.fund_id
GROUP BY df.category
ORDER BY avg_return_3yr DESC;


-- =====================================================
-- Query 8 : Transactions by Payment Mode
-- =====================================================

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr),2) AS total_amount
FROM fact_transactions
GROUP BY payment_mode
ORDER BY total_amount DESC;


-- =====================================================
-- Query 9 : Number of Funds in each Risk Category
-- =====================================================

SELECT
    risk_category,
    COUNT(*) AS total_funds
FROM dim_fund
GROUP BY risk_category
ORDER BY total_funds DESC;


-- =====================================================
-- Query 10 : Average NAV by Fund House
-- =====================================================

SELECT
    df.fund_house,
    ROUND(AVG(fn.nav),2) AS average_nav
FROM fact_nav fn
JOIN dim_fund df
ON fn.fund_id = df.fund_id
GROUP BY df.fund_house
ORDER BY average_nav DESC;