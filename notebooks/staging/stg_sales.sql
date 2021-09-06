-- Databricks notebook source
-- this Notebook simulates data that should be coming from an external source and being transformed here

-- COMMAND ----------

truncate table staging_${spark.datalake.env}.stg_sales

-- COMMAND ----------

insert into staging_${spark.datalake.env}.stg_sales
(
  customerid,
  saledate,
  amount
)
values
(1, "2018-02-03", 100.5),
(2, "2018-02-03", 20.75),
(1, "2018-03-03", 120.5),
(3, "2018-03-03", 200.1),
(4, "2018-03-03", 155),
(5, "2018-03-03", 10)
;
