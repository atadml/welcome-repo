
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
  type: number
  sql: ${products.total_sales} - ${order_items.total_cost} ;;
}
