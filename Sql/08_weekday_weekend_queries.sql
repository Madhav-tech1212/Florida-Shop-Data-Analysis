-- 1. Weekday vs Weekend Performance


SELECT

week_type,

ROUND(SUM(sales_usd),2) total_sales,

SUM(customers) total_customers,

ROUND(AVG(avg_sales_per_person),2) avg_sales_per_customer

FROM `Florida_Retail_Store.final`

GROUP BY week_type;



-- 2. Best Performing Day For Each Store


WITH sales_by_day AS (

SELECT

shop_name,

day_of_sale,

SUM(sales_usd) total_sales

FROM `Florida_Retail_Store.final`

GROUP BY shop_name,day_of_sale

)

SELECT *

FROM(

SELECT

*,

RANK() OVER(

PARTITION BY shop_name

ORDER BY total_sales DESC

) rank_no

FROM sales_by_day

)

WHERE rank_no=1;



-- 3. Day-wise Store Performance


SELECT

shop_name,

day_of_sale,

ROUND(SUM(sales_usd),2) total_sales,

SUM(customers) total_customers

FROM `Florida_Retail_Store.final`

GROUP BY

shop_name,

day_of_sale

ORDER BY

shop_name,

total_sales DESC;