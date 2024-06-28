

view: orders {

  # ... existing dimensions and measures ...

  measure: total_sales {
    type: sum
    sql: ${sale_price} * ${sale_quantity} ;;
  }

  measure: total_profit {
    type: sum
    sql: (${sale_price} - ${cost_price}) * ${sale_quantity} ;;
  }

}

