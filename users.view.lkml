
# users.view.lkml

view: users {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # ... other dimensions

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;; # Combining first_name and last_name with a space in between
  }
}
