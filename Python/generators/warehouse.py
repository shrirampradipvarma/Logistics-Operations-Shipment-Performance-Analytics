import pandas as pd
# Warehouse Data
warehouses = [
    ["WH001", "Mumbai Distribution Center", "Mumbai", "Maharashtra", 18000, "Rahul Sharma"],
    ["WH002", "Delhi Distribution Center", "Delhi", "Delhi", 22000, "Priya Verma"],
    ["WH003", "Bengaluru Distribution Center", "Bengaluru", "Karnataka", 16000, "Amit Patel"],
    ["WH004", "Hyderabad Distribution Center", "Hyderabad", "Telangana", 17000, "Neha Reddy"],
    ["WH005", "Pune Distribution Center", "Pune", "Maharashtra", 15000, "Vikas Joshi"],
    ["WH006", "Chennai Distribution Center", "Chennai", "Tamil Nadu", 16500, "Arun Kumar"],
    ["WH007", "Ahmedabad Distribution Center", "Ahmedabad", "Gujarat", 14000, "Sneha Shah"],
    ["WH008", "Nagpur Distribution Center", "Nagpur", "Maharashtra", 12000, "Kiran Deshmukh"],
    ["WH009", "Jaipur Distribution Center", "Jaipur", "Rajasthan", 13000, "Pooja Singh"],
    ["WH010", "Kolkata Distribution Center", "Kolkata", "West Bengal", 17500, "Sourav Ghosh"],
    ["WH011", "Lucknow Distribution Center", "Lucknow", "Uttar Pradesh", 14500, "Anjali Mishra"],
    ["WH012", "Indore Distribution Center", "Indore", "Madhya Pradesh", 13500, "Manish Tiwari"]
]

columns = [
    "WarehouseID",
    "WarehouseName",
    "City",
    "State",
    "Capacity",
    "WarehouseManager"
]

df = pd.DataFrame(warehouses, columns=columns) 

print(df)


