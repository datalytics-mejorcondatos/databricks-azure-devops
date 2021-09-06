# Databricks notebook source
# MAGIC %sql
# MAGIC create schema if not exists staging_${spark.datalake.env};
# MAGIC create schema if not exists dw_${spark.datalake.env};
