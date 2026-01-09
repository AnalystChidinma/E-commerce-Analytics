with order_items as (

    select
        order_id,
        item_price,
        shipping_price
    from {{ ref('stg_olist_order_items') }}

),

order_items_agg as (

    select
        order_id,
        sum(item_price) as item_revenue,
        sum(shipping_price) as shipping_revenue,
        sum(item_price + shipping_price) as total_order_revenue
    from order_items
    group by order_id

)

select *
from order_items_agg
