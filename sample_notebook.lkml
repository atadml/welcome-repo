
# Assuming the existence of a products view with a cost dimension and an orders view with a sale_price dimension.

# products.view.lkml
measure: total_cost {
  type: sum
  sql: ${cost} * ${inventory_items.quantity} ;;
}

# orders.view.lkml
measure: total_revenue {
  type: sum
  sql: ${sale_price} * ${sale_quantity} ;;
}

# In the orders.view.lkml file
measure: gross_profit {
  type: number
  sql: ${total_revenue} - ${products.total_cost} ;;
}
