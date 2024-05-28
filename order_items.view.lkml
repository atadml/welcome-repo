
# user_order_facts.view.lkml
measure: total_revenue {
  type: sum
  sql: ${order_items.unit_price} * ${order_items.quantity} ;;
  value_format_name: "usd"
  label: "Total Revenue"
}
