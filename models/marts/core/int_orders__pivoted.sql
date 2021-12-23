        {% set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card' ] %}


with payments as (
    SELECT * FROM {{ref ('stg_payments') }}
), 

pivoted as (
    SELECT 
        order_id, 
        {% for payment_method in payment_methods -%}
        sum(case when payment_method= '{{payment_method}}' then amount else 0 end) as {{payment_method}}_amount
        {%- if not loop.last -%} , {% endif %}

        {% endfor -%}

    FROM payments 
    where status = 'success'
    group by 1
)

SELECT * 
FROM pivoted 