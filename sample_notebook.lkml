
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
