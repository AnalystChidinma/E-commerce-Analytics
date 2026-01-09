with raw_order_items as (

    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    from {{ source('olist', 'olist_order_items') }}

),

stg_olist_order_items as (

    select
        order_id,
        order_item_id,
        product_id,
        seller_id,

        cast(shipping_limit_date as timestamp) as shipping_limit_at,
        cast(price as numeric(12,2)) as item_price,
        cast(freight_value as numeric(12,2)) as shipping_price

    from raw_order_items
    where order_id is not null

)

select *
from stg_olist_order_items
