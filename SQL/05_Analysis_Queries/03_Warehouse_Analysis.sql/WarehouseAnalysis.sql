
-- Create Analysis Queries --
/* =========================================================
   03_Warehouse_Analysis.sql
   Warehouse Performance Analysis
   ========================================================= */

   --- Warehouse Shipment Volume ---
   SELECT
    W.WarehouseID,
    W.WarehouseName,
    COUNT(F.ShipmentID) AS TotalShipments
FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY TotalShipments DESC;

--- Warehouse Revenue & Transportation Cost ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    COUNT(F.ShipmentID) AS TotalShipments,
    SUM(F.Revenue) AS TotalRevenue,
    SUM(F.TransportationCost) AS TotalTransportationCost
FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY TotalRevenue DESC;

--- Warehouse Profit ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    SUM(F.Revenue) AS TotalRevenue,
    SUM(F.TransportationCost) AS TransportationCost,
    SUM(F.Revenue - F.TransportationCost) AS Profit
FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY Profit DESC;

--- Warehouse SLA Performance ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
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
        END) * 100.0 / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY SLAPercentage DESC;

--- Warehouse Delay Performance ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    CAST(AVG(F.DelayHours) AS DECIMAL(10,2)) AS AverageDelayHours,
    MAX(F.DelayHours) AS MaximumDelayHours
FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY AverageDelayHours DESC;

--- Warehouse Shipment Weight ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    SUM(F.WeightKg) AS TotalWeightKg,
    CAST(AVG(F.WeightKg) AS DECIMAL(12,2)) AS AverageShipmentWeightKg
FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY TotalWeightKg DESC;

--- Warehouse Cost per Shipment ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    COUNT(F.ShipmentID) AS TotalShipments,
    SUM(F.TransportationCost) AS TotalTransportationCost,

    CAST(
        SUM(F.TransportationCost)
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(12,2)
    ) AS CostPerShipment

FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID
GROUP BY
    W.WarehouseID,
    W.WarehouseName
ORDER BY CostPerShipment DESC;

--- Warehouse Management Summary ---
SELECT
    W.WarehouseID,
    W.WarehouseName,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.WeightKg) AS TotalWeightKg,

    SUM(F.Revenue) AS TotalRevenue,

    SUM(F.TransportationCost) AS TotalTransportationCost,

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
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID

GROUP BY
    W.WarehouseID,
    W.WarehouseName

ORDER BY TotalShipments DESC;