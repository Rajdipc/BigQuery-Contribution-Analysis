
-- Create the CONTRIBUTION ANALYSIS model

CREATE OR REPLACE MODEL your_project.your_dataset.ecommerce_sales_contribution_model
OPTIONS(
  MODEL_TYPE = 'CONTRIBUTION_ANALYSIS',
  CONTRIBUTION_METRIC = 'SUM(sale_price)',
  DIMENSION_ID_COLS = ['product_category', 'user_country'],
  IS_TEST_COL = 'is_test',
  MIN_APRIORI_SUPPORT = 0.005 -- Prune segments representing less than 0.5% of total sales in either period
) AS
SELECT
  sale_price,
  product_category,
  user_country,
  is_test
FROM
  your_project.your_dataset.sales_data_for_ca_model;
