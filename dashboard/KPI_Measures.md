# Power BI KPI Measure Layer

These measures define the reusable KPI logic for the Banking Analytics Dashboard.

> **Implementation note:** The PBIX is a binary Power BI file and its internal model cannot be safely edited through the GitHub text-file interface. The measure layer below is therefore documented as the implementation specification to apply in Power BI Desktop.  
> Assumption: the imported table is named `Banking`. Rename the table reference if the PBIX uses a different table name.

## 1. Customer KPIs

```DAX
Distinct Customers =
DISTINCTCOUNT(Banking[Client ID])

Source Records =
COUNTROWS(Banking)

Avg Estimated Income =
AVERAGE(Banking[Estimated Income])

Avg Credit Cards =
AVERAGE(Banking[Amount of Credit Cards])

Avg Properties Owned =
AVERAGE(Banking[Properties Owned])

Repeated Client Records =
[Source Records] - [Distinct Customers]
```

**Modeling rule:** use **Distinct Customers** for customer-level cards and segment counts. Use **Source Records** only when describing the source-row grain.

## 2. Deposit / Liquidity KPIs

```DAX
Total Bank Deposits =
SUM(Banking[Bank Deposits])

Total Checking Accounts =
SUM(Banking[Checking Accounts])

Total Saving Accounts =
SUM(Banking[Saving Accounts])

Total Foreign Currency =
SUM(Banking[Foreign Currency Account])

Total Relationship Balances =
[Total Bank Deposits]
    + [Total Checking Accounts]
    + [Total Saving Accounts]
    + [Total Foreign Currency]

Avg Bank Deposit per Customer =
DIVIDE(
    [Total Bank Deposits],
    [Distinct Customers]
)
```

## 3. Lending KPIs

```DAX
Total Bank Loans =
SUM(Banking[Bank Loans])

Total Business Lending =
SUM(Banking[Business Lending])

Loan Customers =
CALCULATE(
    [Distinct Customers],
    Banking[Bank Loans] > 0
)

Business Lending Customers =
CALCULATE(
    [Distinct Customers],
    Banking[Business Lending] > 0
)

Loan to Deposit Ratio =
DIVIDE(
    [Total Bank Loans],
    [Total Bank Deposits]
)
```

**Interpretation boundary:** the dataset contains loan/lending balances but no repayment status, delinquency status, NPL flag, interest income, or loan maturity. Do not label these KPIs as default, credit-risk, or profitability measures.

## 4. Portfolio Mix KPIs

```DAX
High Fee Customers =
CALCULATE(
    [Distinct Customers],
    Banking[Fee Structure] = "High"
)

Premium Loyalty Customers =
CALCULATE(
    [Distinct Customers],
    Banking[Loyalty Classification] = "Platinum"
)
```

## 5. Recommended Dashboard Card Set

### Executive Overview
1. Distinct Customers
2. Total Bank Deposits
3. Total Bank Loans
4. Total Business Lending
5. Loan to Deposit Ratio

### Deposit Analysis
1. Total Bank Deposits
2. Avg Bank Deposit per Customer
3. Total Checking Accounts
4. Total Saving Accounts
5. Total Foreign Currency

### Loan Analysis
1. Total Bank Loans
2. Loan Customers
3. Total Business Lending
4. Business Lending Customers
5. Loan to Deposit Ratio

### Customer Relationship
1. Distinct Customers
2. Avg Estimated Income
3. Avg Credit Cards
4. Avg Properties Owned
5. Premium Loyalty Customers

## 6. Recommended Visual Logic

| Dashboard view | Primary dimensions | Measures / visuals |
|---|---|---|
| Executive Overview | Loyalty, Fee Structure, Risk Weighting | Customer count, deposits, loans, business lending, L/D ratio |
| Deposit Analysis | Loyalty, Income Band, Nationality | Deposit totals, average deposit/customer, account balances |
| Loan Analysis | Loyalty, Risk Weighting, Income Band | Loan totals, loan customers, business lending, L/D ratio |
| Customer Relationship | Loyalty, Fee Structure, Income Band, Gender | Customer count, income, cards, properties |

## 7. Reusable Slicers

- Loyalty Classification
- Fee Structure
- Risk Weighting
- Gender
- Nationality
- Income Band
- Properties Owned

Keep slicers consistent across pages so cross-filtering produces comparable views.

## 8. Data-Grain Validation

The source contains 3,000 records and 2,940 distinct Client IDs.

```text
Source Records - Distinct Customers = 60
```

The dashboard should not use raw row count as a proxy for customer count.

## 9. Analytical Boundaries

The following claims should **not** be made from this dataset alone:

- Customer activity / engagement based on transactions — no transaction timestamp exists.
- Credit-card utilization — no credit limit exists.
- Default / delinquency / NPL — no repayment-status fields exist.
- Profitability — no revenue, cost, margin, or fee-income fields exist.
- Causal relationships — correlation analysis is descriptive, not causal.

## 10. Power BI Implementation Checklist

- [ ] Confirm imported table name.
- [ ] Create the measures above in a dedicated measure table or clearly named measure group.
- [ ] Format amount measures consistently.
- [ ] Format Loan to Deposit Ratio as percentage.
- [ ] Use Distinct Customers for customer-level KPIs.
- [ ] Add the recommended slicers.
- [ ] Validate KPI totals against the Python EDA notebook.
- [ ] Add descriptive titles and units to visuals.
- [ ] Avoid unsupported risk/profitability/activity claims.
- [ ] Refresh and save the PBIX after validation.
