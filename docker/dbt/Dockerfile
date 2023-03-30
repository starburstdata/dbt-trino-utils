FROM python:3.9.9-slim-bullseye
USER root

ENV DBT_DIR /opt/dbt_trino_utils

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    netcat curl git ssh software-properties-common \
    make build-essential ca-certificates libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/
RUN pip3 install --upgrade pip
RUN mkdir ${DBT_DIR}
RUN pip install 'dbt-trino~=1.4.0'
ADD . ${DBT_DIR}
ADD docker/dbt/profiles.yml /root/.dbt/profiles.yml

WORKDIR /usr/app

ENTRYPOINT ["/bin/sh", "-c"]
