
-- Check Referential Integrity in ID's --
SELECT 
    fs.WarehouseID
FROM FactShipment fs
LEFT JOIN DimWarehouse dw
    ON fs.WarehouseID = dw.WarehouseID
WHERE dw.WarehouseID IS NULL;

SELECT 
    fs.CustomerID
FROM FactShipment fs
LEFT JOIN DimCustomer dc
    ON fs.CustomerID = dc.CustomerID
WHERE dc.CustomerID IS NULL;
