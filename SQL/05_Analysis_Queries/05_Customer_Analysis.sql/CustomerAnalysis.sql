
-- Create Analysis Queries --
/* =========================================================
   05_Customer_Analysis.sql
   Customer Performance Analysis
   ========================================================= */

   --- Customer Shipment Volume ---
   SELECT
    C.CustomerID,
    C.CustomerName,
    COUNT(F.ShipmentID) AS TotalShipments
FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY TotalShipments DESC;

--- Customer Revenue ---
SELECT
    C.CustomerID,
    C.CustomerName,
    COUNT(F.ShipmentID) AS TotalShipments,
    SUM(F.Revenue) AS TotalRevenue
FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY TotalRevenue DESC;

--- Customer Cost & Profit ---
SELECT
    C.CustomerID,
    C.CustomerName,
    SUM(F.Revenue) AS TotalRevenue,
    SUM(F.TransportationCost) AS TransportationCost,
    SUM(F.Revenue - F.TransportationCost) AS Profit,

    CAST(
        SUM(F.Revenue - F.TransportationCost) * 100.0
        / NULLIF(SUM(F.Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent

FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY Profit DESC;

--- Customer SLA Performance ---
SELECT
    C.CustomerID,
    C.CustomerName,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(CASE
        WHEN F.SLAStatus = 'Met' THEN 1
        ELSE 0
    END) AS SLAMet,

    SUM(CASE
        WHEN F.SLAStatus = 'Breached' THEN 1
        ELSE 0
    END) AS SLABreached,

    CAST(
        SUM(CASE
            WHEN F.SLAStatus = 'Met' THEN 1
            ELSE 0
        END) * 100.0
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY SLAPercentage ASC;

--- Customer Delay Analysis ---
SELECT
    C.CustomerID,
    C.CustomerName,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2))
        AS AverageDelayHours,

    MAX(F.DelayHours) AS MaximumDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY AverageDelayHours desc;

--- Customer Shipment Weight ---
SELECT
    C.CustomerID,
    C.CustomerName,

    SUM(F.WeightKg) AS TotalWeightKg,

    CAST(
        AVG(F.WeightKg)
        AS DECIMAL(12,2)
    ) AS AverageShipmentWeightKg

FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY TotalWeightKg DESC;

--- Top 10 Customers by Revenue ---
SELECT TOP 10
    C.CustomerID,
    C.CustomerName,
    COUNT(F.ShipmentID) AS TotalShipments,
    SUM(F.Revenue) AS TotalRevenue,
    SUM(F.Revenue - F.TransportationCost) AS Profit
FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY TotalRevenue DESC;

--- Customer Management Summary ---
SELECT
    C.CustomerID,
    C.CustomerName,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.WeightKg) AS TotalWeightKg,

    SUM(F.Revenue) AS TotalRevenue,

    SUM(F.TransportationCost) AS TransportationCost,

    SUM(F.Revenue - F.TransportationCost) AS Profit,

    CAST(
        SUM(F.Revenue - F.TransportationCost) * 100.0
        / NULLIF(SUM(F.Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2))
        AS AverageDelayHours,

    CAST(
        SUM(CASE
            WHEN F.SLAStatus = 'Met' THEN 1
            ELSE 0
        END) * 100.0
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F
INNER JOIN dbo.DimCustomer C
    ON F.CustomerID = C.CustomerID

GROUP BY
    C.CustomerID,
    C.CustomerName

ORDER BY TotalRevenue DESC;

