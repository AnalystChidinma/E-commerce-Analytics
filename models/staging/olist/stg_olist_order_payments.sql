with source as (

    select * 
        from {{source ('olist', 'olist_order_payments')}}

),

olist_order_payments_renamed as (
    select
        order_id,
        payment_sequential,
        payment_type,
       cast(payment_installments as integer)  as payment_installments,
        cast(payment_value as numeric (10,2)) as payment_amt
    from source 
    where order_id is not null
)

select * 
    from olist_order_payments_renamed