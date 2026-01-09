with orders as (
    select
        order_id,
        order_delivered_customer_at,
        order_estimated_delivery_date,
        order_status

       from {{ ref('int_olist_orders_enriched') }}
)

select
    order_id,
    order_status,
    order_delivered_customer_at,
    order_estimated_delivery_date,
    
    datediff(day, 
            order_delivered_customer_at, 
            current_date) as delivered_to_customer_days,
    datediff(day, 
            order_delivered_customer_at, 
            order_estimated_delivery_date) as delivery_days,
    
    case
        when order_delivered_customer_at > order_estimated_delivery_date then true
        else false
    end as delivery_delay_flag,
    
    case
        when order_status = 'delivered' then true
        else false
    end as delivered_flag
from orders
