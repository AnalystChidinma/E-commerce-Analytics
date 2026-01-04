with orders as (
    select * 
    from {{ref('stg_olist_orders')}}
),
dim_date as (
    select distinct cast (o.order_purchase_at as date) as order_date,
                    extract (year from o.order_purchase_at) as year,
                    extract(month from o.order_purchase_at) as month,
                    extract (day from o.order_purchase_at) as day,
                    extract (quarter from o.order_purchase_at) as quarter,
                    extract (doy from o.order_purchase_at) as day_of_year,
                    extract (week from o.order_purchase_at) as week_of_year
    from orders as o
)
select row_number () over (order by order_date) as date_key,
        order_date,
        day,
        month,
        quarter,
        year,
        day_of_year,
        week_of_year
    
from dim_date