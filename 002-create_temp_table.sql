
-- Create table

CREATE OR REPLACE TABLE `your_project.your_dataset.sales_data_for_ca_model` AS
WITH
  sales_with_dimensions AS (
    SELECT
      oi.sale_price,
      o.created_at,
      p.category AS product_category,
      u.country AS user_country
    FROM
      `bigquery-public-data.thelook_ecommerce.order_items` AS oi
    JOIN
      `bigquery-public-data.thelook_ecommerce.orders` AS o
ON
      oi.order_id = o.order_id
    JOIN
      `bigquery-public-data.thelook_ecommerce.products` AS p
ON
      oi.product_id = p.id
    JOIN
      `bigquery-public-data.thelook_ecommerce.users` AS u
ON
      o.user_id = u.id
    WHERE
      o.status NOT IN ('Cancelled', 'Returned') -- Focusing on completed sales
      AND DATE(o.created_at) BETWEEN '2023-01-01' AND '2023-02-28' -- Covering both baseline and analysis periods
  )
SELECT
  *,
  -- Define is_test column: TRUE for analysis period (Feb 2023), FALSE for baseline (Jan 2023)
  IF(DATE(created_at) BETWEEN '2023-02-01' AND '2023-02-28', TRUE, FALSE) AS is_test
FROM
  sales_with_dimensions;


-- Check data count
SELECT COUNT(1) FROM `bq_demo.sales_data_for_ca_model`; --3347
