-- Databricks notebook source
delete from dw_${spark.datalake.env}.ft_sales 
where dateid between date_format('$datefrom','yyyyMMdd') and date_format('$dateto','yyyyMMdd')

-- COMMAND ----------

INSERT INTO TABLE dw_${spark.datalake.env}.ft_sales
PARTITION (dateid)
select
customerid,
date_format(saledate,'yyyyMMdd') as dateid,
amount,
current_timestamp
from staging_${spark.datalake.env}.stg_sales
where saledate between '$datefrom' and '$dateto'

-- COMMAND ----------

-- select * from ${schema.dw}.ft_sales
