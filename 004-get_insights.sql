
--  Retrieving and Interpreting Insights

SELECT
  contributors, -- ARRAY of dimension values for the segment
  metric_test, -- Metric value in the test period for this segment
  metric_control, -- Metric value in the control period for this segment
  difference, -- metric_test - metric_control
  relative_difference, -- (metric_test - metric_control) / metric_control
  unexpected_difference, -- Actual difference - Expected difference
  relative_unexpected_difference, -- unexpected_difference / Expected difference
  apriori_support -- The support of this segment
FROM
  ML.GET_INSIGHTS(MODEL bq_demo.ecommerce_sales_contribution_model)
ORDER BY
  unexpected_difference DESC; -- Or 'difference DESC' for raw impact