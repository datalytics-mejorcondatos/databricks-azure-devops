# Databricks notebook source
from runtime.nutterfixture import NutterFixture, tag

import great_expectations as ge
from json import dumps

from pyspark.sql.functions import *

import builtins
round = getattr(builtins, "round")

# COMMAND ----------

def get_df_ge(schema,table,filter_clause="1=1"):
  df=spark.table(schema+"_"+spark.conf.get("spark.datalake.env")+"."+table).filter(filter_clause)
  df_ge = ge.dataset.SparkDFDataset(df)
  return df_ge

# COMMAND ----------

def assertion_great_expectations(df_ge):
# df_ge.save_expectation_suite("expectations.json")
# run the expectation suite 
  validation_result = df_ge.validate()
  failures = [x for x in validation_result.results if not x.success]
  if len(failures) > 0:
    assert_message = ['\n\n{0:d} expectations out of {1:d} were not met:\n'.format(len(failures), len(failures))]
    for unmet_validation_result in failures:
      assert_message.append("{0:s}\n".format(dumps(unmet_validation_result.to_json_dict(), indent=2)))
    assert False, '\n'.join(assert_message)
  
