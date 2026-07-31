import os
import random
from faker import Faker
import pandas as pd
from datetime import datetime, timedelta
from tqdm import tqdm

fake = Faker("en_IN")

# ==========================
# CONFIGURATION
# ==========================

NUM_CUSTOMERS = 200000
NUM_SUPPLIERS = 2000
NUM_PRODUCTS = 50000
NUM_ORDERS = 1000000
RETURN_RATE = 0.10

DATA_FOLDER = r"C:\Users\OM\Desktop\Novacart Analytics project\Data"

os.makedirs(DATA_FOLDER, exist_ok=True)

random.seed(42)

print("=" * 50)
print("NovaCart Analytics Dataset Generator")
print("=" * 50)
print(f"Customers : {NUM_CUSTOMERS:,}")
print(f"Suppliers : {NUM_SUPPLIERS:,}")
print(f"Products  : {NUM_PRODUCTS:,}")
print(f"Orders    : {NUM_ORDERS:,}")
print("=" * 50)

# ==========================
# GENERATE CUSTOMERS
# ==========================

print("\nGenerating Customers...")

customers = []

cities = [
    "Mumbai", "Delhi", "Pune", "Bengaluru", "Hyderabad",
    "Chennai", "Ahmedabad", "Kolkata", "Jaipur", "Surat",
    "Lucknow", "Nagpur", "Indore", "Bhopal", "Nashik"
]

states = [
    "Maharashtra", "Delhi", "Karnataka", "Telangana",
    "Tamil Nadu", "Gujarat", "West Bengal", "Rajasthan",
    "Uttar Pradesh", "Madhya Pradesh"
]

genders = ["Male", "Female"]

for i in tqdm(range(1, NUM_CUSTOMERS + 1)):

    join_date = fake.date_between(
        start_date="-5y",
        end_date="today"
    )

    customers.append({
        "customer_id": f"CUST{i:06d}",
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "gender": random.choice(genders),
        "email": fake.unique.email(),
        "phone": fake.msisdn()[:10],
        "city": random.choice(cities),
        "state": random.choice(states),
        "join_date": join_date,
        "loyalty_points": random.randint(0, 5000),
        "is_active": random.choice([True, False])
    })

customers_df = pd.DataFrame(customers)

customers_df.to_csv(
    os.path.join(DATA_FOLDER, "customers.csv"),
    index=False
)

print("✅ customers.csv Created Successfully")
print(customers_df.head())


# ==========================
# GENERATE SUPPLIERS
# ==========================

print("\nGenerating Suppliers...")

supplier_types = [
    "Manufacturer",
    "Distributor",
    "Wholesaler",
    "Importer"
]

suppliers = []

for i in tqdm(range(1, NUM_SUPPLIERS + 1)):

    suppliers.append({
        "supplier_id": f"SUP{i:05d}",
        "supplier_name": fake.company(),
        "supplier_type": random.choice(supplier_types),
        "contact_person": fake.name(),
        "email": fake.company_email(),
        "phone": fake.msisdn()[:10],
        "city": random.choice(cities),
        "state": random.choice(states),
        "country": "India",
        "supplier_rating": round(random.uniform(3.0, 5.0), 1),
        "delivery_days": random.randint(2, 15),
        "is_active": random.choice([True, False])
    })

suppliers_df = pd.DataFrame(suppliers)

suppliers_df.to_csv(
    os.path.join(DATA_FOLDER, "suppliers.csv"),
    index=False
)

print("✅ suppliers.csv Created Successfully")
print(suppliers_df.head())


# ==========================
# GENERATE PRODUCTS
# ==========================

print("\nGenerating Products...")

categories = [
    "Electronics",
    "Fashion",
    "Home & Kitchen",
    "Grocery",
    "Beauty",
    "Sports",
    "Books",
    "Furniture",
    "Toys",
    "Automotive"
]

brands = [
    "NovaTech", "Prime", "EcoLife", "UrbanStyle",
    "SmartBuy", "FreshMart", "Elite", "Vision",
    "MaxPro", "TrendX"
]

products = []

for i in tqdm(range(1, NUM_PRODUCTS + 1)):

    products.append({
        "product_id": f"PROD{i:06d}",
        "product_name": fake.word().title() + " " + random.choice([
            "Phone","Laptop","Chair","Table","Bottle",
            "Shoes","Bag","Watch","Headphones","Keyboard"
        ]),
        "category": random.choice(categories),
        "brand": random.choice(brands),
        "supplier_id": f"SUP{random.randint(1, NUM_SUPPLIERS):05d}",
        "cost_price": round(random.uniform(100,5000),2),
        "selling_price": round(random.uniform(150,7000),2),
        "stock_quantity": random.randint(0,500),
        "rating": round(random.uniform(3.0,5.0),1),
        "launch_date": fake.date_between(start_date="-5y", end_date="today"),
        "is_active": random.choice([True,False])
    })

products_df = pd.DataFrame(products)

products_df.to_csv(
    os.path.join(DATA_FOLDER,"products.csv"),
    index=False
)

print("✅ products.csv Created Successfully")
print(products_df.head())

# ==========================
# GENERATE ORDERS
# ==========================

print("\nGenerating Orders...")

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cash on Delivery"
]

order_status = [
    "Delivered",
    "Shipped",
    "Processing",
    "Cancelled"
]

orders = []

for i in tqdm(range(1, NUM_ORDERS + 1)):

    qty = random.randint(1, 5)

    price = round(random.uniform(200, 6000), 2)

    discount = round(random.uniform(0, 30), 2)

    total = round((price * qty) * (1 - discount / 100), 2)

    order_date = fake.date_between(
        start_date="-3y",
        end_date="today"
    )

    orders.append({
        "order_id": f"ORD{i:07d}",
        "customer_id": f"CUST{random.randint(1, NUM_CUSTOMERS):06d}",
        "product_id": f"PROD{random.randint(1, NUM_PRODUCTS):06d}",
        "order_date": order_date,
        "quantity": qty,
        "unit_price": price,
        "discount_percent": discount,
        "total_amount": total,
        "payment_method": random.choice(payment_methods),
        "order_status": random.choice(order_status)
    })

orders_df = pd.DataFrame(orders)

orders_df.to_csv(
    os.path.join(DATA_FOLDER, "orders.csv"),
    index=False
)

print("✅ orders.csv Created Successfully")
print(orders_df.head())


# ==========================
# GENERATE RETURNS
# ==========================

print("\nGenerating Returns...")

return_reasons = [
    "Damaged Product",
    "Wrong Item",
    "Quality Issue",
    "Changed Mind",
    "Late Delivery"
]

returns = []

num_returns = int(NUM_ORDERS * RETURN_RATE)

for i in tqdm(range(1, num_returns + 1)):

    returns.append({
        "return_id": f"RET{i:06d}",
        "order_id": f"ORD{random.randint(1, NUM_ORDERS):07d}",
        "return_date": fake.date_between(
            start_date="-2y",
            end_date="today"
        ),
        "reason": random.choice(return_reasons),
        "refund_amount": round(random.uniform(100, 5000), 2),
        "status": random.choice([
            "Approved",
            "Rejected",
            "Pending"
        ])
    })

returns_df = pd.DataFrame(returns)

returns_df.to_csv(
    os.path.join(DATA_FOLDER, "returns.csv"),
    index=False
)

print("✅ returns.csv Created Successfully")
print(returns_df.head())