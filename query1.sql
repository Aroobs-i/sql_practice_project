-- Using a recursive CTE to identify potential money laundering chains where money is transferred from one 
-- accont to another using multiple steps with all transactions flagged as fraudulent.

WITH RECURSIVE fraud_chain as (
	SELECT 
		nameOrig as initial_account,
		nameDest as next_account,
		step,
		amount,
		newbalanceOrig
	From   
		transactions
	WHERE
		isFraud = 1 AND
		type = 'TRANSFER'

UNION ALL		

	SELECT
		fc.initial_account,
		t.nameDest,
		t.step,
		t.amount,
		t.newbalanceOrig
	FROM
		fraud_chain as fc
	JOIN
		transactions as t
	ON fc.next_account = t.nameOrig
	AND
		fc.step < t.step
	WHERE 
		t.isFraud = 1 
		AND
		t.type = 'TRANSFER'	   
)

SELECT * FROM fraud_chain;
