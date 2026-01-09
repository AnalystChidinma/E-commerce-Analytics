with customer_base as (
    select
        customer_unique_id,
        customer_city,
        customer_state
    from {{ ref('stg_olist_customers') }} 
),

customer_behavior as (
    select
        customer_unique_id,
        total_orders,
        lifetime_revenue,
        repeat_customer_flag
    from {{ ref('int_olist_customers') }}
)

select
    b.customer_unique_id,
    b.customer_city,
    b.customer_state,
    coalesce(cb.total_orders, 0) as total_orders,
    coalesce(cb.lifetime_revenue, 0) as lifetime_revenue,
    coalesce(cb.repeat_customer_flag, false) as repeat_customer_flag
from customer_base b
left join customer_behavior cb
    on b.customer_unique_id = cb.customer_unique_id



