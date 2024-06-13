
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
