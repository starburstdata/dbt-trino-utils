## Contributing

### Adding new macros
The `macros` directory contains a subdirectory for each package that is supported by this package.
Each subdirectory contains a file for each macro that is supported by this package.

### Creating tests
If you are overriding a package macro, you should create a test that ensures that the package macro is called when the dispatch macro is called.
It might be a good idea to just run all the tests that the original package has so that you can ensure compatibility.
The way you do that is by copying the integration tests from the original package into the integration tests directory of this package.
Then you can run the tests locally to ensure that they pass.

### Running tests

If you want to run tests on this package locally you can do so by running the trino and starburst docker compose files. 
Pre-requisites:

- `docker`
- `docker-compose`

or 

- `podman`
- `podman compose` module


```bash
docker-compose -f docker-compose-trino.yml up -d
docker-compose -f docker-compose-starburst.yml up -d
```

Create a `profiles.yml` file with the following contents in `integration_tests/{dbt_project_name}/profiles.yml`:

```yaml
config:
    send_anonymous_usage_stats: False
    use_colors: True

integration_tests:
  target: trino
  outputs:
    trino:
      type: trino
      host: localhost
      port: 8080
      method: none
      user: trino
      catalog: memory
      http_scheme: http
      schema: default
      threads: 1
```

From the `integration_tests/{dbt_project_name}/` directory run:

```bash
dbt run
dbt test
```
