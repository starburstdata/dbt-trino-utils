{%- macro trino__deduplicate(relation, partition_by, order_by) -%}
    {#
    -- This is a temporary solution until https://github.com/trinodb/trino/issues/14455 is resolved
    -- It leaks the rn column compared to the NATURAL JOIN solution from dbt
    #}
    with row_numbered as (
        select
            _inner.*,
            row_number() over (
                partition by {{ partition_by }}
                order by {{ order_by }}
            ) as rn
        from {{ relation }} as _inner
    )

    select
        distinct row_numbered.*
    from row_numbered where row_numbered.rn = 1

{%- endmacro -%}
