with order_revenue as (

    select
        order_id,
        item_revenue,
        shipping_revenue,
        total_order_revenue
    from {{ ref('int_olist_order_items') }}

),

order_payments as (

    select
        order_id,
        total_payment_amount,
        payment_count,
        payment_flag
    from {{ ref('int_olist_order_payments') }}

),

order_financials as (

    select
        r.order_id,
        r.item_revenue,
        r.shipping_revenue,
        r.total_order_revenue,
        p.total_payment_amount,
        p.payment_count,
        p.payment_flag,

        (p.total_payment_amount - r.total_order_revenue) as payment_revenue_diff,

        case
            when abs(p.total_payment_amount - r.total_order_revenue) > 1
                then true
            else false
        end as payment_mismatch_flag

    from order_revenue r
    left join order_payments p
        on r.order_id = p.order_id

)

select *
from order_financials
