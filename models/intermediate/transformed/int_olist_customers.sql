with orders as (

    select
        order_id,
        customer_unique_id,
        order_purchase_at
    from {{ ref('int_olist_orders_enriched') }}

),

financials as (

    select
        order_id,
        total_order_revenue
    from {{ ref('int_order_financials') }}

),

customer_orders as (

    select
        o.customer_unique_id,
        count(distinct o.order_id) as total_orders,
        sum(f.total_order_revenue) as lifetime_revenue,
        min(o.order_purchase_at) as first_order_at,
        max(o.order_purchase_at) as last_order_at

    from orders o
    left join financials f
        on o.order_id = f.order_id
    group by o.customer_unique_id

)

select
    customer_unique_id,
    total_orders,
    lifetime_revenue,
    first_order_at,
    last_order_at,

    case
        when total_orders > 1 then true
        else false
    end as repeat_customer_flag
from customer_orders
