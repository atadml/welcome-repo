
WITH last_30_days AS (
    SELECT COUNT(DISTINCT order_id) AS total_orders
    FROM order_items
    WHERE delivered_at BETWEEN CURRENT_DATE - INTERVAL '30 days' AND CURRENT_DATE
),
same_period_last_year AS (
    SELECT COUNT(DISTINCT order_id) AS total_orders
    FROM order_items
    WHERE delivered_at BETWEEN CURRENT_DATE - INTERVAL '1 year' - INTERVAL '30 days' 
                           AND CURRENT_DATE - INTERVAL '1 year'
)
SELECT 
    'Last 30 Days' AS period,
    (SELECT total_orders FROM last_30_days) AS total_orders
UNION ALL
SELECT 
    'Same Period Last Year' AS period,
    (SELECT total_orders FROM same_period_last_year) AS total_orders;
