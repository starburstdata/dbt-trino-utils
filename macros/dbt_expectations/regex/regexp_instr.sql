
{% macro trino__regexp_instr(source_value, regexp, position, occurrence, is_raw, flags) %}
regexp_position({{ source_value }}, '{{ regexp }}', {{ position }}, {{ occurrence }})
{% endmacro %}

