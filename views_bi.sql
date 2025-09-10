-- AdventureWorks2019 BI Views
-- File: views_bi.sql
-- Purpose: Create all BI views for Power BI Dashboard

-- 1. Calendar View
DROP VIEW IF EXISTS bi_vCalendar;
CREATE VIEW bi_vCalendar AS
SELECT 
  `Date`,
  `Year`,
  `Month`,
  `MonthName`,
  `YearMonth`
FROM bi_calendar;

-- 2. Closed Deals and Values
DROP VIEW IF EXISTS bi_vClosedDealsAmount;
CREATE VIEW bi_vClosedDealsAmount AS
SELECT
  SUM(CASE WHEN Status = 5 THEN 1 ELSE 0 END) AS ClosedDeals,
  SUM(CASE WHEN Status = 5 THEN TotalDue ELSE 0 END) AS ClosedDealValue
FROM Sales_SalesOrderHeader;

-- 3. Pipeline Status
DROP VIEW IF EXISTS bi_vPipelineStatus;
CREATE VIEW bi_vPipelineStatus AS
SELECT 
  CASE Status
    WHEN 1 THEN 'In Process'
    WHEN 2 THEN 'Approved'
    WHEN 3 THEN 'Backordered'
    WHEN 4 THEN 'Rejected'
    WHEN 5 THEN 'Shipped/Closed'
    ELSE 'Unknown'
  END AS PipelineStage,
  COUNT(*) AS Orders,
  SUM(TotalDue) AS Amount
FROM Sales_SalesOrderHeader
GROUP BY Status;

-- 4. Sales by Product Category
DROP VIEW IF EXISTS bi_vSalesByProductCategory;
CREATE VIEW bi_vSalesByProductCategory AS
SELECT 
  p.Name AS ProductCategory,
  COUNT(*) AS Orders,
  SUM(LineTotal) AS SalesAmount
FROM Sales_SalesOrderDetail d
JOIN Production_Product p ON d.ProductID = p.ProductID
GROUP BY p.Name;

-- 5. Sales by Country
DROP VIEW IF EXISTS bi_vSalesByCountry;
CREATE VIEW bi_vSalesByCountry AS
SELECT 
  a.CountryRegionCode AS Country,
  COUNT(*) AS Orders,
  SUM(h.TotalDue) AS SalesAmount
FROM Sales_SalesOrderHeader h
JOIN Person_Address a ON h.BillToAddressID = a.AddressID
GROUP BY a.CountryRegionCode;

-- 6. Top Customers
DROP VIEW IF EXISTS bi_vTopCustomers;
CREATE VIEW bi_vTopCustomers AS
SELECT 
  c.CustomerID,
  p.FirstName + ' ' + p.LastName AS CustomerName,
  COUNT(*) AS Orders,
  SUM(h.TotalDue) AS TotalDue
FROM Sales_SalesOrderHeader h
JOIN Sales_Customer c ON h.CustomerID = c.CustomerID
JOIN Person_Person p ON c.PersonID = p.BusinessEntityID
GROUP BY c.CustomerID, p.FirstName, p.LastName;
