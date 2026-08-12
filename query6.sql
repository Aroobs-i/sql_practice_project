-- Write a query that checks if the computed new_updated_balance is the same as the actual newbalanceDest in the table.

With cte as (
	SELECT
		amount,
		nameOrig,
		oldbalanceDest,
		newbalanceDest,
		(amount+newbalanceDest) as new_updated_balance
	FROM
		transactions
)
SELECT * 
FROM cte
WHERE
	new_updated_balance = newbalanceDest;
