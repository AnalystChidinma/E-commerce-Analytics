with payments as (
    select 
        order_id,
        payment_type,
        payment_installments,
        payment_value   
       from {{ref('olist_order_payments')}}
),
aggregated_order_payments as (
    select
        order_id,
        count(distinct payment_type) as payment_type,
        max(payment_installments) as payment_installments,
        sum(payment_value) as payment_value
    from payments
    group by order_id
)
select * from aggregated_order_payments