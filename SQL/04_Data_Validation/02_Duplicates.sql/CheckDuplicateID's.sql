
-- Data Validation Check Duplicate ID's --
SELECT CustomerID, COUNT(*) AS occurrences
FROM DimCustomer
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT WarehouseID, COUNT(*) AS occurrences
FROM DimWarehouse
GROUP BY WarehouseID
HAVING COUNT(*) > 1;

SELECT VehicleID, COUNT(*) AS occurrences
FROM DimVehicle
GROUP BY VehicleID
HAVING COUNT(*) > 1;

SELECT ShipmentID, COUNT(*) AS occurrences
FROM FactShipment
GROUP BY ShipmentID
HAVING COUNT(*) > 1;