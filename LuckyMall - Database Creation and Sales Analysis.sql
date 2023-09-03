
--create a database name LuckyMall
CREATE DATABASE LuckyMall;

--USE LuckyMall;

-- Create a table to store the sales data
CREATE TABLE SalesData (
    ProductID VARCHAR(20) PRIMARY KEY,
    Sales DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(4, 2),
    Profit DECIMAL(10, 2)
);

-- Insert data into the SalesData table
INSERT INTO SalesData (ProductID, Sales, Quantity, Discount, Profit)
VALUES
    ('FUR-BO-10001798', 261.96, 2, 0.00, 41.9136),
    ('FUR-CH-10000454', 731.94, 3, 0.00, 219.582),
    ('OFF-LA-10000240', 14.62, 2, 0.00, 6.8714),
    ('OFF-ST-10000760', 22.368, 2, 0.20, 2.5164),
    ('FUR-FU-10001487', 48.86, 7, 0.00, 14.1694),
    ('OFF-AR-10002833', 7.28, 4, 0.00, 1.9656),
    ('TEC-PH-10002275', 907.152, 6, 0.20, 90.7152),
    ('OFF-BI-10003910', 18.504, 3, 0.20, 5.7825),
    ('OFF-AP-10002892', 114.9, 5, 0.00, 34.47),
    ('FUR-TA-10001539', 1706.184, 9, 0.20, 85.3092),
    ('TEC-PH-10002033', 911.424, 4, 0.20, 68.3568),
    ('OFF-PA-10002365', 15.552, 3, 0.20, 5.4432),
    ('OFF-BI-10003656', 407.976, 3, 0.20, 132.5922),
    ('OFF-AP-10002311', 68.81, 5, 0.80, -123.858),
    ('OFF-BI-10000756', 2.544, 3, 0.80, -3.816),
    ('OFF-ST-10004186', 665.88, 6, 0.00, 13.3176),
    ('OFF-ST-10000107', 55.5, 2, 0.00, 9.99),
    ('OFF-AR-10003056', 8.56, 2, 0.00, 2.4824),
    ('TEC-PH-10001949', 213.48, 3, 0.20, 16.011),
    ('OFF-BI-10002215', 22.72, 4, 0.20, 7.384),
    ('OFF-AR-10000246', 19.46, 7, 0.00, 5.0596),
    ('OFF-AP-10001492', 60.34, 7, 0.00, 15.6884),
    ('FUR-CH-10002774', 71.372, 2, 0.30, -1.0196),
    ('OFF-BI-10001634', 11.648, 2, 0.20, 4.2224);


/**
During the process of Inserting data into our table The error message we encounter, "Violation of PRIMARY KEY constraint," which 
indicates that we are trying to insert a record with a ProductID value that already exists 
in the SalesData table. In this case, the ProductID 'FUR-TA-10000577' is already present in the table.

To resolve this issue, we perform some few options below:
**/

-- Delete the existing record
DELETE FROM SalesData
WHERE ProductID = 'FUR-TA-10000577';

-- Insert the new record
INSERT INTO SalesData (ProductID, Sales, Quantity, Discount, Profit)
VALUES ('FUR-TA-10000577', 153.48, 11, 0.205, 67.011);

--view data table 
SELECT * FROM SalesData;

--LET'S PERFORM SOME CALCULATION ON OUR DATA
SELECT
    ProductID,
    Sales,
    Quantity,
    Sales * Quantity AS Revenue
FROM
    SalesData;

	
--	Profit Analysis:
--Find the total profit for realize from all product category.
SELECT SUM(Profit) AS TotalProfit
FROM SalesData;

--Discount Effectiveness:
--Analyze the impact of discounts on profit.
SELECT Discount, AVG(Profit) AS AvgProfit
FROM SalesData
GROUP BY Discount;


--Product Performance:
--Identify top-performing products.
SELECT ProductID, SUM(Sales) AS TotalSales
FROM SalesData
GROUP BY ProductID
ORDER BY TotalSales DESC;


--Supplier Analysis:
--Analyze profit by supplier.
