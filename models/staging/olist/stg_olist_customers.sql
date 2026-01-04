with source as (

    select *
    from {{ source('olist', 'olist_customers') }}

),

olist_customers_trimmed as (

    select
        customer_id,
        customer_unique_id,
        customer_city,
        customer_state
    from source
    where customer_id is not null

)

select *
from olist_customers_trimmed
