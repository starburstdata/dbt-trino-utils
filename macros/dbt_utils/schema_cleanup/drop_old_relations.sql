-- based on the sqlserver_utils package

{% macro trino__drop_old_relations(dry_run='false') %}
    {% if execute %}
        {% set current_models = [] %}
        {% for node in graph.nodes.values()|selectattr("resource_type", "in", ["model", "seed", "snapshot"])%}
            {% do current_models.append(node.name) %}
        {% endfor %}
    {% endif %}
    {% set cleanup_query %}
        with models_to_drop as (
            select
            case 
                when table_type = 'BASE TABLE' then 'TABLE'
                when table_type = 'VIEW' then 'VIEW'
            end as relation_type,
            CASE 
                WHEN table_type = 'VIEW' THEN concat_ws('.', table_schema, table_name) 
                    ELSE concat_ws('.', table_catalog, table_schema, table_name) 
                END as relation_name
            from
                "{{ target.database }}".information_schema.tables -- Added quotes for any whitespace in target db
            where
                table_schema like '{{ target.schema }}%'
                and table_name not in (
                    {%- for model in current_models -%}
                        '{{ model }}'
                        {%- if not loop.last -%}
                            ,
                        {% endif %}
                    {%- endfor -%})
                )
        select 
            CONCAT( 'drop ' , relation_type , ' ' , relation_name , ';' ) as drop_commands
        from 
            models_to_drop
        where
            CONCAT( 'drop ' , relation_type , ' ' , relation_name , ';' ) is not null
    {% endset %}

    {% do log(cleanup_query, info=True) %}
    {% set drop_commands = run_query(cleanup_query).columns[0].values() %}

    {% do log('dry_run: ' + dry_run|string, info=True) %}

    {% if drop_commands %}
        {% for drop_command in drop_commands %}
            {% do log(drop_command, info=True) %}
            {% if dry_run == 'false' %}
                {% do run_query(drop_command) %}
            {% endif %}
        {% endfor %}
    {% else %}
        {% do log('No relations to clean.', info=True) %}
    {% endif %}
{%- endmacro -%}