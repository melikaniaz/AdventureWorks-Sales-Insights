AdventureWorks Sales & Customer Insights Dashboard

This project includes creating BI Views in MySQL and designing a Power BI Dashboard to analyze AdventureWorks sales and customer insights.

📂 Project Contents

views_bi.sql → contains all BI views for analytics (Calendar, Closed Deals, Pipeline, Sales by Category, Sales by Country, Top Customers).

adventure works sale.pbix → final Power BI file with the designed dashboard.

AdventureWorks2019.sql → original AdventureWorks database.

📸 Screenshots → to showcase SQL results and the dashboard.
  ⚙️ Steps
1️⃣ Creating Views in MySQL

Analytical views were created in MySQL to prepare clean data for Power BI.

Example views:
-- Calendar View
DROP VIEW IF EXISTS bi_vCalendar;
CREATE VIEW bi_vCalendar AS
SELECT 
  `Date`,
  `Year`,
  `Month`,
  `MonthName`,
  `YearMonth`
FROM bi_calendar;

-- Closed Deals
DROP VIEW IF EXISTS bi_vClosedDealsAmount;
CREATE VIEW bi_vClosedDealsAmount AS
SELECT
  SUM(CASE WHEN Status = 5 THEN 1 ELSE 0 END) AS ClosedDeals,
  SUM(CASE WHEN Status = 5 THEN TotalDue ELSE 0 END) AS ClosedDealValue
FROM Sales_SalesOrderHeader;
📸 Example SQL Output


2️⃣ Creating Measures and Columns in Power BI

Custom DAX Measures and Columns were added for deeper analysis:
-- Average Sales per Order
AvgPerOrder =
DIVIDE(
    SUM('adventureworks2019 bi_vtopcustomers'[TotalDue]),
    SUM('adventureworks2019 bi_vtopcustomers'[Orders])
)

-- Customer Tier
Customer Tier =
SWITCH(
    TRUE(),
    'adventureworks2019 bi_vtopcustomers'[AvgPerOrder] >= 200000, "High",
    'adventureworks2019 bi_vtopcustomers'[AvgPerOrder] >= 100000, "Medium",
    "Low"
)
3️⃣ Power BI Dashboard Design

📸 Final Dashboard


The dashboard includes:

KPI Cards → Total Sales, Closed Deals, Avg Deal Value

Bar Chart → Sales by Product Category

Map → Geographical Sales Distribution

Bar Chart → Top Customers by Revenue

Pie Chart → Customer Tiers (High, Medium, Low)

Line Chart → Sales Trend Over Time

Bar Chart → Top 5 Customers by Avg Sales per Order

🚀 Conclusion

This project demonstrates how to combine SQL for data preparation and Power BI for visualization to deliver a professional sales and customer insights dashboard.

⚡ Perfect for showcasing SQL + Power BI integration in analytics projects.

