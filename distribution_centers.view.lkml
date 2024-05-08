view: distribution_centers {
  sql_table_name: public.distribution_centers ;;

  dimension: id {
  primary_key: yes
  type: number
  sql: ${TABLE}.id ;;
  }

  dimension: country {
  type: string
  sql: ${TABLE}.country ;;
  }

  dimension: state {
  type: string
  sql: ${TABLE}.state ;;
  }

  dimension: town {
  type: string
  sql: ${TABLE}.town ;;
  }

  dimension: street {
  type: string
  sql: ${TABLE}.street ;;
  }

  dimension: building {
  type: string
  sql: ${TABLE}.building ;;
  }

  dimension: zip_code {
  type: string
  sql: ${TABLE}.zip_code ;;
  }

  dimension: name {
  type: string
  sql: ${TABLE}.name ;;
  }
  
  measure: count {
    type: count
    drill_fields: [id, name, products.count]
  }
}
