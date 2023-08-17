{% macro trino__recursive_dag() %}
{#-- Although Trino supports a recursive WITH-queries,
-- it is less performant than creating CTEs with loops and unioning them
-- (549 vs 311 stages in the query if max_depth_dag = 9) --#}
    {{ return(bigquery__recursive_dag()) }}
{% endmacro %}
