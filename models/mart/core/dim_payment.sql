with dim_payment as(

    select 
        order_id,
        payment_type,
        payment_installments,
        coalesce(payment_value,0) as payment_value

    from {{ref('olist_order_payments')}}
)
select 
    row_number() over (order by order_id) as payment_key,
            order_id,
            payment_key,
            payment_installments,
            payment_value
from dim_payment