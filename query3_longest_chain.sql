-- identifying maximum chain length 

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
-- SELECT
--     account_path,
--     cardinality(account_path) AS chain_length
-- FROM fraud_chain
-- ORDER BY chain_length DESC
-- LIMIT 20;

SELECT
    MAX(cardinality(account_path)) AS longest_chain,
    COUNT(*) AS total_chain_rows
FROM fraud_chain;

