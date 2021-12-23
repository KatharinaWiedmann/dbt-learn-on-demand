WITH orders AS (
    SELECT * FROM {{ref('stg_orders')}}
), 


daily as (
    SELECT 
        order_date, 
        COUNT(*) as order_num
    FROM orders 
    GROUP BY 1
), 

compared AS (
    SELECT *, lag(order_num) over(order by order_date) as previous_day_order
    FROM daily 
)

SELECT * 
FROM compared