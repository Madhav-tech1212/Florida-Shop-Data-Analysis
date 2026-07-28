/*
===========================================================
File: 07_weather_analysis_queries.sql
===========================================================
*/


-- 1. Temperature vs Sales


SELECT
    ROUND(avg_temp_f,0) AS temperature,
    ROUND(AVG(sales_usd),2) AS avg_sales,
    SUM(customers) AS total_customers
FROM `Florida_Retail_Store.final`
GROUP BY temperature
ORDER BY temperature;



-- 2. Temperature Correlation


SELECT
    CORR(avg_temp_f,sales_usd) AS temperature_sales_correlation
FROM `Florida_Retail_Store.final`;



-- 3. Humidity vs Sales


SELECT
    ROUND(humidity_pct,0) AS humidity,
    ROUND(AVG(sales_usd),2) AS avg_sales
FROM `Florida_Retail_Store.final`
GROUP BY humidity
ORDER BY humidity;



-- 4. Humidity Correlation


SELECT
    CORR(humidity_pct,sales_usd) AS humidity_sales_correlation
FROM `Florida_Retail_Store.final`;



-- 5. Rain vs No Rain


SELECT
    CASE
        WHEN is_rain=1 THEN 'Rain'
        ELSE 'No Rain'
    END AS weather,

    ROUND(AVG(sales_usd),2) avg_sales,

    ROUND(SUM(sales_usd),2) total_sales,

    SUM(customers) total_customers

FROM `Florida_Retail_Store.final`

GROUP BY weather;



-- 6. Rain Intensity Analysis


SELECT

CASE

WHEN precip_in=0 THEN 'No Rain'
WHEN precip_in<=0.25 THEN 'Light Rain'
WHEN precip_in<=0.50 THEN 'Moderate Rain'
ELSE 'Heavy Rain'

END rain_type,

ROUND(AVG(sales_usd),2) avg_sales,

SUM(customers) total_customers

FROM `Florida_Retail_Store.final`

GROUP BY rain_type

ORDER BY avg_sales DESC;