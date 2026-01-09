with order_payments as (

    select
        order_id,
        payment_amount
    from {{ ref('stg_olist_order_payments') }}

),

order_payments_agg as (

    select
        order_id,
        sum(payment_amount) as total_payment_amount,
        count(*) as payment_count
    from order_payments
    group by order_id

)

select
    order_id,
    total_payment_amount,
    payment_count,
    case
        when payment_count > 1 then true
        else false
    end as payment_flag
from order_payments_agg