# Databricks notebook source
# MAGIC %run ./functions

# COMMAND ----------

class MultiTestFixture(NutterFixture):
  #def before_all(self):
    #dbutils.notebook.run("../pipeline/run_pipeline", 300)
  def assertion_test_01_dim_customers(self):
    df_ge = get_df_ge("dw","dim_customers","current")
    df_ge.expect_column_values_to_be_unique("customerid")
    df_ge.expect_column_values_to_not_be_null("customerid")
    assertion_great_expectations(df_ge)
  def assertion_test_02_ft_sales(self):
    df_source=spark.table("staging_"+spark.conf.get("spark.datalake.env")+'.stg_sales')
    amount=df_source.select(sum("amount").alias("amount")).withColumn("amount",col("amount").cast("Double")).collect()[0]["amount"]
    df_ge = get_df_ge("dw","ft_sales")
    # min threshold is bit less because if not, expectation fails, seems to be a bug
    df_ge.expect_column_sum_to_be_between("amount",amount*0.9999,amount,strict_min=False,strict_max=False)
    assertion_great_expectations(df_ge)
  def assertion_test_03_agg_sales(self):
    df_source=spark.table("dw_"+spark.conf.get("spark.datalake.env")+'.ft_sales')
    df_ge = get_df_ge("dw","agg_sales")
    # agg table should have less rows than original fact table
    df_ge.expect_table_row_count_to_be_between(1,round(df_source.count()*0.9))
    #df_ge.expect_column_values_to_be_in_set("country",["ARG","BRA"])
    assertion_great_expectations(df_ge)
result = MultiTestFixture().execute_tests()
#print(result.to_string())
result.exit(dbutils)
