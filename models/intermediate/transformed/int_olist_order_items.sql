with order_items as (
            select 
                order_id,
                order_item_id,
                item_price,
                shipping_price
            from {{ref('stg_olist_order_items')}}
),

aggregated_order_items as(
            select 
                order_id,
                count(*) as total_items,
                sum(item_price) as total_item_price,
                sum(shipping_price) as total_shipping_price
            from order_items
            group by order_id
)
select * from aggregated_order_items