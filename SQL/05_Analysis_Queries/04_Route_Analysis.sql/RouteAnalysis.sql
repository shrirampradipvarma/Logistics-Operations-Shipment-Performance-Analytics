
-- Create Analysis Queries --
/* =========================================================
   04_Route_Analysis.sql
   Route Performance Analysis
   ========================================================= */

   --- Route Shipment Volume ---
   SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,
    COUNT(F.ShipmentID) AS TotalShipments
FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID
GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity
ORDER BY TotalShipments DESC;

--- Route Distance & Weight ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,
    COUNT(F.ShipmentID) AS TotalShipments,
    SUM(F.WeightKg) AS TotalWeightKg,
    CAST(AVG(F.DistanceKm) AS DECIMAL(10,2)) AS AverageDistanceKm
FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID
GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity
ORDER BY TotalWeightKg DESC;

--- Route Revenue & Cost ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,
    SUM(F.Revenue) AS TotalRevenue,
    SUM(F.TransportationCost) AS TransportationCost
FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID
GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity
ORDER BY TotalRevenue DESC;

--- Route Profitability ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

    SUM(F.Revenue) AS TotalRevenue,

    SUM(F.TransportationCost) AS TransportationCost,

    SUM(F.Revenue - F.TransportationCost) AS Profit,

    CAST(
        SUM(F.Revenue - F.TransportationCost) * 100.0
        / NULLIF(SUM(F.Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent

FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY Profit DESC;

--- Route SLA Performance ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

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
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY SLAPercentage ASC;

--- Route Delay Analysis ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2))
        AS AverageDelayHours,

    MAX(F.DelayHours) AS MaximumDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY AverageDelayHours DESC;

--- Top 10 Problematic Routes ---
SELECT TOP 10
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

    COUNT(F.ShipmentID) AS TotalShipments,

    CAST(
        SUM(CASE
            WHEN F.SLAStatus = 'Met' THEN 1
            ELSE 0
        END) * 100.0
        / NULLIF(COUNT(F.ShipmentID), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage,

    CAST(AVG(F.DelayHours) AS DECIMAL(10,2))
        AS AverageDelayHours

FROM dbo.FactShipment F
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY
    SLAPercentage ASC,
    AverageDelayHours DESC;

--- Route Management Summary ---
SELECT
    R.RouteID,
    R.OriginCity,
    R.DestinationCity,

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

    CAST(AVG(F.DistanceKm) AS DECIMAL(10,2))
        AS AverageDistanceKm,

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
INNER JOIN dbo.DimRoute R
    ON F.RouteID = R.RouteID

GROUP BY
    R.RouteID,
    R.OriginCity,
    R.DestinationCity

ORDER BY TotalShipments desc;