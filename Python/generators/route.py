import pandas as pd
import random

# Major Indian cities used in our logistics network
cities = [
    ("Mumbai", "Maharashtra"),
    ("Delhi", "Delhi"),
    ("Bengaluru", "Karnataka"),
    ("Hyderabad", "Telangana"),
    ("Pune", "Maharashtra"),
    ("Chennai", "Tamil Nadu"),
    ("Ahmedabad", "Gujarat"),
    ("Nagpur", "Maharashtra"),
    ("Jaipur", "Rajasthan"),
    ("Kolkata", "West Bengal"),
    ("Lucknow", "Uttar Pradesh"),
    ("Indore", "Madhya Pradesh")
]


def generate_route():

    routes = []

    for i in range(1, 101):

        origin = random.choice(cities)

        destination = random.choice(cities)

        # Prevent origin and destination from being the same
        while destination == origin:
            destination = random.choice(cities)

        origin_city = origin[0]
        origin_state = origin[1]

        destination_city = destination[0]
        destination_state = destination[1]

        # Generate realistic distance
        distance = random.randint(50, 1800)

        # Approximate transit time
        transit_time = round(distance / random.uniform(40, 55), 1)

        # Route type
        if distance <= 300:
            route_type = "Short Haul"

        elif distance <= 800:
            route_type = "Medium Haul"

        else:
            route_type = "Long Haul"

        # Toll estimate
        toll_cost = round(distance * random.uniform(1.5, 3.5), 0)

        routes.append([
            f"RT{i:03d}",
            origin_city,
            origin_state,
            destination_city,
            destination_state,
            distance,
            transit_time,
            route_type,
            toll_cost
        ])

    columns = [
        "RouteID",
        "OriginCity",
        "OriginState",
        "DestinationCity",
        "DestinationState",
        "DistanceKM",
        "ExpectedTransitHours",
        "RouteType",
        "EstimatedTollCost"
    ]

    return pd.DataFrame(routes, columns=columns)