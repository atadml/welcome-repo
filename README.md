# Project schema
<details>
  <summary> View schema </summary>

```yml
public.distribution_centers:
  building: string
  country: string
  id: number
  name: string
  state: string
  street: string
  town: string
  zip_code: string

public.inventory_items:
  cost: number
  created_at: timestamp
  distribution_center_id: number
  id: number
  product_id: number
  quantity: number

public.order_items:
  created_at: timestamp
  delivered_at: timestamp
  id: number
  inventory_item_id: number
  order_id: number
  returned_at: timestamp
  sale_price: number
  sale_quantity: number
  shipped_at: timestamp
  status: string

public.orders:
  created_at: datetime
  id: number
  status: string
  user_id: number

public.products:
  brand: string
  category: string
  color: string
  department: string
  id: number
  material: string
  name: string
  size: string
  sku: string
  subcategory: string
  weight: number

public.users:
  age: number
  city: string
  country: string
  created_at: timestamp
  email: string
  first_name: string
  gender: string
  id: number
  last_name: string
  latitude: number
  longitude: number
  state: string
  traffic_source: string
  zip: zipcode
```

</details>


# Sample questions

## LookML:
<details>
  <summary> Generate an order items explore for this project in lkml </summary>
  
```lookml

# File: order_items.view.lkml
explore: order_items {
  join: products {
    sql_on: ${order_items.inventory_item_id} = ${products.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: orders {
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: users {
    sql_on: ${orders.user_id} = ${users.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: distribution_centers {
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    type: inner
    relationship: many_to_one
  }
}
```
</details>

<details>
  <summary> output average order value by customer registration month in lookml </summary>
  
```lookml


view: user_order_facts {
  derived_table: {
    sql:
      SELECT
        u.id AS user_id,
        DATE_TRUNC('month', u.created_date) AS registration_month,
        o.id AS order_id,
        o.created_date AS order_date,
        oi.sale_price AS item_sale_price
      FROM
        users u
      LEFT JOIN
        orders o
      ON
        u.id = o.user_id
      LEFT JOIN
        order_items oi
      ON
        o.id = oi.order_id
    ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: registration_month {
    type: date
    sql: ${TABLE}.registration_month ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${order_id} * ${item_sale_price} ;;
  }

  measure: unique_customers {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: average_order_value {
    type: number
    sql: ${total_revenue} / NULLIF(${count}, 0) ;;
  }
}

```
</details>

<details>
  <summary> output item return rate by customer state in lookml </summary>

```lookml

# In users.view.lkml
measure: total_items_purchased {
  type: sum
  sql: ${order_items.sale_quantity} ;;
}

# In orders.view.lkml
measure: total_items_returned {
  type: sum
  sql: ${CASE WHEN ${order_items.status} = 'returned' THEN ${order_items.sale_quantity} ELSE 0 END} ;;
}

# In the users.view.lkml (assuming you have already added the total_items_purchased measure as per the previous code block)
measure: return_rate {
  type: number
  sql: ${IFNULL(${total_items_returned}, 0)} / NULLIF(${total_items_purchased}, 0) ;;
  value_format_name: "percent_2"
}

```
</details>

<details>
  <summary> generate customer ltv measure in lookml </summary>

```lookml

view: user_order_facts {
  derived_table: {
    sql:
      SELECT
        user_id,
        COUNT(DISTINCT id) AS total_orders,
        SUM(sale_price * sale_quantity) AS total_revenue
      FROM
        ecommerce.orders
      GROUP BY
        user_id
    ;;
  }

  measure: lifetime_value {
    type: number
    sql: ${total_revenue} ;;
    value_format_name: "usd"
  }

  # other measures and dimensions...
}
```
</details>

<details>
  <summary> generate an order gross profit measure in lookml </summary>

```lookml

# In the products.view.lkml file
measure: total_sales {
  type: sum
  sql: ${sale_price} * ${sale_quantity} ;;
}

# In the order_items.view.lkml file
measure: total_cost {
  type: sum
  sql: ${inventory_items.cost} * ${sale_quantity} ;;
}

# In the orders.view.lkml file
measure: gross_profit {
  type: sum
  sql: ${order_items.total_sales} - ${order_items.total_cost} ;;
}

```
</details>


## SQL
<details>
  <summary> How many users made an order last month? in sql  </summary>
  
```sql
SELECT
  COUNT(*)
FROM users AS T1
INNER JOIN orders AS T2
  ON T1.id = T2.user_id
WHERE
  T2.created_at >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' AND T2.created_at < DATE_TRUNC('month', CURRENT_DATE)
```
</details>

<details>
  <summary> what was the most sold product in 2023? in sql </summary>

```sql
SELECT
  T1.product_id
FROM inventory_items AS T1
INNER JOIN order_items AS T2
  ON T1.id = T2.inventory_item_id
INNER JOIN orders AS T3
  ON T2.order_id = T3.id
WHERE
  T3.created_at >= '2023-01-01' AND T3.created_at < '2024-01-01'
GROUP BY
  T1.product_id
ORDER BY
  SUM(T2.sale_quantity) DESC
LIMIT 1
```
</details>

<details>
  <summary> calculate average delivery time by month in sql </summary>
  
```sql
SELECT
  EXTRACT(YEAR FROM delivered_at) AS year,
  EXTRACT(MONTH FROM delivered_at) AS month,
  AVG(delivered_at - shipped_at) AS avg_delivery_time
FROM order_items
GROUP BY 1, 2
ORDER BY 1, 2
```
</details>
    
<details>
  <summary> output item return rate by customer state in sql </summary>
  
```sql
SELECT
  T1.state AS state,
  CAST(SUM(CASE WHEN T2.status = 'Returned' THEN 1 ELSE 0 END) AS FLOAT) * 100 / COUNT(T2.status) AS return_rate
FROM users AS T1
INNER JOIN orders AS T2
  ON T1.id = T2.user_id
GROUP BY
  T1.state
```
</details>
    
<details>
  <summary> output average order value by customer registration month in sql </summary>
  
```sql
SELECT
  EXTRACT(YEAR FROM created_at) AS registration_year,
  EXTRACT(MONTH FROM created_at) AS registration_month,
  AVG(order_value) AS avg_order_value
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY 1, 2
ORDER BY 1, 2
```
</details>
