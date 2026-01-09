with raw_order_payments as (

    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value
    from {{ source('olist', 'olist_order_payments') }}

),

stg_olist_order_payments as (

    select
        order_id,
        payment_sequential,
        payment_type,

        cast(payment_installments as integer) as payment_installments,
        cast(payment_value as numeric(12,2)) as payment_amount

    from raw_order_payments
    where order_id is not null

)

select *
from stg_olist_order_payments
