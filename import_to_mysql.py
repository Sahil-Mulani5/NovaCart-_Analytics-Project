import pandas as pd
import mysql.connector

# ===========================
# MySQL Connection
# ===========================

conn = mysql.connector.connect(
    host="1234",
    user="root",
    password="*******",
    database="novacart_analytics"
)

cursor = conn.cursor()

print("✅ Connected to MySQL")


# # ===========================
# # Import Customers
# # ===========================

# customers_df = pd.read_csv(
#     r"C:\Users\OM\Desktop\Novacart Analytics project\Data\customers.csv"
# )

# customers_df["is_active"] = customers_df["is_active"].astype(int)

# sql = """
# INSERT INTO customers
# (customer_id, first_name, last_name, gender, email, phone,
# city, state, join_date, loyalty_points, is_active)
# VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
# """

# data = list(customers_df.itertuples(index=False, name=None))

# cursor.executemany(sql, data)
# conn.commit()

# print(f"✅ Imported {cursor.rowcount} customers")

# # ===========================
# # Import Suppliers
# # ===========================

# suppliers_df = pd.read_csv(
#     r"C:\Users\OM\Desktop\Novacart Analytics project\Data\suppliers.csv"
# )

# suppliers_df["is_active"] = suppliers_df["is_active"].astype(int)

# sql = """
# INSERT INTO suppliers
# (supplier_id, supplier_name, supplier_type, contact_person,
# email, phone, city, state, country,
# supplier_rating, delivery_days, is_active)
# VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
# """

# data = list(suppliers_df.itertuples(index=False, name=None))

# cursor.executemany(sql, data)
# conn.commit()

# print(f"✅ Imported {cursor.rowcount} suppliers")

# # ===========================
# # Import Products
# # ===========================

# products_df = pd.read_csv(
#     r"C:\Users\OM\Desktop\Novacart Analytics project\Data\products.csv"
# )

# products_df["is_active"] = products_df["is_active"].astype(int)

# sql = """
# INSERT INTO products
# (product_id, product_name, category, brand, supplier_id,
# cost_price, selling_price, stock_quantity,
# rating, launch_date, is_active)
# VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
# """

# data = list(products_df.itertuples(index=False, name=None))

# cursor.executemany(sql, data)
# conn.commit()

# print(f"✅ Imported {cursor.rowcount} products")


# # ===========================
# # Import Orders
# # ===========================

# orders_df = pd.read_csv(
#     r"C:\Users\OM\Desktop\Novacart Analytics project\Data\orders.csv"
# )

# sql = """
# INSERT INTO orders
# (order_id, customer_id, product_id, order_date,
# quantity, unit_price, discount_percent,
# total_amount, payment_method, order_status)
# VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
# """

# data = list(orders_df.itertuples(index=False, name=None))

# batch_size = 5000

# for i in range(0, len(data), batch_size):
#     batch = data[i:i + batch_size]
#     cursor.executemany(sql, batch)
#     conn.commit()
#     print(f"Imported {min(i + batch_size, len(data))}/{len(data)} orders")
# conn.commit()

# print(f"✅ Imported {cursor.rowcount} orders")



# ===========================
# Import Returns
# ===========================

returns_df = pd.read_csv(
    r"C:\Users\OM\Desktop\Novacart Analytics project\Data\returns.csv"
)

sql = """
INSERT INTO returns
(return_id, order_id, return_date, reason,
refund_amount, status)
VALUES (%s,%s,%s,%s,%s,%s)
"""

data = list(returns_df.itertuples(index=False, name=None))

batch_size = 5000

for i in range(0, len(data), batch_size):
    batch = data[i:i + batch_size]
    cursor.executemany(sql, batch)
    conn.commit()
    print(f"Imported {min(i + batch_size, len(data))}/{len(data)} returns")

print("✅ Returns Imported Successfully")


cursor.close()
conn.close()

print("✅ Import Completed")

