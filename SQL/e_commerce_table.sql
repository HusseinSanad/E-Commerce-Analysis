select od.id,
customer_id,
order_date,
price,
cogs,
payment_method, 
sku_name,
category,
qty_ordered,
ISNULL(before_discount,0) As before_discount,
ISNULL(discount_amount,0) AS discount_amount,
after_discount,
is_gross,
is_valid,
is_net,
case  
            when lower(sd.sku_name) like '%samsung%' then 'Samsung'
            when lower(sd.sku_name) like '%apple%' 
            or   lower(sd.sku_name) like '%iphone%'
            or   lower(sd.sku_name) like '%macbook%' then 'Apple'
            when lower(sd.sku_name) like '%sony%' then 'Sony'
            when lower(sd.sku_name) like '%huawei%' then 'Huawei'
            when lower(sd.sku_name) like '%lenovo%' then 'Lenovo'
            else 'other'

       end as Brand

INTO[db_e_commerce].[dbo].[ecommerce_sales_data]
from staging_order_detail as od
left join staging_payment_detail as pd
on od.payment_id=pd.id
left join staging_sku_detail as sd
on od.sku_id=sd.id
