-- Databricks notebook source
-- this Notebook simulates data that should be coming from an external source and being transformed here

-- COMMAND ----------

truncate table staging_${spark.datalake.env}.stg_customers

-- COMMAND ----------

insert into staging_${spark.datalake.env}.stg_customers
(
  customerid,
  address,
  country,
  effectivedate
)
values
(1, "new address for 1", "ARG", "2018-03-03"),
(3, "current address for 3", "BRA", "2018-04-04"),
(4, "new address for 4", "USA", "2018-04-04");
