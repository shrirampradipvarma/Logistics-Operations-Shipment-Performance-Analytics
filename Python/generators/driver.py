import pandas as pd
import random

first_names = [
    "Rajesh", "Amit", "Rahul", "Suresh", "Vikas",
    "Anil", "Ravi", "Manoj", "Deepak", "Arun",
    "Kiran", "Sanjay", "Vijay", "Rohit", "Nitin",
    "Pankaj", "Ajay", "Sunil", "Prakash", "Sachin"
]

last_names = [
    "Kumar", "Sharma", "Verma", "Patel", "Singh",
    "Yadav", "Gupta", "Joshi", "Mishra", "Reddy",
    "Shah", "Deshmukh", "Mehta", "Tiwari", "Jain"
]

warehouse_ids = [f"WH{i:03d}" for i in range(1, 13)]


def generate_driver():

    drivers = []

    for i in range(1, 421):

        driver_id = f"DRV{i:03d}"

        driver_name = (
            random.choice(first_names)
            + " "
            + random.choice(last_names)
        )

        experience_years = random.randint(0, 15)

        if experience_years <= 2:
            experience_level = "Junior"
            rating = round(random.uniform(3.5, 4.2), 1)

        elif experience_years <= 6:
            experience_level = "Mid"
            rating = round(random.uniform(4.0, 4.6), 1)

        else:
            experience_level = "Senior"
            rating = round(random.uniform(4.5, 5.0), 1)

        status_probability = random.random()

        if status_probability < 0.92:
            driver_status = "Active"

        elif status_probability < 0.97:
            driver_status = "Leave"

        else:
            driver_status = "Inactive"

        warehouse_id = random.choice(warehouse_ids)

        drivers.append([
            driver_id,
            driver_name,
            experience_level,
            experience_years,
            rating,
            warehouse_id,
            driver_status
        ])

    columns = [
        "DriverID",
        "DriverName",
        "ExperienceLevel",
        "ExperienceYears",
        "DriverRating",
        "WarehouseID",
        "DriverStatus"
    ]

    return pd.DataFrame(drivers, columns=columns)