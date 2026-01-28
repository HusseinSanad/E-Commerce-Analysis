/*
1. In 2021, in which month was the highest total transaction value (after_discount) recorded?
2. In 2022, which category generated the highest transaction value?
3. Compare transaction values for each category in 2021 and 2022. Identify categories with increased or decreased transaction values from 2021 to 2022.
4. Show the top 5 most popular payment method e I tal abased on total unique orders).
5. Rank the following 5 products by transaction value: Samsung, Apple, Sony, Huawei, and Lenovo.

Note IS Valid= not Canceled or actuall transaction 
*/

---1. In 2021, in which month was the highest total transaction value (after_discount) recorded?--
select month(order_date) as month_num,
sum(after_discount) as total_tranaction
from staging_order_detail
where year(order_date)=2021 and is_valid=1
group by month(order_date)
order by month(order_date) DESC

----Answer : DECEMBER = 180 M Tatal transaction

---2. In 2022, which category generated the highest transaction value?---
select sd.category , sum(od.after_discount) as total_transaction
from staging_order_detail as od 
join staging_sku_detail as sd
on sd.id=od.sku_id
where year(order_date)=2022 and is_valid=1
group by sd.category
order by sum(od.after_discount) DESC
----answer : Mobiles&Tablets
--3. Compare transaction values for each category in 2021 and 2022. 
---Identify categories with increased or decreased transaction values from 2021 to 2022?
---using CTE to compare
with transaction_2021 as (
select sd.category, sum(od.after_discount) as total_transaction_2021
from staging_order_detail as od 
join staging_sku_detail as sd
on sd.id=od.sku_id
where year(od.order_date)=2021 and  od.is_valid=1
group by sd.category
), transaction_2022 as (
select sd.category, sum(od.after_discount) as total_transaction_2022
from staging_order_detail as od 
join staging_sku_detail as sd
on sd.id=od.sku_id
where year(od.order_date)=2022 and  od.is_valid=1
group by sd.category
)
select t1.category,t1.total_transaction_2021,t2.total_transaction_2022,
(t2.total_transaction_2022-t1.total_transaction_2021) as differen_value,
case
     when t2.total_transaction_2022-t1.total_transaction_2021>0 then 'increased'
     else 'decreased'
end as status
from transaction_2021 as t1
join transaction_2022 as t2
on t1.category=t2.category



----4. Show the top 5 most popular payment method used in 2022 (based on total unique orders)----
select top 5 pd.payment_method,
COUNT(distinct od.id) as total_unique_orders
from staging_order_detail as od
join staging_payment_detail as pd 
on od.payment_id=pd.id
where od.is_valid=1 and year(od.order_date)=2022
group by pd.payment_method 
order by count(distinct od.id) DESC
--5. Rank the following 5 products by transaction value: Samsung, Apple, Sony, Huawei, and Lenovo.---
 with product_sales AS (
 select case  
            when lower(sd.sku_name) like '%samsung%' then 'Samsung'
            when lower(sd.sku_name) like '%apple%' 
            or   lower(sd.sku_name) like '%iphone%'
            or   lower(sd.sku_name) like '%macbook%' then 'Apple'
            when lower(sd.sku_name) like '%sony%' then 'Sony'
            when lower(sd.sku_name) like '%huawei%' then 'Huawei'
            when lower(sd.sku_name) like '%lenovo%' then 'Lenovo'
            else 'other'

       end as product_name,
       sum(od.after_discount) as Transaction_value

from staging_order_detail as od
join staging_sku_detail as sd
on od.sku_id=sd.id
where od.is_valid=1
group by case  
            when lower(sd.sku_name) like '%samsung%' then 'Samsung'
            when lower(sd.sku_name) like '%apple%' 
            or   lower(sd.sku_name) like '%iphone%'
            or   lower(sd.sku_name) like '%macbook%' then 'Apple'
            when lower(sd.sku_name) like '%sony%' then 'Sony'
            when lower(sd.sku_name) like '%huawei%' then 'Huawei'
            when lower(sd.sku_name) like '%lenovo%' then 'Lenovo'
            else 'other'
         end 

) 
select * from product_sales
where product_name <> 'other'