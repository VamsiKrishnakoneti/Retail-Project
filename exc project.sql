use exc;
SELECT * FROM exc.cleaned_sales_data;
-- Business Questions
-- 1
select monthname(order_date) as od,sum(quantity*total_amount) as revenue  from cleaned_sales_data WHERE order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH)  group by monthname(order_date) order by revenue desc;
-- 2
SELECT product_name,quantity FROM cleaned_products join cleaned_sales_data on cleaned_products.product_id = cleaned_sales_data.product_id  order by quantity desc limit 5;
-- 3
select count(c.customer_id) as cuscount,cs.region from cleaned_data_customers as c join cleaned_data_customers as cs on c.customer_id = cs.customer_id group by cs.region;
-- 4

select store_name,max(total_amount*quantity - quantity) as Higest from cleaned_stores join cleaned_sales_data on cleaned_stores.store_id = cleaned_sales_data.store_id where order_date between "2024-01-01" and "2025-01-01" group by store_name order by Higest desc limit 1;
-- 5
SELECT category,(COUNT(return_id) * 100.0 / COUNT(*)) AS return_rate_percentage FROM cleaned_sales_data join cleaned_products on cleaned_sales_data.product_id = cleaned_products.product_id join cleaned_return on cleaned_sales_data.order_id =  cleaned_return.order_id
GROUP BY category
ORDER BY return_rate_percentage DESC;
-- 6
select avg(total_amount*quantity - quantity),first_name from cleaned_sales_data join cleaned_data_customers on cleaned_sales_data.customer_id = cleaned_data_customers.customer_id
group by first_name;
-- 7
select sales_channel,avg(total_amount*quantity - quantity) as profit from cleaned_sales_data group by sales_channel order by  profit desc limit 1;
-- 8
SELECT region,DATE_FORMAT(order_date, '%Y-%m') AS month,SUM(total_amount*quantity - quantity) AS total_profit
FROM cleaned_sales_data join cleaned_data_customers on cleaned_sales_data.customer_id =cleaned_data_customers.customer_id
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY region, month
ORDER BY region, month;
-- 9
SELECT p.category, p.product_name, 
       COUNT(r.return_id) * 100.0 / COUNT(*) AS return_rate
FROM cleaned_sales_data s
LEFT JOIN cleaned_return r ON s.order_id = r.order_id
LEFT JOIN cleaned_products p ON s.product_id = p.product_id
GROUP BY p.category, p.product_name
order by return_rate desc limit 3;
-- 10
SELECT c.customer_id, 
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
       SUM(s.total_amount - p.cost_price * s.quantity) AS total_profit,
       DATEDIFF(CURDATE(), c.signup_date) / 365 AS tenure_years
FROM cleaned_sales_data s
JOIN cleaned_data_customers c ON s.customer_id = c.customer_id
JOIN cleaned_products p ON s.product_id = p.product_id
GROUP BY c.customer_id, customer_name, tenure_years 
order by total_profit desc






