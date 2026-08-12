-- identifying most occuring account paths

WITH RECURSIVE fraud_chain AS (

    SELECT
        nameOrig AS initial_account,
        nameDest AS next_account,
        step,
        amount,
        newbalanceOrig,
        ARRAY[nameOrig::varchar, nameDest::varchar] AS account_path

    FROM transactions

    WHERE isFraud = 1
      AND type = 'TRANSFER'

    UNION ALL

    SELECT
        fc.initial_account,
        t.nameDest,
        t.step,
        t.amount,
        t.newbalanceOrig,
        fc.account_path || t.nameDest::varchar

    FROM fraud_chain AS fc

    JOIN transactions AS t
        ON fc.next_account = t.nameOrig
       AND fc.step < t.step
       AND NOT t.nameDest = ANY(fc.account_path)

    WHERE t.isFraud = 1
      AND t.type = 'TRANSFER'
)

SELECT *
FROM fraud_chain
Limit 10;
