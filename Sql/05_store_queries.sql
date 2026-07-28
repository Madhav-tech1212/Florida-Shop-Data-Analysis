

-- 12. Store Ranking by Total Sales


SELECT
    shop_name,
    ROUND(SUM(sales_usd),2) AS total_sales,
    SUM(customers) AS total_customers,
    ROUND(AVG(avg_sales_per_person),2) AS avg_sales_per_customer,

    RANK() OVER(
        ORDER BY SUM(sales_usd) DESC
    ) AS sales_rank

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY sales_rank;



-- 13. Store Contribution to Overall Revenue


SELECT

    shop_name,

    ROUND(SUM(sales_usd),2) AS total_sales,

    ROUND(
        SUM(sales_usd)
        /
        SUM(SUM(sales_usd)) OVER()
        *100,
        2
    ) AS revenue_contribution_percent

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY revenue_contribution_percent DESC;



-- 14. Monthly Store Growth Rate


WITH monthly_sales AS (

SELECT

    shop_name,

    year_of_sales,

    EXTRACT(MONTH FROM date) AS month,

    SUM(sales_usd) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY
    shop_name,
    year_of_sales,
    month

)

SELECT

    shop_name,

    year_of_sales,

    month,

    ROUND(total_sales,2) AS total_sales,

    ROUND(

        LAG(total_sales)
        OVER(
            PARTITION BY shop_name
            ORDER BY year_of_sales, month
        ),

        2

    ) AS previous_month_sales,

    ROUND(

        (
            total_sales -
            LAG(total_sales)
            OVER(
                PARTITION BY shop_name
                ORDER BY year_of_sales, month
            )
        )

        /

        LAG(total_sales)
        OVER(
            PARTITION BY shop_name
            ORDER BY year_of_sales, month
        )

        *100,

        2

    ) AS monthly_growth_percent

FROM monthly_sales

ORDER BY
    shop_name,
    year_of_sales,
    month;



-- 15. Overall Store Growth (Year-over-Year)


WITH yearly_sales AS (

SELECT

    shop_name,

    year_of_sales,

    SUM(sales_usd) AS total_sales

FROM `Florida_Retail_Store.final`

GROUP BY
    shop_name,
    year_of_sales

)

SELECT

    shop_name,

    year_of_sales,

    ROUND(total_sales,2) AS total_sales,

    ROUND(

        LAG(total_sales)
        OVER(
            PARTITION BY shop_name
            ORDER BY year_of_sales
        ),

        2

    ) AS previous_year_sales,

    ROUND(

        (
            total_sales -
            LAG(total_sales)
            OVER(
                PARTITION BY shop_name
                ORDER BY year_of_sales
            )
        )

        /

        LAG(total_sales)
        OVER(
            PARTITION BY shop_name
            ORDER BY year_of_sales
        )

        *100,

        2

    ) AS yearly_growth_percent

FROM yearly_sales

ORDER BY
    shop_name,
    year_of_sales;



-- 16. Customer Count vs Revenue


SELECT

    shop_name,

    SUM(customers) AS total_customers,

    ROUND(SUM(sales_usd),2) AS total_sales,

    ROUND(
        SUM(sales_usd) / SUM(customers),
        2
    ) AS sales_per_customer

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY total_sales DESC;



-- 17. Revenue vs Customer Ranking


SELECT

    shop_name,

    SUM(customers) AS total_customers,

    ROUND(SUM(sales_usd),2) AS total_sales,

    RANK() OVER(
        ORDER BY SUM(customers) DESC
    ) AS customer_rank,

    RANK() OVER(
        ORDER BY SUM(sales_usd) DESC
    ) AS revenue_rank

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY revenue_rank;



-- 18. Store Performance Summary


SELECT

    shop_name,

    ROUND(SUM(sales_usd),2) AS total_sales,

    SUM(customers) AS total_customers,

    ROUND(AVG(avg_sales_per_person),2) AS avg_sales_per_customer,

    ROUND(
        SUM(sales_usd) /
        SUM(SUM(sales_usd)) OVER()
        *100,
        2
    ) AS revenue_share_percent,

    RANK() OVER(
        ORDER BY SUM(sales_usd) DESC
    ) AS sales_rank

FROM `Florida_Retail_Store.final`

GROUP BY shop_name

ORDER BY sales_rank;