with stg_olist_customers as (
    select * 
    from {{ref('stg_olist_customers')}}
)

select
    customer_unique_id,
    min(customer_id) as customer_id,
    customer_city,
    customer_state
    
from stg_olist_customers
group by
    customer_unique_id,
    customer_city,
    customer_state


