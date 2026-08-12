-- using CTEs to identify suspicious activity, including large transfers, consecutive transactions without balance
-- change and flagged transactions.

With large_transfer as(
	SELECT 
		nameOrig,
		step,
		amount
	FROM
		transactions
	WHERE
		type = 'TRANSFER' and
		amount > 500000
),
no_balance_change as (
	SELECT
		nameOrig,
		step,
		newbalanceOrig,
		oldbalanceOrig
	From
		transactions
	WHERE
		newbalanceOrig = oldbalanceOrig
),
flagged_transactions as (
	SELECT
		nameOrig,
		step,
		isFlaggedFraud = 1
	FROM
		 transactions
)

SELECT 
	lt.nameOrig,
	lt.step
From 
	large_transfer as lt
JOIN
	no_balance_change as nbc
ON
	lt.nameOrig = nbc.nameOrig AND
	lt.step = nbc.step
JOIN
	flagged_transactions as ft
ON
	lt.nameOrig = ft.nameOrig AND
	lt.step = ft.step
















