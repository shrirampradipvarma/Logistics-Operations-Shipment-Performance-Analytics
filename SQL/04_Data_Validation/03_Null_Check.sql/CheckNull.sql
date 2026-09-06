
-- Check Null's in Table --
SELECT * 
FROM FactShipment 
WHERE ShipmentID IS not NULL;

SELECT *
FROM FactShipment 
WHERE DispatchDate IS NULL;

SELECT *
FROM FactShipment 
WHERE WeightKg IS NULL;

SELECT *
FROM FactShipment 
WHERE SLAStatus IS NULL;