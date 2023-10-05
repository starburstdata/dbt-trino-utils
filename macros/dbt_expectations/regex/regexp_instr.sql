{% macro trino__regexp_instr(source_value, regexp, position=1, occurrence=1, is_raw=False, flags="") %}
{% if flags %}
    {{ exceptions.warn(
            "flags option is not supported for this adapter "
            ~ "and is being ignored."
    ) }}
{% endif %}
{% if is_raw %}
    {{ exceptions.warn(
            "is_raw option is not supported for this adapter "
            ~ "and is being ignored."
    ) }}
{% endif %}
regexp_position({{ source_value }}, '{{ regexp }}', {{ position }}, {{ occurrence }})
{% endmacro %}
