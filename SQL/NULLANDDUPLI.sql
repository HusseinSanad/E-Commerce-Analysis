/* NULL & Duplicate*/
---NULL
---order Detail
select sum(case when od.id is null then 1 else 0 end ) as id_null,
sum(case when od.customer_id is null then 1 else 0 end) as customer_id_null
,sum(case when od.order_date is null then 1 else 0 end) as order_date_null
,sum(case when od.sku_id is null then 1 else 0 end) as sku_id_null,
sum(case when od.price is null then 1 else 0 end) as price_null,
sum(case when od.qty_ordered is null then 1 else 0 end) as qty_ordered_null,
sum(case when od.before_discount is null then 1 else 0 end) as before_discount_nul,
sum(case when od.discount_amount is null then 1 else 0 end) as discount_amount_null,
sum(case when od.after_discount is null then 1 else 0 end) as after_discount_null,
sum(case when od.is_gross is null then 1 else 0 end) as is_gross_null,
sum(case when od.is_gross is null then 1 else 0 end) as is_gross_null,
sum(case when od.is_valid is null then 1 else 0 end) as is_valid_null,
sum(case when od.is_net is null then 1 else 0 end) as is_net_null,
sum(case when od.payment_id is null then 1 else 0 end) as payment_id_null

from staging_order_detail as od 
-----Customer Detail
select sum(case when id is null then 1 else 0 end) as id_null,
sum(case when registered_date is null then 1 else 0 end) as registered_date_null
from staging_customer_detail 
----PaymentDetail
select sum(case when id is null then 1 else 0 end) as id_null,
sum(case when payment_method is null then 1 else 0 end) as payment_method_null
from staging_payment_detail

-----SKUDeatail
select sum(case when id is null then 1 else 0 end) as id_null,
sum(case when sku_name is null then 1 else 0 end) as sku_name_null,
sum(case when base_price is null then 1 else 0 end) as base_price_null,
sum(case when cogs is null then 1 else 0 end) as cogs_null,
sum(case when category is null then 1 else 0 end) as category_null
from staging_sku_detail
