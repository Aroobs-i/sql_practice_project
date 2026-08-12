-- Using cte's to calculate the rolling sum of fraudulent transactions for each 
-- account over the last 5 steps.

With rolling_fraud as (
	SELECT 
		nameOrig,
		step,
		SUM(isFraud) OVER (PARTITION BY nameOrig order by STEP ROWS BETWEEN 4 PRECEDING and CURRENT ROW) as fraud_rolling
	FROM
		transactions
)
SELECT * FROM rolling_fraud
WHERE fraud_rolling > 0;