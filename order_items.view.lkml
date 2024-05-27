
view: user_order_facts {
  measure: count {
    type: count
  }

  measure: total_revenue {
    type: sum
    sql: ${products.sale_price} * ${order_items.quantity} ;;
    value_format_name: "usd"
  }

  measure: average_order_value {
    type: average
    sql: ${total_revenue} / NULLIF(${count}, 0) ;;
    value_format_name: "usd"
  }
  
  measure: retention_rate {
    type: number
    sql: COUNT_DISTINCT(CASE WHEN ${order_items.created_date} < DATE_ADD(CURRENT_DATE(), INTERVAL -30 DAY) THEN ${order_items.user_id} END) / NULLIF(COUNT_DISTINCT(CASE WHEN ${order_items.created_date} >= DATE_ADD(CURRENT_DATE(), INTERVAL -30 DAY) THEN ${order_items.user_id} END), 0) ;;
    value_format_name: "percent_2"
  }
  
  # Other measures...

}
