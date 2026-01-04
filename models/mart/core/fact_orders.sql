with orders as (

    select *
    from {{ ref('int_olist_orders_enriched') }}

),

items as (

    select *
    from {{ ref('int_olist_order_items') }}

),

payments as (

    select *
    from {{ ref('int_olist_order_payments') }}

)

select
    o.order_id,
    o.customer_id,
    o.customer_unique_id,

    o.order_status,
    o.order_purchase_at,
    o.order_approved_at,
    o.order_delivered_customer_at,
    o.order_estimated_delivery_date,

    coalesce(i.total_items, 0) as total_items,
    coalesce(i.total_item_price, 0) as gross_item_price,
    coalesce(i.total_shipping_price, 0) as shipping_price,
    coalesce(p.total_payment_value, 0) as payment_value,
    coalesce(i.total_item_price, 0) + coalesce(i.total_shipping_price, 0) 
        as order_revenue,

    case
        when o.order_delivered_customer_at is not null
             and o.order_delivered_customer_at
                 <= o.order_estimated_delivery_date
        then true
        else false
    end as delivered_on_time

from orders o
left join items i on o.order_id = i.order_id
left join payments p on o.order_id = p.order_id
