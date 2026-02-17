
SELECT 
    d.DateValue AS OrderDate,
    SUM(f.Sales) AS TotalSales
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.DateValue
ORDER BY d.DateValue;
