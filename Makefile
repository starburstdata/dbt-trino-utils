dbt-trino-tests:
	docker network create dbt-net || true
	./docker/dbt/build.sh
	./docker/init_trino.bash
	./docker/run_dbt_utils_integration_tests.bash
	./docker/run_dbt_date_integration_tests.bash
	./docker/run_dbt_metrics_integration_tests.bash
	./docker/run_dbt_expectations_integration_tests.bash
	./docker/remove_trino.bash

dbt-starburst-tests:
	docker network create dbt-net || true
	./docker/dbt/build.sh
	./docker/init_starburst.bash
	./docker/run_dbt_utils_integration_tests.bash
	./docker/run_dbt_date_integration_tests.bash
	./docker/run_dbt_metrics_integration_tests.bash
	./docker/run_dbt_expectations_integration_tests.bash
	./docker/remove_starburst.bash
