{%- macro trino__convert_timezone(column, target_tz, source_tz=None) -%}
{{ column }} at time zone '{{ target_tz }}'
{%- endmacro -%}
