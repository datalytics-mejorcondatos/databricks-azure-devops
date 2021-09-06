-- Databricks notebook source
create or replace table dw_${spark.datalake.env}.dim_customers
(
  customerid integer NOT NULL,
  address string,
  country string,
  current boolean, 
  effectivedate date, 
  enddate date
)
USING DELTA
LOCATION '${spark.datalake.path}/dw_${spark.datalake.env}/dim_customers'

-- COMMAND ----------

insert into dw_${spark.datalake.env}.dim_customers
(
  customerid,
  address,
  country,
  current, 
  effectivedate, 
  enddate
)
values
(1, "old address for 1", "ARG", false, null, "2018-02-01"),
(1, "current address for 1", "JPN", true, "2018-02-01", null),
(2, "current address for 2", "USA", true, "2018-02-01", null),
(3, "current address for 3", "RUS", true, "2018-02-01", null)
;

-- COMMAND ----------

create or replace table dw_${spark.datalake.env}.ft_sales
(
  customerid integer,
  dateid integer,
  amount decimal(10,2),
  insert_date timestamp
)
USING DELTA
PARTITIONED BY (dateid)
LOCATION '${spark.datalake.path}/dw_${spark.datalake.env}/ft_sales'

-- COMMAND ----------

create or replace table dw_${spark.datalake.env}.agg_sales
(
  country string,
  total_amount decimal(10,2)
)
USING DELTA
PARTITIONED BY (country)
LOCATION '${spark.datalake.path}/dw_${spark.datalake.env}/agg_sales'
