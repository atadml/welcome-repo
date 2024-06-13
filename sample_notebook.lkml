
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

# In the users.view.lkml (to be added with the previous measure)
measure: return_rate {
  type: number
  sql: ${IFNULL(${total_items_returned}, 0)} / NULLIF(${total_items_purchased}, 0) ;;
  value_format_name: "percent_2"
}
