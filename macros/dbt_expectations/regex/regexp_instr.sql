
{% macro trino__regexp_instr(source_value, regexp, position, occurrence, is_raw) %}
regexp_position({{ source_value }}, '{{ regexp }}', {{ position }}, {{ occurrence }})
{% endmacro %}