USE LogisticsOperationsDB;
GO
-- Created Table Dimwarehouse --

CREATE TABLE dbo.DimWarehouse
(
    WarehouseID VARCHAR(10) NOT NULL,
    WarehouseName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    WarehouseType VARCHAR(50),
    CapacityTons DECIMAL(12,2),

    CONSTRAINT PK_DimWarehouse
        PRIMARY KEY (WarehouseID)
);
GO

-- Created Table DimCustomer --

CREATE TABLE dbo.DimCustomer
(
    CustomerID VARCHAR(10) NOT NULL,
    CustomerName VARCHAR(100),
    CustomerType VARCHAR(50),
    Industry VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY (CustomerID)
);
GO

-- Created Table DimVehicle --

CREATE TABLE dbo.DimVehicle
(
    VehicleID VARCHAR(10) NOT NULL,
    VehicleNumber VARCHAR(20),
    VehicleType VARCHAR(50),
    CapacityKg DECIMAL(12,2),
    FuelType VARCHAR(30),
    VehicleStatus VARCHAR(30),

    CONSTRAINT PK_DimVehicle
        PRIMARY KEY (VehicleID)
);
GO

-- Created Table DimDriver --

CREATE TABLE dbo.DimDriver
(
    DriverID VARCHAR(10) NOT NULL,
    DriverName VARCHAR(100),
    ExperienceLevel VARCHAR(30),
    ExperienceYears INT,
    DriverRating DECIMAL(3,1),
    WarehouseID VARCHAR(10),
    DriverStatus VARCHAR(30),

    CONSTRAINT PK_DimDriver
        PRIMARY KEY (DriverID)
);
GO

-- Created Table DimRoute --

CREATE TABLE dbo.DimRoute
(
    RouteID VARCHAR(10) NOT NULL,
    OriginCity VARCHAR(50),
    OriginState VARCHAR(50),
    DestinationCity VARCHAR(50),
    DestinationState VARCHAR(50),
    DistanceKm DECIMAL(10,2),
    ExpectedTransitHours DECIMAL(10,2),
    RouteType VARCHAR(30),
    EstimatedTollCost DECIMAL(12,2),

    CONSTRAINT PK_DimRoute
        PRIMARY KEY (RouteID)
);
GO

-- Created Table DimDate --

CREATE TABLE dbo.DimDate
(
    DateKey INT NOT NULL,
    Date DATE NOT NULL,
    Year INT,
    MonthNumber INT,
    MonthName VARCHAR(20),
    MonthShortName VARCHAR(10),
    Quarter INT,
    Day INT,
    DayName VARCHAR(20),
    DayOfWeekNumber INT,
    DayType VARCHAR(20),

    CONSTRAINT PK_DimDate
        PRIMARY KEY (DateKey)
);
GO

-- Created Table FactShipment --
CREATE TABLE FactShipment
(
    ShipmentID VARCHAR(15),
    OrderID VARCHAR(15),
    CustomerID VARCHAR(10),
    WarehouseID VARCHAR(10),
    VehicleID VARCHAR(10),
    DriverID VARCHAR(10),

    RouteID VARCHAR(10),

    DispatchDate VARCHAR(50),
    DeliveryDate VARCHAR(50),

    ShipmentStatus VARCHAR(30),
    ShipmentType VARCHAR(30),

    WeightKg VARCHAR(50),
    DistanceKm VARCHAR(50),
    TransportationCost VARCHAR(50),
    Revenue VARCHAR(50),
    DelayHours VARCHAR(50),

    SLAStatus VARCHAR(30),
    ProcessingTimeHours VARCHAR(50)
);
GO

-- Created Table DimDate_Staging --
CREATE TABLE dbo.DimDate_Staging
(
    DateKey VARCHAR(20),
    DateText VARCHAR(50),
    YearText VARCHAR(20),
    MonthNumberText VARCHAR(20),
    MonthName VARCHAR(20),
    MonthShortName VARCHAR(10),
    QuarterText VARCHAR(20),
    DayText VARCHAR(20),
    DayName VARCHAR(20),
    DayOfWeekNumberText VARCHAR(20),
    DayType VARCHAR(20)
);
GO

-- Update Table DimDate_Staging --

UPDATE DimDate_Staging
SET
    DateText = CONVERT(VARCHAR(10), TRY_CONVERT(DATE, DateKey, 112), 23),

    YearText = CONVERT(VARCHAR(4),
        YEAR(TRY_CONVERT(DATE, DateKey, 112))),

    MonthNumberText = CONVERT(VARCHAR(2),
        MONTH(TRY_CONVERT(DATE, DateKey, 112))),

    QuarterText = CONVERT(VARCHAR(1),
        DATEPART(QUARTER, TRY_CONVERT(DATE, DateKey, 112))),

    DayText = CONVERT(VARCHAR(2),
        DAY(TRY_CONVERT(DATE, DateKey, 112))),

    DayOfWeekNumberText = CONVERT(VARCHAR(1),
        DATEPART(WEEKDAY, TRY_CONVERT(DATE, DateKey, 112)));
GO

-- Created Table DimDate_Staging --

CREATE TABLE FactShipment_Staging
(
    ShipmentID VARCHAR(15),
    OrderID VARCHAR(15),
    CustomerID VARCHAR(10),
    WarehouseID VARCHAR(10),
    VehicleID VARCHAR(10),
    DriverID VARCHAR(10),

    RouteID VARCHAR(10),

    DispatchDate VARCHAR(50),
    DeliveryDate VARCHAR(50),

    ShipmentStatus VARCHAR(30),
    ShipmentType VARCHAR(30),

    WeightKg VARCHAR(50),
    DistanceKm VARCHAR(50),
    TransportationCost VARCHAR(50),
    Revenue VARCHAR(50),
    DelayHours VARCHAR(50),

    SLAStatus VARCHAR(30),
    ProcessingTimeHours VARCHAR(50)
);
GO