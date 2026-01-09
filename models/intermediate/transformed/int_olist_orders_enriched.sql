with orders as (

    select
        order_id,
        customer_id,
        order_status,
        order_purchase_at,
        order_delivered_customer_at,
        order_estimated_delivery_date
    from {{ ref('stg_olist_orders') }}

),

customers as (

    select
        customer_id,
        customer_unique_id,
        customer_state
    from {{ ref('stg_olist_customers') }}

),

orders_enriched as (

    select
        o.order_id,
        c.customer_unique_id,
        c.customer_state,
        o.order_status,
        o.order_purchase_at,
        o.order_delivered_customer_at,
        o.order_estimated_delivery_date,

        datediff(
            day,
            o.order_purchase_at,
            o.order_delivered_customer_at
        ) as delivery_days,

        case
            when o.order_delivered_customer_at > o.order_estimated_delivery_date
            then datediff(
                day,
                o.order_estimated_delivery_date,
                o.order_delivered_customer_at
            )
            else 0
        end as delivery_delay_days,

        case
            when o.order_delivered_customer_at > o.order_estimated_delivery_date
            then true
            else false
        end as delivered_late

    from orders o
    left join customers c
        on o.customer_id = c.customer_id

)

select *
from orders_enriched


   