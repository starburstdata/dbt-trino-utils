#!/bin/bash

# move to wherever we are so docker things work
cd "$(dirname "${BASH_SOURCE[0]}")"

set -exo pipefail
# run the dim_order_dates model two times in order to test incremental functionality
# Do the same for the the incremental model in custom schema
docker run \
    --network="dbt-net" \
    -v $PWD/dbt:/root/.dbt \
    dbt-trino-utils \
    "cd /opt/dbt_trino_utils/integration_tests/dbt_expectations \
        && dbt deps \
        && dbt seed \
        && dbt run \
        && dbt test"