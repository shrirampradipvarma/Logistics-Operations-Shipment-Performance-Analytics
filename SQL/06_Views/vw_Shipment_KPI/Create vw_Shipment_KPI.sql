
--- Create vw_Shipment_KPI ---

CREATE OR ALTER VIEW dbo.vw_Shipment_KPI
AS
SELECT
    COUNT(*) AS TotalShipments,

    SUM(WeightKg) AS TotalWeightKg,

    SUM(Revenue) AS TotalRevenue,

    SUM(TransportationCost) AS TotalTransportationCost,

    SUM(Revenue - TransportationCost) AS TotalProfit,

    CAST(
        SUM(Revenue - TransportationCost) * 100.0
        / NULLIF(SUM(Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent,

    CAST(AVG(WeightKg) AS DECIMAL(12,2))
        AS AverageShipmentWeightKg,

    CAST(AVG(DistanceKm) AS DECIMAL(10,2))
        AS AverageDistanceKm,

    CAST(AVG(DelayHours) AS DECIMAL(10,2))
        AS AverageDelayHours,

    CAST(AVG(ProcessingTimeHours) AS DECIMAL(10,2))
        AS AverageProcessingTimeHours,

    SUM(
        CASE
            WHEN SLAStatus = 'Met' THEN 1
            ELSE 0
        END
    ) AS SLAMet,

    SUM(
        CASE
            WHEN SLAStatus = 'Breached' THEN 1
            ELSE 0
        END
    ) AS SLABreached,

    CAST(
        SUM(
            CASE
                WHEN SLAStatus = 'Met' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS SLAPercentage

FROM dbo.FactShipment;
GO

--- Run vw_Shipment_KPI ---
SELECT *
FROM dbo.vw_Shipment_KPI;