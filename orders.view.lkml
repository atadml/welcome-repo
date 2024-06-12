
view: orders {
  sql_table_name: orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: order_date {
    type: date
    sql: ${TABLE}.order_date ;;
  }

  measure: count {
    type: count
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.total_amount ;;
    value_format_name: "usd"
  }

  measure: average_order_value {
    type: average
    sql: ${total_revenue} / NULLIF(${count}, 0) ;;
    value_format_name: "usd"
  }
  
  # Other measures...

  include: [user_order_facts.measure*]  # Including measures from the user_order_facts view
}
