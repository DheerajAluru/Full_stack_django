

# def get_data() -> float:
#     # Write your code here
#     pass

def calculate_total_revenue(orders):
    """
    orders: List[Dict] - each dict should have 'item_name', 'quantity', and 'price_per_item'
    Returns total revenue as float.
    """
    if not isinstance(orders, list):
        raise ValueError("Orders must be a list of dictionaries.")

    total = 0.0
    for order in orders:
        try:
            total += order["quantity"] * order["price_per_item"]
        except (KeyError, TypeError):
            continue  # Skip invalid order entries

    return total

"""
Example usage: 

orders = [
    {"item_name": "Burger", "quantity": 2, "price_per_item": 150},
    {"item_name": "Pizza", "quantity": 1, "price_per_item": 300},
]
print(calculate_total_revenue(orders))  # Output: 600.0

"""