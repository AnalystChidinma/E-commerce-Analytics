with orders as (

    select
        order_id,
        customer_unique_id,
        customer_state,
        order_status,
        order_purchase_at,
        order_delivered_customer_at,
        order_estimated_delivery_date

    from {{ ref('int_olist_orders_enriched') }}

),

revenue as (

    select
        order_id,
        item_revenue,
        shipping_revenue,
        total_order_revenue
    from {{ ref('int_olist_order_items') }}

),

payments as (

    select
        order_id,
        total_payment_amount,
        payment_count,
        payment_flag
    from {{ ref('int_olist_order_payments') }}

)

select
    o.order_id,
    o.customer_unique_id,
    o.order_status,
    o.order_purchase_at,
    o.order_delivered_customer_at,
    o.order_estimated_delivery_date,
    
    r.item_revenue,
    r.shipping_revenue,
    r.total_order_revenue,
    
    p.total_payment_amount,
    p.payment_count,
    p.payment_flag,
    
    (p.total_payment_amount - r.total_order_revenue) as payment_revenue_diff,
    case
        when abs(p.total_payment_amount - r.total_order_revenue) > 1 then true
        else false
    end as payment_mismatch_flag,
    
    datediff(day, o.order_purchase_at, o.order_delivered_customer_at) as delivery_duration_days,
    case
        when o.order_delivered_customer_at > o.order_estimated_delivery_date then true
        else false
    end as delivery_delay_flag

from orders o
left join revenue r
    on o.order_id = r.order_id
left join payments p
    on o.order_id = p.order_id
