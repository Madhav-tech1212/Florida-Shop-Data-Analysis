-- 1. Yearly Sales Summary

SELECT
    year_of_sales,
    ROUND(SUM(sales_usd), 2) AS total_sales
FROM `Florida_Retail_Store.final`
GROUP BY year_of_sales
ORDER BY year_of_sales;


-- 2. Monthly Sales Trend

SELECT
    year_of_sales,
    FORMAT_DATE('%B', date) AS month_name,
    EXTRACT(MONTH FROM date) AS month_number,
    ROUND(SUM(sales_usd), 2) AS total_sales
FROM `Florida_Retail_Store.final`
GROUP BY year_of_sales, month_name, month_number
ORDER BY year_of_sales, month_number;


-- 3. Month-over-Month (MoM) Sales Growth

WITH monthly_sales AS (

SELECT
    year_of_sales,
    EXTRACT(MONTH FROM date) AS month,
    SUM(sales_usd) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY year_of_sales, month

)

SELECT

    year_of_sales,
    month,

    ROUND(total_sales,2) AS total_sales,

    ROUND(
        LAG(total_sales)
        OVER(ORDER BY year_of_sales, month),
        2
    ) AS previous_month_sales,

    ROUND(

        (
            total_sales -
            LAG(total_sales)
            OVER(ORDER BY year_of_sales, month)
        )

        /

        LAG(total_sales)
        OVER(ORDER BY year_of_sales, month)

        *100,

        2

    ) AS mom_growth_percent

FROM monthly_sales

ORDER BY year_of_sales, month;


-- 4. Year-over-Year (YoY) Sales Growth

WITH yearly_sales AS (

SELECT

    year_of_sales,
    SUM(sales_usd) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY year_of_sales

)

SELECT

    year_of_sales,

    ROUND(total_sales,2) AS total_sales,

    ROUND(
        LAG(total_sales)
        OVER(ORDER BY year_of_sales),
        2
    ) AS previous_year_sales,

    ROUND(

        (
            total_sales -
            LAG(total_sales)
            OVER(ORDER BY year_of_sales)
        )

        /

        LAG(total_sales)
        OVER(ORDER BY year_of_sales)

        *100,

        2

    ) AS yoy_growth_percent

FROM yearly_sales;


-- 5. Quarter-wise Performance

SELECT

    year_of_sales,

    CONCAT('Q', EXTRACT(QUARTER FROM date)) AS quarter,

    ROUND(SUM(sales_usd),2) AS total_sales,

    SUM(customers) AS total_customers,

    ROUND(
        AVG(avg_sales_per_person),
        2
    ) AS avg_sales_per_customer

FROM `Florida_Retail_Store.final`

GROUP BY year_of_sales, quarter

ORDER BY year_of_sales, quarter;


-- 6. Day-of-Week Sales Analysis

SELECT

    day_of_sale,

    ROUND(SUM(sales_usd),2) AS total_sales,

    SUM(customers) AS total_customers,

    ROUND(
        AVG(avg_sales_per_person),
        2
    ) AS avg_sales_per_customer

FROM `Florida_Retail_Store.final`

GROUP BY day_of_sale

ORDER BY

CASE day_of_sale

WHEN 'Monday' THEN 1
WHEN 'Tuesday' THEN 2
WHEN 'Wednesday' THEN 3
WHEN 'Thursday' THEN 4
WHEN 'Friday' THEN 5
WHEN 'Saturday' THEN 6
WHEN 'Sunday' THEN 7

END;


-- 7. Best & Worst Selling Days

SELECT

    day_of_sale,

    ROUND(SUM(sales_usd),2) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY day_of_sale

ORDER BY total_sales DESC;


-- 8. Rolling 7-Day Average Sales

SELECT

    date,

    ROUND(
        SUM(sales_usd),
        2
    ) AS daily_sales,

    ROUND(

        AVG(SUM(sales_usd))
        OVER(

            ORDER BY date

            ROWS BETWEEN 6 PRECEDING
            AND CURRENT ROW

        ),

        2

    ) AS rolling_7_day_average

FROM `Florida_Retail_Store.final`

GROUP BY date

ORDER BY date;


-- 9. Rolling 30-Day Average Sales

SELECT

    date,

    ROUND(
        SUM(sales_usd),
        2
    ) AS daily_sales,

    ROUND(

        AVG(SUM(sales_usd))
        OVER(

            ORDER BY date

            ROWS BETWEEN 29 PRECEDING
            AND CURRENT ROW

        ),

        2

    ) AS rolling_30_day_average

FROM `Florida_Retail_Store.final`

GROUP BY date

ORDER BY date;


-- 10. Daily Sales Trend

SELECT

    date,

    ROUND(
        SUM(sales_usd),
        2
    ) AS daily_sales

FROM `Florida_Retail_Store.final`

GROUP BY date

ORDER BY date;


-- 11. Monthly Sales by Store

SELECT

    year_of_sales,

    EXTRACT(MONTH FROM date) AS month,

    shop_name,

    ROUND(
        SUM(sales_usd),
        2
    ) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY
    year_of_sales,
    month,
    shop_name

ORDER BY
    year_of_sales,
    month,
    total_sales DESC;
