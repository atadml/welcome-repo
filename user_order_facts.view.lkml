view: user_order_facts {
    derived_table: {
    sql:
        SELECT
            o.user_id AS user_id,
            MIN(DATE(o.created_at)) AS first_order_date,
            MAX(DATE(o.created_at)) AS last_order_date,
            COUNT(DISTINCT oi.order_id) AS total_orders,
            SUM(oi.sale_price * oi.sale_quantity) AS total_spent
        FROM
            public.order_items oi
        JOIN public.orders o ON oi.order_id = o.id
        GROUP BY
            o.user_id ;;
    }

    dimension: user_id {
        type: number
        sql: ${TABLE}.user_id ;;
        primary_key: yes
        hidden: yes
    }

    dimension: first_order_date {
        type: date
        sql: ${TABLE}.first_order_date ;;
    }

    dimension: last_order_date {
        type: date
        sql: ${TABLE}.last_order_date ;;
    }

    dimension: total_orders {
        type: number
        sql: ${TABLE}.total_orders ;;
    }

    dimension: total_spent {
        type: number
        sql: ${TABLE}.total_spent ;;
        value_format: "$0.00"
    }

}