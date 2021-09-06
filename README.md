This repo hosts a full data pipeline that shows how to implement CI/CD on Azure DevOps by testing data quality with [great_expectations](https://greatexpectations.io/) and code quality with [SonarQube](https://www.sonarqube.org/)

## Scenario
Let's supose that finance team from ABC Inc. needs to have sales data by customer available for reporting. So, data team needs to ingest and transform customers and sales records coming from transactional databases that run the business.
They've chosen to implement a [Lakehouse](https://databricks.com/blog/2020/01/30/what-is-a-data-lakehouse.html) architecture, that consists of a customers [type 2 SCD dimension](https://en.wikipedia.org/wiki/Slowly_changing_dimension#Type_2:_add_new_row) and a sales [fact table](https://www.kimballgroup.com/2008/11/fact-tables/).

## Repo structure

- **notebooks**: this folder contains the source code that creates and feeds the data model, inside you'll find:

- **common**: functions for schemas creation, variable setting, ecc.

- **staging**: raw data transformations, in this case we are just inserting dummy data.

- **dw**: where staging data is transformed and loaded into tables of the Lakehouse.

- **pipeline**: for running full pipeline.

- **tests**: we are testing data here.

## Prerequisites

### Azure DevOps
 1. Generate a [personal access token](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page) with Full Access permissions.
 2. Have a SonarQube server running and [configure](https://docs.sonarqube.org/latest/analysis/azuredevops-integration/#header-3) it.

### Databricks

1. [Installl](https://docs.databricks.com/libraries/workspace-libraries.html#pypi-libraries) these PyPi libraries: [great_expectations](https://pypi.org/project/great-expectations/) and [nutter](https://github.com/microsoft/nutter)
2. Generate a [personal access token](https://docs.microsoft.com/en-us/azure/databricks/dev-tools/api/latest/authentication#--generate-a-personal-access-token) for using in Azure DevOps.
3. Fork and clone this repo into [Databricks](https://docs.microsoft.com/en-us/azure/databricks/repos#create-a-repo-and-link-it-to-a-remote-git-repository)

## Configuration

1. Add a ***spark.datalake.env*** [spark variable](https://docs.microsoft.com/en-us/azure/databricks/clusters/configure#--spark-configuration) to your cluster. You'll see it used on all SQL queries to manage envs.
2. Run the ***run_pipeline*** notebook to create and populate all tables.
3. Modify value for *projectKey* in ***sonar-project.properties*** to match your configuration.
4. Add ***databricks_host***, ***databricks_repo_id*** and ***databricks_token*** [variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/process/variables) in Azure DevOps.
