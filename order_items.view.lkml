
view: order_items {
  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: total_cost_price {
    type: sum
    sql: ${inventory_items.cost} ;; # Assuming cost is the name of the inventory_items view and the cost measure
  }

  measure: total_quantity_sold {
    type: sum
    sql: ${sale_quantity} ;;
  }

  measure: gross_profit {
    type: sum
    sql: (${sale_price} - ${inventory_items.cost}) * ${sale_quantity} ;; # Assuming cost is the name of the inventory_items view and the cost measure
  }

  measure: profit_margin {
    type: number
    sql: ${gross_profit} / NULLIF(${total_sale_price},0) * 100 ;;
  }

  # Assuming there is a products view that contains the product name and category information
  dimension: product_name {
    type: string
    sql: ${products.name} ;;
  }

  dimension: product_category {
    type: string
    sql: ${products.category} ;;
  }
}
