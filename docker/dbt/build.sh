#!/bin/bash

docker build . -f docker/dbt/Dockerfile -t dbt-trino-utils
