with payments as (
    select *
    from {{ref('olist_order_payments')}}
),
aggregated_order_payments as (
    select
        order_id,
        payment_type,
        count(*) as total_payment,
        max(payment_installments) as payment_installments,
        sum(payment_value) as total_payment_value
    from payments
    group by order_id, payment_type
)
select * from aggregated_order_payments