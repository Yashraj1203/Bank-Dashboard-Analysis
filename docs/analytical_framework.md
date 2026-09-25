# Banking Analytics — Analytical Framework

## 1. Business objective
Convert customer-level banking data into a management-ready view of customer scale, deposits, lending exposure, relationship depth, and portfolio mix.

The dashboard is designed to answer four questions:
1. **Customer base:** Who are the customers and how is the portfolio distributed?
2. **Deposits:** Where is customer liquidity concentrated across deposit-related balances?
3. **Lending:** How large is the loan portfolio and how does lending exposure vary across customer segments?
4. **Relationship value:** How do income, loyalty, fee structure, account balances, cards, and business lending vary together?

## 2. Data grain
The supplied `Banking.csv` contains **3,000 records and 25 columns**.

Important data-quality observation:
- 3,000 source records
- 2,940 distinct `Client ID` values
- 60 additional records are associated with repeated client IDs
- There are no exact duplicate rows in the supplied file

Therefore, customer-count KPIs should use **DISTINCT Client ID**, while row counts should be treated as source-record counts.

## 3. KPI framework
### Customer KPIs
- Distinct Customers
- Source Records
- Average Estimated Income
- Average Credit Cards per Customer
- Average Properties Owned

### Deposit / liquidity KPIs
- Total Bank Deposits
- Total Checking Accounts
- Total Saving Accounts
- Total Foreign Currency Account
- Total Relationship Balances = Bank Deposits + Checking Accounts + Saving Accounts + Foreign Currency Account
- Average Bank Deposits per Customer

### Lending KPIs
- Total Bank Loans
- Total Business Lending
- Customers with Bank Loans > 0
- Customers with Business Lending > 0
- Loan-to-Deposit Ratio = Total Bank Loans / Total Bank Deposits

### Portfolio mix
- Fee Structure mix
- Loyalty Classification mix
- Risk Weighting mix
- Gender mix
- Nationality mix
- Branch mix using `BRId`

## 4. Analytical dimensions
- Loyalty Classification
- Fee Structure
- Risk Weighting
- Gender
- Nationality
- Branch
- Age band
- Income band
- Properties Owned
- Amount of Credit Cards

## 5. Recommended business views
### Executive overview
Focus on customer count, deposits, loans, relationship balances, loan-to-deposit ratio, loyalty mix, and risk-weighting mix.

### Deposit analysis
Compare Bank Deposits, Checking Accounts, Saving Accounts, and Foreign Currency Account balances by loyalty, fee structure, nationality, branch, and income band.

### Loan analysis
Compare Bank Loans and Business Lending by loyalty, fee structure, risk weighting, branch, income band, and customer demographics.

### Customer relationship
Examine how loyalty, income, cards, properties, deposits, and lending exposure vary across the customer base.

## 6. Interpretation rules
- `Client ID` is the customer identifier for customer-level KPIs.
- `BRId`, `GenderId`, and `IAId` are coded dimensions and should be mapped to readable labels where mappings are available.
- No credit-card utilization metric should be claimed because the dataset contains credit-card balance but no credit limit.
- No delinquency/default/NPL metric should be claimed because repayment-status fields are not present.
- No customer profitability metric should be claimed because revenue, cost, or margin fields are not present.
- No customer activity metric should be claimed because the supplied data has no transaction/activity timestamp.