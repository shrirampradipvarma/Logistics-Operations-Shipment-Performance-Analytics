import pandas as pd

fact = pd.read_excel("../Dataset/FactShipment.xlsx")

print("Total Records:", len(fact))

print("\nDuplicate Shipment IDs:")
print(fact["ShipmentID"].duplicated().sum())

print("\nMissing Values:")
print(fact.isnull().sum())

print("\nRevenue < Cost Records:")
print(len(fact[fact["Revenue"] < fact["TransportationCost"]]))

print("\nDelivery Before Dispatch:")
print(len(fact[fact["DeliveryDate"] < fact["DispatchDate"]]))