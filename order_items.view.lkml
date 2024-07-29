
view: order_items {
  # Existing dimension and measure definitions

  measure: total_sales {
    type: sum
    sql: ${sale_price} * ${sale_quantity} ;;
  }

  measure: total_items_sold {
    type: sum
    sql: ${sale_quantity} ;;
  }

  measure: total_orders {
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  measure: total_returns {
    type: sum
    sql: CASE WHEN ${returned_at} IS NOT NULL THEN ${sale_quantity} ELSE 0 END ;;
  }

  measure: return_rate {
    type: number
    sql: ${total_returns} / NULLIF(${total_items_sold}, 0) * 100 ;;
    value_format_name: "percent_2"
  }

  measure: average_delivery_time {
    type: average
    sql: DATEDIFF(${delivered_at}, ${shipped_at}) ;;
  }
}
