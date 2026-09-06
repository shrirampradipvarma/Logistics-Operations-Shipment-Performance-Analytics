
--- Create vw_Warehouse_Performance ---

CREATE OR ALTER VIEW dbo.vw_Warehouse_Performance
AS
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

    CAST(
        AVG(F.DelayHours)
        AS DECIMAL(10,2)
    ) AS AverageDelayHours,

    SUM(
        CASE
            WHEN F.SLAStatus = 'Met' THEN 1
            ELSE 0
        END
    ) AS SLAMet,

    SUM(
        CASE
            WHEN F.SLAStatus = 'Breached' THEN 1
            ELSE 0
        END
    ) AS SLABreached,

    CAST(
        SUM(
            CASE
                WHEN F.SLAStatus = 'Met' THEN 1
                ELSE 0
            END
        ) * 100.0
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F

INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID

GROUP BY
    W.WarehouseID,
    W.WarehouseName;
GO

--- Run vw_Warehouse_Performance ---
SELECT *
FROM dbo.vw_Warehouse_Performance
ORDER BY TotalShipments DESC;