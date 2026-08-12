-- Find transactions where destination account had zero balance before or after the transaction.

SELECT
	nameOrig,
	amount,
	oldbalanceDest,
	newbalanceDest
FROM
	transactions
WHERE
	oldbalanceDest = 0.0 OR
	newbalanceDest = 0.0;