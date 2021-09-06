-- Databricks notebook source
MERGE INTO dw_${spark.datalake.env}.dim_customers as customers
USING (
   -- These rows will either UPDATE the current addresses of existing customers or INSERT the new addresses of new customers
  SELECT updates.customerid as mergeKey, updates.*
  FROM staging_${spark.datalake.env}.stg_customers as updates
  
  UNION
  
  -- These rows will INSERT new addresses of existing customers 
  -- Setting the mergeKey to NULL forces these rows to NOT MATCH and be INSERTed.
  SELECT NULL as mergeKey, updates.*
  FROM staging_${spark.datalake.env}.stg_customers updates JOIN dw_${spark.datalake.env}.dim_customers as customers
  ON updates.customerid = customers.customerid 
  WHERE customers.current = true AND (updates.address <> customers.address OR updates.country <> customers.country)
  
) staged_updates
ON customers.customerid = mergeKey
WHEN MATCHED AND customers.current = true AND (customers.address <> staged_updates.address OR customers.country <> staged_updates.country) THEN  
  UPDATE SET current = false, endDate = staged_updates.effectiveDate    -- Set current to false and endDate to source's effective date.
WHEN NOT MATCHED THEN 
  INSERT(customerid, address, country, current, effectivedate, enddate) 
  VALUES(staged_updates.customerId, staged_updates.address, staged_updates.country, true, staged_updates.effectiveDate, null) -- Set current to true along with the new address and its effective date.

-- COMMAND ----------

select * from dw_${spark.datalake.env}.dim_customers
