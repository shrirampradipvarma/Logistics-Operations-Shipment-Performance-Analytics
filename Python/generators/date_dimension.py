import pandas as pd


def generate_date_dimension():

    dates = pd.date_range(
        start="2024-01-01",
        end="2025-12-31",
        freq="D"
    )

    date_data = []

    for date in dates:

        date_data.append([
            date,
            date.strftime("%Y%m%d"),
            date.year,
            date.month,
            date.strftime("%B"),
            date.strftime("%b"),
            date.quarter,
            date.day,
            date.strftime("%A"),
            date.weekday() + 1,
            "Weekend" if date.weekday() >= 5 else "Weekday"
        ])

    columns = [
        "Date",
        "DateKey",
        "Year",
        "MonthNumber",
        "MonthName",
        "MonthShortName",
        "Quarter",
        "Day",
        "DayName",
        "DayOfWeekNumber",
        "DayType"
    ]

    return pd.DataFrame(date_data, columns=columns)