
view: user_order_facts {
  derived_table: {
    sql:
      SELECT
        u.id AS user_id,
        DATE_TRUNC('month', u.created_date) AS registration_month,
        COUNT(o.id) AS total_orders,
        SUM(o.total) AS total_revenue
      FROM
        users u
      LEFT JOIN
        orders o ON u.id = o.user_id
      GROUP BY
        user_id, registration_month
      ;;
  }

  dimension: user_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: registration_month {
    type: date
    sql: ${TABLE}.registration_month ;;
  }

  measure: average_order_value {
    type: number
    sql: ${total_revenue} / NULLIF(${total_orders}, 0) ;;
    value_format_name: "decimal_2"
  }
}
