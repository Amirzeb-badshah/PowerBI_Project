
------------------------------------------------------------------------------------------------------------

/*
CREATE TABLE dbo.DimDate (
    DateKey INT PRIMARY KEY,
    DateValue DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName VARCHAR(20),
    YearMonth VARCHAR(7)
);

INSERT INTO dbo.DimDate
(
    DateKey,DateValue,Year,Quarter,Month,MonthName,YearMonth
)
SELECT DISTINCT
    CONVERT(INT, FORMAT([Order_Date], 'yyyyMMdd')),
    CAST([Order_Date] AS DATE),
    YEAR([Order_Date]),
    DATEPART(QUARTER, [Order_Date]),
    MONTH([Order_Date]),
    DATENAME(MONTH, [Order_Date]),
    FORMAT([Order_Date], 'yyyy-MM')
FROM dbo.Stg_Superstore;
*/

/*
CREATE TABLE dbo.DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(100),
    Segment VARCHAR(50)
);

INSERT INTO dbo.DimCustomer
(
    CustomerID,CustomerName,Segment
)
SELECT DISTINCT
    [Customer_ID],
    [Customer_Name],
    Segment
FROM dbo.Stg_Superstore;
*/

/*
CREATE TABLE dbo.DimGeography (
    GeographyKey INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Market VARCHAR(50),
    Region VARCHAR(50)
);

INSERT INTO dbo.DimGeography
(
    City,State,Country,PostalCode,Market,Region
)
SELECT DISTINCT
    City,State,Country,[Postal_Code],Market,Region
FROM dbo.Stg_Superstore;
*/

/*
CREATE TABLE dbo.DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(50),
    ProductName VARCHAR(150),
    Category VARCHAR(50),
    SubCategory VARCHAR(50)
);

INSERT INTO dbo.DimProduct
(
    ProductID,ProductName,Category,SubCategory
)
SELECT DISTINCT
    [Product_ID],[Product_Name],Category,[Sub_Category]
FROM dbo.Stg_Superstore;
*/

/*
CREATE TABLE dbo.DimShipping (
    ShippingKey INT IDENTITY(1,1) PRIMARY KEY,
    ShipMode VARCHAR(50),
    OrderPriority VARCHAR(50)
);

INSERT INTO dbo.DimShipping
(
    ShipMode,OrderPriority
)
SELECT DISTINCT
    [Ship_Mode],[Order_Priority]
FROM dbo.Stg_Superstore;
*/

