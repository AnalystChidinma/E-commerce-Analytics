with orders as (

    select
        customer_id,
        order_id,
        order_purchase_at
    from {{ ref('stg_olist_orders') }}

),

aggregated_olist_orders as (

    select
        customer_id,
        count(distinct order_id) as total_orders,
        min(order_purchase_at) as first_order_date,
        max(order_purchase_at) as last_order_date
    from orders
    group by customer_id

)

select *
from aggregated_olist_orders



