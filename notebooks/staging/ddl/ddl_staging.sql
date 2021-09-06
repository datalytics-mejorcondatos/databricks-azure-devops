-- Databricks notebook source
create or replace table staging_${spark.datalake.env}.stg_customers
(
  customerid integer NOT NULL,
  address string,
  country string,
  effectivedate date
)
USING DELTA
LOCATION '${spark.datalake.path}/staging_${spark.datalake.env}/stg_customers'

-- COMMAND ----------

create or replace table staging_${spark.datalake.env}.stg_sales
(
  customerid integer,
  saledate date,
  amount decimal(10,2)
)
USING DELTA
LOCATION '${spark.datalake.path}/staging_${spark.datalake.env}/stg_sales'
