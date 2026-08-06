
SELECT
    s.date,
    FORMAT_DATE('%A', s.date) AS day_of_sale,
    EXTRACT(ISOWEEK FROM s.date) AS week_type,
    EXTRACT(YEAR FROM s.date) AS year_of_sales,

    CASE
        WHEN EXTRACT(DAYOFWEEK FROM s.date) IN (1,7)
        THEN 'Weekends'
        ELSE 'Weekdays'
    END AS week_type,

    s.shop_id,
    s.shop_name,
    s.customers,
    s.sales_usd,

    ROUND(s.sales_usd / s.customers,2) AS avg_sales_per_person,

    su.pct_family,
    su.pct_single,
    su.pct_female,
    su.pct_male,

    w.avg_temp_f,
    w.humidity_pct,
    w.is_rain,
    w.precip_in

FROM `Florida_Retail_Store.sales` s

LEFT JOIN `Florida_Retail_Store.survey` su
ON s.date = su.date

LEFT JOIN `Florida_Retail_Store.weather` w
ON s.date = w.date

ORDER BY s.date;