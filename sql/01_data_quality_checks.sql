-- Banking Dashboard Analysis
-- Data-quality checks for the supplied Banking.csv
-- Replace banking with the actual MySQL table name used in the project.

SELECT COUNT(*) AS source_records, COUNT(DISTINCT `Client ID`) AS distinct_customers, COUNT(*) - COUNT(DISTINCT `Client ID`) AS repeated_client_records FROM banking;

SELECT `Client ID`, COUNT(*) AS record_count FROM banking GROUP BY `Client ID` HAVING COUNT(*) > 1 ORDER BY record_count DESC, `Client ID`;

SELECT SUM(`Client ID` IS NULL OR `Client ID` = '') AS missing_client_id, SUM(`Estimated Income` IS NULL) AS missing_income, SUM(`Bank Loans` IS NULL) AS missing_bank_loans, SUM(`Bank Deposits` IS NULL) AS missing_bank_deposits, SUM(`Checking Accounts` IS NULL) AS missing_checking, SUM(`Saving Accounts` IS NULL) AS missing_savings FROM banking;

SELECT SUM(`Bank Loans` = 0) AS zero_loan_records, SUM(`Bank Deposits` = 0) AS zero_deposit_records, SUM(`Business Lending` = 0) AS zero_business_lending_records FROM banking;