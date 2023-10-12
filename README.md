# `trino_utils`

This [dbt](https://github.com/dbt-labs/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Trino or Starburst databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on Trino or Starburst databases

## Compatibility

This package provides "shims" for:
- [dbt_utils](https://github.com/dbt-labs/dbt-utils) (partial)
- [dbt_date](https://github.com/calogica/dbt-date) (partial)


## Usage

Wherever a custom trino macro exists, dbt_utils adapter dispatch will pass to trino_utils. This means you can just do `{{dbt_utils.hash('mycolumnname')}}` just like your friends with Snowflake. 

## Installation Instructions

To make use of these trino adaptations in your dbt project, you must do two things:
1. Install both `trino_utils` and any of the compatible packages listed above by adding them to your `packages.yml`
    ```yaml
    packages:
      - package: dbt-labs/dbt_utils 
        version: {SEE DBT HUB FOR NEWEST VERSION}
      - package: starburstdata/trino_utils
        version: {SEE DBT HUB FOR NEWEST VERSION}
    ```
2. Tell the supported package to also look for the `trino_utils` macros by adding the relevant `dispatches` to your `dbt_project.yml`
    ```yaml
    dispatch:
      - macro_namespace: dbt_utils
        search_order: ['trino_utils', 'dbt_utils']
      - macro_namespace: dbt_date
        search_order: ['trino_utils', 'dbt_date']
      - macro_namespace: metrics
        search_order: ['trino_utils', 'metrics']
    ```
Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.

## Updating dbt-utils submodule

If new version of dbt-utils is released, and you want to use it, update instruction below.
Remember to always point HEAD to certain tag in this submodule, never leave HEAD pointing to any branch.

1. `cd dbt-utils` go to dbt-utils submodule directory
2. `git switch main` switch to main branch
3. `git fetch --tags` fetch tags from dbt-utils remote
4. `git switch 1.0.0 --detach` switch to tag with certain version to which you want upgrade, here 1.0.0 for example
5. `cd ..` go to dbt-trino-utils top directory. Commit, push this change to dbt-trino-utils remote.

## Release process

1. [Create a release](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release) of github repository. Use [semantic versioning](https://semver.org/) to give an appriopiate version number.
Don't try to match [dbt-utils](https://github.com/dbt-labs/dbt-utils/releases) version number, as at some point these versions' numbers won't be equal anyway, that's inevitable. Just follow semantic versioning.
Remember to add appropriate release notes (changelog, contributors).
2. Wait for adding your new release to [dbt Hub](https://hub.getdbt.com/).
It is done automatically by dbt-labs script [Hubcap](https://github.com/dbt-labs/hubcap#hubcap).
Check on [trino_utils package site](https://hub.getdbt.com/starburstdata/trino_utils/latest/) if new version is available. It should happen within one business day.
3. Announce new release on dbt slack, at [db-presto-trino](https://getdbt.slack.com/archives/CNNPBQ24R) channel.

## trino_utils specific macros

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
