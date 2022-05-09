{% macro trino__datediff(first_date, second_date, datepart) %}

    date_diff(
        '{{ datepart }}',
        {{ first_date }},
        {{ second_date }}
        )

{% endmacro %}
