{% macro trino__limit_zero() %}
  {{ return('where 0=1') }} 
{% endmacro %}