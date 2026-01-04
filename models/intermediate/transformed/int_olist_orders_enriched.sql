with orders as (
    select *
    from {{ref('stg_olist_orders')}}
),

olist_customers as (
    select * 
    from {{ref('stg_olist_customers')}}
)

select 
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_approved_at,
    o.order_delivered_customer_at,
    o.order_estimated_delivery_date,
    o.order_purchase_at
from orders as o
left join olist_customers as c 
on o.customer_id = c.customer_id

   