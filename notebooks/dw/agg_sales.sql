-- Databricks notebook source
SET spark.sql.sources.partitionOverwriteMode = STATIC

-- COMMAND ----------

INSERT OVERWRITE TABLE dw_${spark.datalake.env}.agg_sales
select
coalesce(country,'N/A') as country,
sum(amount) as total_amount
from dw_${spark.datalake.env}.ft_sales as ft
left join dw_${spark.datalake.env}.dim_customers dc 
on ft.customerid=dc.customerid 
and to_date(cast(dateid as string),'yyyyMMdd') >= effectivedate 
and to_date(cast(dateid as string),'yyyyMMdd') < coalesce(enddate,'2100-01-01') 
group by 1

-- COMMAND ----------

select * from dw_${spark.datalake.env}.agg_sales
