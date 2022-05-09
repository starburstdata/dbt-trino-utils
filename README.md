# `dbt-trino-utils`

This [dbt](https://github.com/dbt-labs/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Trino or Starburst databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on Trino or Starburst databases

## Compatibility

This package provides "shims" for:
- [dbt-utils](https://github.com/dbt-labs/dbt-utils) (partial)


## Usage

Wherever a custom trino macro exists, dbt_utils adapter dispatch will pass to trino_utils. This means you can just do `{{dbt_utils.hash('mycolumnname')}}` just like your friends with Snowflake. 

## Installation Instructions

To make use of these trino adaptations in your dbt project, you must do two things:
1. Install both and `trino-utils` and any of the compatible packages listed above by them to your `packages.yml`
    ```yaml
    packages:
      - package: dbt-labs/dbt_utils 
        version: {SEE DBT HUB FOR NEWEST VERSION}
      - package: innoverio/dbt-trino_utils
        version: {SEE DBT HUB FOR NEWEST VERSION}
    ```
2. Tell the supported package to also look for the `trino-utils` macros by adding the relevant `dispatches` to your `dbt_project.yml`
    ```yaml
    dispatch:
      - macro_namespace: dbt_utils
        search_order: ['trino_utils', 'dbt_utils']
    ```
Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.

## trino-utils specific macros

### Cleanup Macros

Some helper macros have been added to simplfy development database cleanup. Usage is as follows:

Drop all schemas for each prefix with the provided prefix list (dev and myschema being a sample prefixes):
```bash
dbt run-operation trino__drop_schemas_by_prefixes --args "{prefixes: ['dev', 'myschema']}"
```

Drop all schemas with the single provided prefix (dev being a sample prefix):
```bash
dbt run-operation trino__drop_schemas_by_prefixes --args "{prefixes: myschema}"
```

Drop a schema with a specific name (myschema_seed being a sample schema name used in the project):
```bash
dbt run-operation trino__drop_schema_by_name --args "{schema_name: myschema_seed}"
```

Drop any models that are no longer included in the project (dependent on the current target):
```bash
dbt run-operation trino__drop_old_relations
```
or for a dry run to preview dropped models:
```bash
dbt run-operation trino__drop_old_relations --args "{dry_run: true}"
```
