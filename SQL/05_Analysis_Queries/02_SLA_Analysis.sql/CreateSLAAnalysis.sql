
-- Create Analysis Queries --
/* =========================================================
   02_SLA_Analysis.sql
   SLA Performance Analysis
   ========================================================= */

   --- SLA Status Summary ---
   SELECT
    SLAStatus,
    COUNT(*) AS ShipmentCount
FROM dbo.FactShipment
GROUP BY SLAStatus
ORDER BY ShipmentCount DESC;

--- SLA Percentage ---
SELECT
    CAST(
        SUM(
            CASE
                WHEN SLAStatus = 'Met' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS SLA_Percentage
FROM dbo.FactShipment;

--- SLA Met vs Breached with Percentage ---
SELECT
    SLAStatus,
    COUNT(*) AS ShipmentCount,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(10,2)
    ) AS PercentageOfShipments
FROM dbo.FactShipment
GROUP BY SLAStatus
ORDER BY ShipmentCount DESC;

--- Average Delay by SLA Status ---
SELECT
    W.WarehouseID,
    W.WarehouseName,
    COUNT(F.ShipmentID) AS TotalShipments,

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
        ) * 100.0 / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F
INNER JOIN dbo.DimWarehouse W
    ON F.WarehouseID = W.WarehouseID

GROUP BY
    W.WarehouseID,
    W.WarehouseName

ORDER BY SLAPercentage ASC;

--- SLA Performance by Route ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

    COUNT(F.ShipmentID) AS TotalShipments,

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
        ) * 100.0 / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2)) AS AverageDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY SLAPercentage ASC;

--- Worst 10 Routes ---
SELECT TOP 10
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

    COUNT(F.ShipmentID) AS TotalShipments,

    CAST(
        SUM(
            CASE
                WHEN F.SLAStatus = 'Met' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2)) AS AverageDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY SLAPercentage ASC;

--- SLA Breach by Shipment Type ---
SELECT
    ShipmentType,
    COUNT(*) AS TotalShipments,

    SUM(
        CASE
            WHEN SLAStatus = 'Breached' THEN 1
            ELSE 0
        END
    ) AS SLABreached,

    CAST(
        SUM(
            CASE
                WHEN SLAStatus = 'Breached' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS BreachPercentage

FROM dbo.FactShipment

GROUP BY ShipmentType

ORDER BY BreachPercentage DESC;

--- Highest Delay Shipments ---
SELECT TOP 20
    ShipmentID,
    CustomerID,
    WarehouseID,
    RouteID,
    DispatchDate,
    DeliveryDate,
    DelayHours,
    SLAStatus
FROM dbo.FactShipment
ORDER BY DelayHours DESC;
