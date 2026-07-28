SELECT
    s.date,
    s.shop_id,
    s.shop_name,
    s.customers,
    s.sales_usd,
    ROUND(s.sales_usd / s.customers, 2) AS avg_sales_per_person
FROM `Florida_Retail_Store.sales` s
LEFT JOIN `Florida_Retail_Store.survey` su
ON s.date = su.date;