/*
CREATE TABLE dbo.FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    RowID INT,
    OrderID VARCHAR(50),
    DateKey INT,
    CustomerKey INT,
    ProductKey INT,
    GeographyKey INT,
    ShippingKey INT,
    Sales DECIMAL(18,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(18,2),
    ShippingCost DECIMAL(18,2)
);

INSERT INTO dbo.FactSales
(
    RowID,OrderID,DateKey,CustomerKey,ProductKey,
    GeographyKey,ShippingKey,Sales,Quantity,
    Discount,Profit,ShippingCost
)
SELECT
    s.[Row_ID],
    s.[Order_ID],
    CONVERT(INT, FORMAT(s.[Order_Date], 'yyyyMMdd')),
    c.CustomerKey,p.ProductKey,g.GeographyKey,
    sh.ShippingKey,s.Sales,s.Quantity,
    s.Discount,s.Profit,s.Shipping_Cost
FROM dbo.Stg_Superstore s
JOIN dbo.DimCustomer c
    ON s.Customer_ID = c.CustomerID
JOIN dbo.DimProduct p
    ON s.Product_ID = p.ProductID
JOIN dbo.DimGeography g
    ON s.City = g.City
   AND s.State = g.State
   AND s.Country = g.Country
   AND s.Postal_Code = g.PostalCode
JOIN dbo.DimShipping sh
    ON s.Ship_Mode = sh.ShipMode
   AND s.Order_Priority = sh.OrderPriority;


   DROP TABLE IF EXISTS dbo.DimGeography;
   CREATE TABLE dbo.DimGeography (
    GeographyKey INT IDENTITY(1,1) PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Market VARCHAR(50),
    Region VARCHAR(50)
);

INSERT INTO dbo.DimGeography
(
    City,
    State,
    Country,
    Market,
    Region
)
SELECT DISTINCT
    City,
    State,
    Country,
    Market,
    Region
FROM dbo.Stg_Superstore;

DROP TABLE IF EXISTS dbo.FactSales;
CREATE TABLE dbo.FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    RowID INT,OrderID VARCHAR(50),DateKey INT,
    CustomerKey INT,ProductKey INT,GeographyKey INT,
    ShippingKey INT,Sales DECIMAL(18,2),Quantity INT,
    Discount DECIMAL(5,2),Profit DECIMAL(18,2),ShippingCost DECIMAL(18,2)
);

INSERT INTO dbo.FactSales
(
    RowID,OrderID,DateKey,CustomerKey,
    ProductKey,GeographyKey,ShippingKey,
    Sales,Quantity,Discount,Profit,ShippingCost
)
SELECT
    s.Row_ID,
    s.Order_ID,
    CONVERT(INT, FORMAT(s.Order_Date, 'yyyyMMdd')),
    c.CustomerKey,
    p.ProductKey,
    g.GeographyKey,
    sh.ShippingKey,
    s.Sales,
    s.Quantity,
    s.Discount,
    s.Profit,
    s.Shipping_Cost
FROM dbo.Stg_Superstore s
JOIN dbo.DimCustomer c
    ON s.Customer_ID = c.CustomerID
JOIN dbo.DimProduct p
    ON s.Product_ID = p.ProductID
JOIN dbo.DimGeography g
    ON s.City = g.City
   AND s.State = g.State
   AND s.Country = g.Country
JOIN dbo.DimShipping sh
    ON s.Ship_Mode = sh.ShipMode
   AND s.Order_Priority = sh.OrderPriority;

   SELECT COUNT(*) FROM dbo.Stg_Superstore;
   SELECT COUNT(*) FROM dbo.FactSales;
   SELECT COUNT(DISTINCT RowID) FROM dbo.FactSales;


DROP TABLE IF EXISTS dbo.DimShipping;
CREATE TABLE dbo.DimShipping (
    ShippingKey INT IDENTITY(1,1) PRIMARY KEY,
    ShipMode VARCHAR(50)
);

INSERT INTO dbo.DimShipping
(
    ShipMode
)
SELECT DISTINCT
    dbo.Stg_Superstore.Ship_Mode
FROM dbo.Stg_Superstore;


DROP TABLE IF EXISTS dbo.FactSales;
CREATE TABLE dbo.FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    RowID INT,
    OrderID VARCHAR(50),
    DateKey INT,
    CustomerKey INT,
    ProductKey INT,
    GeographyKey INT,
    ShippingKey INT,
    OrderPriority VARCHAR(50),
    Sales DECIMAL(18,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(18,2),
    ShippingCost DECIMAL(18,2)
);

INSERT INTO dbo.FactSales
(
    RowID,
    OrderID,
    DateKey,
    CustomerKey,
    ProductKey,
    GeographyKey,
    ShippingKey,
    OrderPriority,
    Sales,
    Quantity,
    Discount,
    Profit,
    ShippingCost
)
SELECT
    s.Row_ID,
    s.Order_ID,
    CONVERT(INT, FORMAT(s.Order_Date, 'yyyyMMdd')),
    c.CustomerKey,p.ProductKey,
    g.GeographyKey,sh.ShippingKey,s.Order_Priority,
    s.Sales,s.Quantity,s.Discount,
    s.Profit,
    s.Shipping_Cost
FROM dbo.Stg_Superstore s
JOIN dbo.DimCustomer c
    ON s.Customer_ID = c.CustomerID
JOIN dbo.DimProduct p
    ON s.Product_ID = p.ProductID
JOIN dbo.DimGeography g
    ON s.City = g.City
   AND s.State = g.State
   AND s.Country = g.Country
JOIN dbo.DimShipping sh
    ON s.Ship_Mode = sh.ShipMode;


WITH DuplicatesCTE AS
(
 SELECT
   SalesKey,
   RowID,
   ROW_NUMBER() 
   OVER (
   PARTITION BY RowID ORDER BY SalesKey
   ) AS RowNum
    FROM dbo.FactSales
)
DELETE
FROM DuplicatesCTE
WHERE RowNum > 1;

*/
 
select * from dbo.DimDate






































