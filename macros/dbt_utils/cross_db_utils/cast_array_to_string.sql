{% macro trino__cast_array_to_string(array) %}
    '['||(select array_join({{ array }}, ',', ''))||']'
{% endmacro %}
