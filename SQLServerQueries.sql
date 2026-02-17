/* CREATE DATABASE RetailAnalytics;
GO */

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

*/


/*
INSERT INTO dbo.DimDate (DateKey, DateValue, Year, Quarter, Month, MonthName, YearMonth)
SELECT DISTINCT
    CONVERT(INT,FORMAT([Order_Date],'yyyyMMdd')),
    CAST([Order_Date] AS DATE),
    YEAR([Order_Date]),
    DATEPART(QUARTER,[Order_Date]),
    MONTH([Order_Date]),
    DATENAME(MONTH,[Order_Date]),
    FORMAT([Order_Date],'yyyy-MM')
FROM dbo.Stg_Superstore;
*/


/*
CREATE TABLE dbo.DimCustomer (
    CustomerKey INT IDENTITY PRIMARY KEY,
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(100),
    Segment VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Market VARCHAR(50),
    Region VARCHAR(50)
);
*/

/*
INSERT INTO dbo.DimCustomer (CustomerID, CustomerName, Segment, City, 
State, Country, PostalCode, Market, Region)
SELECT [Customer_ID], [Customer_Name],[Segment],[City],
       [State],[Country],[Postal_Code],[Market],[Region]
       FROM dbo.Stg_Superstore
*/


