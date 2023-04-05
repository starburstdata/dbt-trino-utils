select 
    *
    ,round(order_total - (order_total/2)) as discount_total
from {{ref('trino__fact_orders_source')}}
