#from generators.warehouse import generate_warehouse

#warehouse= generate_warehouse()

#print(warehouse.head())

#from generators.vehicle import generate_vehicle

#vehicle = generate_vehicle()

#print(vehicle.head())

#print("\nTotal Vehicle Records:", len(vehicle))

#print("\nColumns:")
#print(vehicle.columns)

#vehicle.to_excel("../Dataset/DimVehicle.xlsx", index=False)

#print("\nDimVehicle.xlsx Created Successfully!")

#from generators.driver import generate_driver

#driver = generate_driver()

#print(driver.head())

#print("\nTotal Driver Records:", len(driver))

#print("\nColumns:")
#print(driver.columns)

#driver.to_excel("../Dataset/DimDriver.xlsx", index=False)

#print("\nDimDriver.xlsx Created Successfully!")

'''from generators.route import generate_route

route = generate_route()

print(route.head())

print("\nTotal Route Records:", len(route))

print("\nColumns:")
print(route.columns)

route.to_excel("../Dataset/DimRoute.xlsx", index=False)

print("\nDimRoute.xlsx Created Successfully!")'''

'''from generators.date_dimension import generate_date_dimension

date_dimension = generate_date_dimension()

print(date_dimension.head())

print("\nTotal Date Records:", len(date_dimension))

print("\nColumns:")
print(date_dimension.columns)

date_dimension.to_excel(
    "../Dataset/DimDate.xlsx",
    index=False
)

print("\nDimDate.xlsx Created Successfully!")'''
import pandas as pd

from generators.shipment import generate_shipment


# Load dimension tables
customer = pd.read_excel("../Dataset/DimCustomer.xlsx")
warehouse = pd.read_excel("../Dataset/DimWarehouse.xlsx")
vehicle = pd.read_excel("../Dataset/DimVehicle.xlsx")
driver = pd.read_excel("../Dataset/DimDriver.xlsx")
route = pd.read_excel("../Dataset/DimRoute.xlsx")
date = pd.read_excel("../Dataset/DimDate.xlsx")


print("Dimension tables loaded successfully.")


# Generate FactShipment
shipment = generate_shipment(
    customer_df=customer,
    warehouse_df=warehouse,
    vehicle_df=vehicle,
    driver_df=driver,
    route_df=route,
    date_df=date,
    shipment_count=20000
)


# Display first 5 records
print("\nFirst 5 Shipment Records:")
print(shipment.head())


# Record count
print("\nTotal Shipment Records:", len(shipment))


# Column information
print("\nColumns:")
print(shipment.columns)


# Export FactShipment
shipment.to_excel(
    "../Dataset/FactShipment.xlsx",
    index=False
)


print("\nFactShipment.xlsx Created Successfully!")

