import pandas as pd
import random
from datetime import timedelta


def generate_shipment(
    customer_df,
    warehouse_df,
    vehicle_df,
    driver_df,
    route_df,
    date_df,
    shipment_count=20000
):

    shipments = []

    # Valid IDs from dimension tables
    customer_ids = customer_df["CustomerID"].tolist()
    warehouse_ids = warehouse_df["WarehouseID"].tolist()
    vehicle_ids = vehicle_df["VehicleID"].tolist()
    driver_ids = driver_df["DriverID"].tolist()
    route_ids = route_df["RouteID"].tolist()

    # Date range
    dates = date_df["Date"].tolist()

    # Shipment types
    shipment_types = [
        "Standard",
        "Express",
        "Priority"
    ]

    # Shipment status
    shipment_statuses = [
        "Delivered",
        "In Transit",
        "Cancelled"
    ]

    # SLA status
    sla_statuses = [
        "Met",
        "Breached"
    ]

    # Generate shipments
    for i in range(1, shipment_count + 1):

        shipment_id = f"SHP{i:05d}"
        order_id = f"ORD{i:05d}"

        customer_id = random.choice(customer_ids)
        warehouse_id = random.choice(warehouse_ids)
        vehicle_id = random.choice(vehicle_ids)
        driver_id = random.choice(driver_ids)
        route_id = random.choice(route_ids)

        dispatch_date = random.choice(dates)

        # Delivery normally happens within 1–4 days
        delivery_days = random.randint(1, 4)

        delivery_date = dispatch_date + timedelta(days=delivery_days)

        # Shipment type
        shipment_type = random.choice(shipment_types)

        # Weight
        weight_kg = round(random.uniform(50, 5000), 2)

        # Distance
        route_row = route_df[
            route_df["RouteID"] == route_id
        ].iloc[0]

        distance_km = int(route_row["DistanceKM"])

        # Transportation cost
        transportation_cost = round(
            distance_km * random.uniform(15, 35)
            + weight_kg * random.uniform(0.5, 2),
            2
        )

        # Revenue
        revenue = round(
            transportation_cost * random.uniform(1.20, 1.60),
            2
        )

        # Delay
        delay_hours = random.choice([
            0, 0, 0, 1, 2, 3, 4, 6, 8, 12
        ])

        # SLA
        if delay_hours <= 2:
            sla_status = "Met"
        else:
            sla_status = "Breached"

        # Processing time
        processing_time_hours = round(
            random.uniform(1, 12),
            2
        )

        # Shipment status
        shipment_status = random.choices(
            shipment_statuses,
            weights=[90, 8, 2],
            k=1
        )[0]

        shipments.append([
            shipment_id,
            order_id,
            customer_id,
            warehouse_id,
            vehicle_id,
            driver_id,
            route_id,
            dispatch_date,
            delivery_date,
            shipment_status,
            shipment_type,
            weight_kg,
            distance_km,
            transportation_cost,
            revenue,
            delay_hours,
            sla_status,
            processing_time_hours
        ])

    columns = [
        "ShipmentID",
        "OrderID",
        "CustomerID",
        "WarehouseID",
        "VehicleID",
        "DriverID",
        "RouteID",
        "DispatchDate",
        "DeliveryDate",
        "ShipmentStatus",
        "ShipmentType",
        "WeightKg",
        "DistanceKm",
        "TransportationCost",
        "Revenue",
        "DelayHours",
        "SLAStatus",
        "ProcessingTimeHours"
    ]

    return pd.DataFrame(
        shipments,
        columns=columns
    )