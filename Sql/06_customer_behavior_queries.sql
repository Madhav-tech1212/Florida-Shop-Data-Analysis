-- 1. Family vs Single Spending Comparison


SELECT

    ROUND(
        SUM(sales_usd * (pct_family / 100)),
        2
    ) AS estimated_family_sales,

    ROUND(
        SUM(sales_usd * (pct_single / 100)),
        2
    ) AS estimated_single_sales,

    ROUND(
        SUM(sales_usd * (pct_family / 100))
        /
        SUM(customers * (pct_family / 100)),
        2
    ) AS family_sales_per_customer,

    ROUND(
        SUM(sales_usd * (pct_single / 100))
        /
        SUM(customers * (pct_single / 100)),
        2
    ) AS single_sales_per_customer

FROM `Florida_Retail_Store.final`;



-- 2. Male vs Female Spending Comparison


SELECT

    ROUND(
        SUM(sales_usd * (pct_female / 100)),
        2
    ) AS estimated_female_sales,

    ROUND(
        SUM(sales_usd * (pct_male / 100)),
        2
    ) AS estimated_male_sales,

    ROUND(
        SUM(sales_usd * (pct_female / 100))
        /
        SUM(customers * (pct_female / 100)),
        2
    ) AS female_sales_per_customer,

    ROUND(
        SUM(sales_usd * (pct_male / 100))
        /
        SUM(customers * (pct_male / 100)),
        2
    ) AS male_sales_per_customer

FROM `Florida_Retail_Store.final`;



-- 3. Demographic Mix by Store


SELECT

    shop_name,

    ROUND(AVG(pct_family),2) AS avg_family_percentage,

    ROUND(AVG(pct_single),2) AS avg_single_percentage,

    ROUND(AVG(pct_female),2) AS avg_female_percentage,

    ROUND(AVG(pct_male),2) AS avg_male_percentage,

    ROUND(SUM(sales_usd),2) AS total_sales,

    ROUND(
        SUM(sales_usd) / SUM(customers),
        2
    ) AS sales_per_customer

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY total_sales DESC;



-- 4. Customer Count Trend Over Time


SELECT

    date,

    SUM(customers) AS total_customers,

    ROUND(
        SUM(sales_usd),
        2
    ) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY date

ORDER BY date;



-- 5. Monthly Customer Trend


SELECT

    year_of_sales,

    EXTRACT(MONTH FROM date) AS month,

    SUM(customers) AS total_customers,

    ROUND(
        SUM(sales_usd),
        2
    ) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY
    year_of_sales,
    month

ORDER BY
    year_of_sales,
    month;



-- 6. Monthly Customer Growth Rate


WITH monthly_customers AS (

SELECT

    year_of_sales,

    EXTRACT(MONTH FROM date) AS month,

    SUM(customers) AS total_customers

FROM `Florida_Retail_Store.final`

GROUP BY
    year_of_sales,
    month

)

SELECT

    year_of_sales,

    month,

    total_customers,

    LAG(total_customers)
    OVER(
        ORDER BY year_of_sales, month
    ) AS previous_month_customers,

    ROUND(

        (
            total_customers -
            LAG(total_customers)
            OVER(
                ORDER BY year_of_sales, month
            )
        )

        /

        LAG(total_customers)
        OVER(
            ORDER BY year_of_sales, month
        )

        *100,

        2

    ) AS customer_growth_percent

FROM monthly_customers

ORDER BY
    year_of_sales,
    month;



-- 7. Customer Demographics by Store


SELECT

    shop_name,

    ROUND(AVG(pct_family),2) AS family_pct,

    ROUND(AVG(pct_single),2) AS single_pct,

    ROUND(AVG(pct_female),2) AS female_pct,

    ROUND(AVG(pct_male),2) AS male_pct,

    SUM(customers) AS total_customers,

    ROUND(SUM(sales_usd),2) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY total_sales DESC;



-- 8. Average Sales Per Customer by Store


SELECT

    shop_name,

    ROUND(
        SUM(sales_usd) /
        SUM(customers),
        2
    ) AS average_sales_per_customer,

    SUM(customers) AS total_customers,

    ROUND(SUM(sales_usd),2) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY average_sales_per_customer DESC;