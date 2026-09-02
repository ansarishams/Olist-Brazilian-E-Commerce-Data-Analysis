# DAX Reference

These are the main calculation patterns used in the project.

## Revenue MoM Growth %

```DAX
Revenue MoM Growth % =
DIVIDE(
    [Total Revenue] - [Revenue PM (Previous Month)],
    [Revenue PM (Previous Month)],
    0
)
```

Format as Percentage.

## Late Delivery %

The project uses:

```text
is_late_delivery = 1 → Late
is_late_delivery = 0 → On-Time
```

```DAX
Late Delivery % =
DIVIDE(
    CALCULATE(
        DISTINCTCOUNT(MasterTable[order_id]),
        MasterTable[is_late_delivery] = 1
    ),
    DISTINCTCOUNT(MasterTable[order_id]),
    0
)
```

## On-Time Delivery %

```DAX
On-Time Delivery % =
1 - [Late Delivery %]
```

## Average Delivery Delay

```DAX
Avg Delivery Delay Days =
CALCULATE(
    AVERAGE(MasterTable[delivery_delay_days]),
    MasterTable[is_late_delivery] = 1
)
```

## DAX Principles

- Use `DISTINCTCOUNT` where item-level rows can duplicate an order or customer.
- Use `CALCULATE` when a KPI needs a specific filter context.
- Use `DIVIDE` for safe ratio calculations.
- Use a dedicated `DimDate` table for time analysis.
- Use measures for dynamic KPIs.
- Use calculated columns for row-level classifications when needed.

## Date Table

The project uses fields such as:

- Date
- Year
- Month Number
- Month
- MonthYear

`MonthYear` must be sorted using a chronological field such as `YearMonthNumber`, not alphabetically.
