with raw_customers as (

    select
        customer_id,
        customer_unique_id,
        customer_city,
        customer_state
    from {{ source('olist', 'olist_customers') }}

),

stg_olist_customers as (

    select
        customer_id,
        customer_unique_id,
        trim(lower(customer_city)) as customer_city,
        upper(customer_state) as customer_state

    from raw_customers
    where customer_id is not null

)

select *
from stg_olist_customers

