import pandas as pd
from faker import Faker
import random
fake = Faker("en_IN")

customers = []

customer_types = (
    ["Enterprise"] * 40 +
    ["SME"] * 35 +
    ["Individual"] * 25
)

industries = [
    "Manufacturing",
    "Retail",
    "E-Commerce",
    "FMCG",
    "Healthcare",
    "Automotive",
    "Electronics",
    "Textile"
]

cities = [
    "Mumbai",
    "Delhi",
    "Bengaluru",
    "Hyderabad",
    "Pune",
    "Chennai",
    "Ahmedabad",
    "Nagpur",
    "Jaipur",
    "Kolkata",
    "Lucknow",
    "Indore"
]

states = {
    "Mumbai": "Maharashtra",
    "Delhi": "Delhi",
    "Bengaluru": "Karnataka",
    "Hyderabad": "Telangana",
    "Pune": "Maharashtra",
    "Chennai": "Tamil Nadu",
    "Ahmedabad": "Gujarat",
    "Nagpur": "Maharashtra",
    "Jaipur": "Rajasthan",
    "Kolkata": "West Bengal",
    "Lucknow": "Uttar Pradesh",
    "Indore": "Madhya Pradesh"
}

for i in range(1, 501):

    city = random.choice(cities)

    customers.append([

        f"CUST{i:04d}",

        fake.company(),

        random.choice(customer_types),

        random.choice(industries),

        city,

        states[city]

    ])

customer_df = pd.DataFrame(customers, columns=[
    "CustomerID",
    "CustomerName",
    "CustomerType",
    "Industry",
    "City",
    "State"
])



print(customer_df.head())

