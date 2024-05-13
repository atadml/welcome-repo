
explore: order_itemz {
  join: products {
    sql_on: ${order_items.inventory_item_id} = ${products.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: orders {
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: users {
    sql_on: ${orders.user_id} = ${users.id} ;;
    type: inner
    relationship: many_to_one
  }
  
  join: distribution_centers {
    sql_on: ${orders.distribution_center_id} = ${distribution_centers.id} ;;
    type: inner
    relationship: many_to_one
  }
  
}
