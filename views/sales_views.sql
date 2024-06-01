-- This view provides a daily summary of sales, including total sales, transaction count, and average transaction amount.
CREATE VIEW SalesSummaryByDay AS
SELECT 
    CAST(OrderDate AS DATE) AS SaleDate,
    COUNT(OrderID) AS TransactionCount,
    SUM(TotalAmount) AS TotalSales,
    AVG(TotalAmount) AS AvgTransactionAmount
FROM 
    Sales
GROUP BY 
    CAST(OrderDate AS DATE);

-- This view lists the top selling items based on the quantity sold.
CREATE VIEW TopSellingItems AS
SELECT 
    ItemID,
    ItemName,
    SUM(Quantity) AS TotalQuantitySold
FROM 
    SalesDetails
GROUP BY 
    ItemID,
    ItemName
ORDER BY 
    TotalQuantitySold DESC;

-- This view provides a breakdown of sales data by hour of the day.
CREATE VIEW SalesByHour AS
SELECT 
    DATEPART(HOUR, OrderDate) AS SaleHour,
    COUNT(OrderID) AS TransactionCount,
    SUM(TotalAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    DATEPART(HOUR, OrderDate)
ORDER BY 
    SaleHour;

-- This view counts the number of unique customers per day to provide insights into customer visits.
CREATE VIEW CustomerVisits AS
SELECT 
    CAST(OrderDate AS DATE) AS VisitDate,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM 
    Sales
GROUP BY 
    CAST(OrderDate AS DATE);

-- This view shows the trend of sales over time by aggregating sales data by year and month.
CREATE VIEW SalesTrends AS
SELECT 
    YEAR(OrderDate) AS SalesYear,
    MONTH(OrderDate) AS SalesMonth,
    SUM(TotalAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY 
    SalesYear,
    SalesMonth;

-- This view calculates the average transaction value for each day.
CREATE VIEW AverageTransactionValue AS
SELECT 
    CAST(OrderDate AS DATE) AS SaleDate,
    AVG(TotalAmount) AS AvgTransactionValue
FROM 
    Sales
GROUP BY 
    CAST(OrderDate AS DATE);

-- This view evaluates the sales performance of employees by calculating their total sales.
CREATE VIEW EmployeeSalesPerformance AS
SELECT 
    EmployeeID,
    SUM(TotalAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    EmployeeID
ORDER BY 
    TotalSales DESC;

-- This view analyzes sales distribution by item category, providing insights into category-wise sales.
CREATE VIEW SalesDistributionByCategory AS
SELECT 
    CategoryName,
    SUM(Quantity) AS TotalQuantitySold
FROM 
    SalesDetails sd
JOIN 
    Items i ON sd.ItemID = i.ItemID
JOIN 
    Categories c ON i.CategoryID = c.CategoryID
GROUP BY 
    CategoryName
ORDER BY 
    TotalQuantitySold DESC;

