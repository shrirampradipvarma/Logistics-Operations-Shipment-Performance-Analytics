import pandas as pd
import random

# Vehicle type configuration
vehicle_master = {
    "Van": {"capacity": 2, "fuel": "Diesel"},
    "Mini Truck": {"capacity": 5, "fuel": "Diesel"},
    "Truck": {"capacity": 12, "fuel": "Diesel"},
    "Trailer": {"capacity": 25, "fuel": "Diesel"},
    "Electric Van": {"capacity": 2, "fuel": "Electric"}
}

states = {
    "MH": "Maharashtra",
    "DL": "Delhi",
    "KA": "Karnataka",
    "TS": "Telangana",
    "TN": "Tamil Nadu",
    "GJ": "Gujarat"
}

status_list = (
    ["Active"] * 90 +
    ["Maintenance"] * 8 +
    ["Out of Service"] * 2
)

def vehicle_number():

    state = random.choice(list(states.keys()))

    district = random.randint(1, 99)

    letters = "".join(random.choices("ABCDEFGHIJKLMNOPQRSTUVWXYZ", k=2))

    number = random.randint(1000, 9999)

    return f"{state}{district:02d}{letters}{number}"


def generate_vehicle():

    vehicles = []

    types = list(vehicle_master.keys())

    for i in range(1,351):

        vehicle_type = random.choice(types)

        vehicles.append([

            f"VEH{i:03d}",

            vehicle_number(),

            vehicle_type,

            vehicle_master[vehicle_type]["capacity"],

            vehicle_master[vehicle_type]["fuel"],

            random.choice(status_list)

        ])

    columns = [

        "VehicleID",
        "VehicleNumber",
        "VehicleType",
        "CapacityTons",
        "FuelType",
        "VehicleStatus"

    ]

    return pd.DataFrame(vehicles, columns=columns)

