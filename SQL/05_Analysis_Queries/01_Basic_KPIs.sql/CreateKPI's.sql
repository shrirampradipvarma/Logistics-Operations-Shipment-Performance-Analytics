
-- Create Analysis Queries --
/* =========================================================
   01_Basic_KPIs.sql
   Logistics Operations Analysis
   ========================================================= */
   
  --- Total Shipments ---
   SELECT
    COUNT(*) AS TotalShipments
FROM dbo.FactShipment;

--- Total Weight Transported ---
SELECT
    SUM(WeightKg) AS TotalWeightKg
FROM dbo.FactShipment;

--- Total Revenue ---
SELECT
    SUM(Revenue) AS TotalRevenue
FROM dbo.FactShipment;

--- Total Transportation Cost ---
SELECT
    SUM(TransportationCost) AS TotalTransportationCost
FROM dbo.FactShipment;
 
--- Average Shipment Weight ---
SELECT
    AVG(WeightKg) AS AverageShipmentWeightKg
FROM dbo.FactShipment;

--- Average Distance ---
SELECT
    AVG(DistanceKm) AS AverageDistanceKm
FROM dbo.FactShipment;

--- Average Delay ---
SELECT
    AVG(DelayHours) AS AverageDelayHours
FROM dbo.FactShipment;

--- Average Processing Time ---
SELECT
    AVG(ProcessingTimeHours) AS AverageProcessingTimeHours
FROM dbo.FactShipment;

--- Total Profit ---
SELECT
    SUM(Revenue - TransportationCost) AS TotalProfit
FROM dbo.FactShipment;

--- Profit Margin % ---
SELECT
    CAST(
        SUM(Revenue - TransportationCost) * 100.0
        / NULLIF(SUM(Revenue), 0)
        AS DECIMAL(10,2)
    ) AS ProfitMarginPercent
FROM dbo.FactShipment;

--- SLA Performance ---
SELECT
    COUNT(*) AS TotalShipments,
    SUM(
        CASE
            WHEN SLAStatus = 'Met' THEN 1
            ELSE 0
        END
    ) AS SLA_Met,
    SUM(
        CASE
            WHEN SLAStatus = 'Breached' THEN 1
            ELSE 0
        END
    ) AS SLA_Breached
FROM dbo.FactShipment;

--- SLA % ---
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

