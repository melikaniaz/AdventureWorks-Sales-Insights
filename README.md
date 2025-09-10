# 📊 AdventureWorks Sales & Customer Insights

This repository contains a complete **Business Intelligence pipeline** built on the **AdventureWorks** sample database.  
We designed SQL BI views, connected them to **Power BI**, and developed an interactive dashboard with KPIs, trends, geographical insights, product analysis, and customer segmentation.

---

## 🚀 Project Workflow

1. **Dataset Preparation**
   - Imported the **AdventureWorks2019** sample database into MySQL.
   - Created a dedicated BI schema with clean views for analysis.

2. **SQL BI Views**
   - Built views for Calendar, Closed Deals, Pipeline Status, Sales by Country, Sales by Product Category, and Top Customers.
   - Example:  
     ```sql
     CREATE OR REPLACE VIEW bi_vSalesByProductCategory AS
     SELECT pc.Name AS ProductCategory,
            COUNT(soh.SalesOrderID) AS Orders,
            SUM(soh.TotalDue) AS SalesAmount
     FROM Sales_SalesOrderHeader soh
     JOIN Sales_SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
     JOIN Production_Product p ON sod.ProductID = p.ProductID
     JOIN Production_ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
     JOIN Production_ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
     GROUP BY pc.Name;
     ```

3. **Power BI Dashboard**
   - Connected Power BI to MySQL (using dedicated `powerbi` user).
   - Loaded only BI views (`bi_v...`) for a clean semantic model.
   - Created visuals:
     - **KPIs:** Total Sales, Closed Deals, Average Deal Value  
     - **Map:** Sales distribution by Country  
     - **Bar Chart:** Sales by Product Category  
     - **Line Chart:** Monthly Sales Trend  
     - **Bar Chart (Top N):** Top Customers by Revenue  
     - **Measure:** `Average Sales per Order` in DAX  
     - **Customer Segmentation:** High / Medium / Low tiers using calculated column  
     - **Pie Chart:** Customer Tiers distribution  

4. **Customer Analytics (DAX)**
   ```DAX
   Average Sales per Order =
   DIVIDE(
       SUM('adventureworks2019 bi_vtopcustomers'[TotalDue]),
   
       SUM('adventureworks2019 bi_vtopcustomers'[Orders])
   )
