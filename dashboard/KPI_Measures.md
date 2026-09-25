# Power BI KPI Measure Layer

These measures make the dashboard's KPI logic explicit and reusable.

> Assumption: the imported table is named `Banking`. Rename the table reference if the PBIX uses a different table name.

## Customer KPIs
```DAX
Distinct Customers = DISTINCTCOUNT(Banking[Client ID])
Source Records = COUNTROWS(Banking)
Avg Estimated Income = AVERAGE(Banking[Estimated Income])
Avg Credit Cards = AVERAGE(Banking[Amount of Credit Cards])
Avg Properties Owned = AVERAGE(Banking[Properties Owned])
```

## Deposit / liquidity KPIs
```DAX
Total Bank Deposits = SUM(Banking[Bank Deposits])
Total Checking Accounts = SUM(Banking[Checking Accounts])
Total Saving Accounts = SUM(Banking[Saving Accounts])
Total Foreign Currency = SUM(Banking[Foreign Currency Account])
Total Relationship Balances = [Total Bank Deposits] + [Total Checking Accounts] + [Total Saving Accounts] + [Total Foreign Currency]
Avg Bank Deposit per Customer = DIVIDE([Total Bank Deposits], [Distinct Customers])
```

## Lending KPIs
```DAX
Total Bank Loans = SUM(Banking[Bank Loans])
Total Business Lending = SUM(Banking[Business Lending])
Loan Customers = CALCULATE([Distinct Customers], Banking[Bank Loans] > 0)
Business Lending Customers = CALCULATE([Distinct Customers], Banking[Business Lending] > 0)
Loan to Deposit Ratio = DIVIDE([Total Bank Loans], [Total Bank Deposits])
```

## Portfolio mix
```DAX
High Fee Customers = CALCULATE([Distinct Customers], Banking[Fee Structure] = "High")
Premium Loyalty Customers = CALCULATE([Distinct Customers], Banking[Loyalty Classification] = "Platinum")
```

## Data-quality KPI
```DAX
Repeated Client Records = [Source Records] - [Distinct Customers]
```

This measure deliberately surfaces the source-grain issue instead of hiding it.