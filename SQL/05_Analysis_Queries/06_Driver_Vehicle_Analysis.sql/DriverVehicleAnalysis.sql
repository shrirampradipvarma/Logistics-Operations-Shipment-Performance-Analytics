
-- Create Analysis Queries --
/* =========================================================
   06_Driver_Vehicle_Analysis.sql
   Driver & Vehicle Performance Analysis
   ========================================================= */

   --- Driver Shipment Volume ---
   SELECT
    D.DriverID,
    D.DriverName,
    COUNT(F.ShipmentID) AS TotalShipments
FROM dbo.FactShipment F
INNER JOIN dbo.DimDriver D
    ON F.DriverID = D.DriverID
GROUP BY
    D.DriverID,
    D.DriverName
ORDER BY TotalShipments DESC;

--- Driver Performance ---
SELECT
    D.DriverID,
    D.DriverName,

    COUNT(F.ShipmentID) AS TotalShipments,

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
INNER JOIN dbo.DimDriver D
    ON F.DriverID = D.DriverID

GROUP BY
    D.DriverID,
    D.DriverName

ORDER BY SLAPercentage desc;

--- Driver Revenue & Profit ---
SELECT
    D.DriverID,
    D.DriverName,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.Revenue) AS TotalRevenue,

    SUM(F.TransportationCost) AS TransportationCost,

    SUM(F.Revenue - F.TransportationCost) AS Profit

FROM dbo.FactShipment F
INNER JOIN dbo.DimDriver D
    ON F.DriverID = D.DriverID

GROUP BY
    D.DriverID,
    D.DriverName

ORDER BY Profit desc;

--- Vehicle Shipment Volume ---
SELECT
    V.VehicleID,
    V.VehicleNumber,
    COUNT(F.ShipmentID) AS TotalShipments
FROM dbo.FactShipment F
INNER JOIN dbo.DimVehicle V
    ON F.VehicleID = V.VehicleID
GROUP BY
    V.VehicleID,
    V.VehicleNumber
ORDER BY TotalShipments DESC;

--- Vehicle Distance & Weight ---
SELECT
    V.VehicleID,
    V.VehicleNumber,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.WeightKg) AS TotalWeightKg,

    SUM(F.DistanceKm) AS TotalDistanceKm,

    CAST(
        AVG(F.DistanceKm)
        AS DECIMAL(10,2)
    ) AS AverageDistanceKm

FROM dbo.FactShipment F
INNER JOIN dbo.DimVehicle V
    ON F.VehicleID = V.VehicleID

GROUP BY
    V.VehicleID,
    V.VehicleNumber

ORDER BY TotalDistanceKm desc;

--- Vehicle Cost Performance ---
SELECT
    V.VehicleID,
    V.VehicleNumber,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.TransportationCost) AS TotalTransportationCost,

    CAST(
        SUM(F.TransportationCost)
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(12,2)
    ) AS CostPerShipment

FROM dbo.FactShipment F
INNER JOIN dbo.DimVehicle V
    ON F.VehicleID = V.VehicleID

GROUP BY
    V.VehicleID,
    V.VehicleNumber

ORDER BY CostPerShipment DESC;

--- Vehicle SLA Performance ---
SELECT
    V.VehicleID,
    V.VehicleNumber,

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
    ) AS SLAPercentage,

    CAST(
        AVG(F.DelayHours)
        AS DECIMAL(10,2)
    ) AS AverageDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimVehicle V
    ON F.VehicleID = V.VehicleID

GROUP BY
    V.VehicleID,
    V.VehicleNumber

ORDER BY SLAPercentage ASC;

--- Driver & Vehicle Combined Performance ---
SELECT
    D.DriverID,
    D.DriverName,

    V.VehicleID,
    V.VehicleNumber,

    COUNT(F.ShipmentID) AS TotalShipments,

    SUM(F.WeightKg) AS TotalWeightKg,

    SUM(F.DistanceKm) AS TotalDistanceKm,

    SUM(F.Revenue) AS TotalRevenue,

    SUM(F.TransportationCost) AS TransportationCost,

    SUM(F.Revenue - F.TransportationCost) AS Profit,

    CAST(
        AVG(F.DelayHours)
        AS DECIMAL(10,2)
    ) AS AverageDelayHours,

    CAST(
        SUM(CASE
            WHEN F.SLAStatus = 'Met' THEN 1
            ELSE 0
        END) * 100.0
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment F

INNER JOIN dbo.DimDriver D
    ON F.DriverID = D.DriverID

INNER JOIN dbo.DimVehicle V
    ON F.VehicleID = V.VehicleID

GROUP BY
    D.DriverID,
    D.DriverName,
    V.VehicleID,
    V.VehicleNumber

ORDER BY SLAPercentage DESC;