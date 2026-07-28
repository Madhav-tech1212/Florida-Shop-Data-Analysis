-- Total Sales by Year

SELECT
    year_of_sales,
    ROUND(SUM(sales_usd),2) AS total_sales
FROM `Florida_Retail_Store.final`
GROUP BY year_of_sales
ORDER BY year_of_sales;