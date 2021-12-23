SELECT 
    {{ dbt_utils.surrogate_key(['customer_id', 'order_date'])}} as id, 
    customer_id,
    order_date
FROM {{ ref('stg_orders') }}

GROUP BY 1, 2, 3