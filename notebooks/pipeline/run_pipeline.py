# Databricks notebook source
print("schema stg: staging_" + spark.conf.get("spark.datalake.env"))
print("schema dw: dw_" + spark.conf.get("spark.datalake.env"))

# COMMAND ----------

dbutils.notebook.run("../common/ddl_schemas_and_tables", 300)

# COMMAND ----------

dbutils.notebook.run("../staging/stg_customers", 300)

# COMMAND ----------

dbutils.notebook.run("../dw/dim_customers", 300)

# COMMAND ----------

dbutils.notebook.run("../staging/stg_sales", 300)

# COMMAND ----------

dbutils.notebook.run("../dw/ft_sales", 300,  {"datefrom": "2018-02-01", "dateto": "2018-03-31"})

# COMMAND ----------

dbutils.notebook.run("../dw/agg_sales", 300)

# COMMAND ----------

dbutils.notebook.exit("Data Pipeline finished ok")
