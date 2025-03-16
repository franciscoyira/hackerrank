--The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

WITH orders_with_rank AS (
  SELECT
  customer_id, order_date, customer_pref_delivery_date
  ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS row_num
FROM Delivery
)
SELECT
  ROUND(100 * AVG(order_date = customer_pref_delivery_date), 2) AS immediate_percentage
FROM orders_with_rank
WHERE row_num = 1;