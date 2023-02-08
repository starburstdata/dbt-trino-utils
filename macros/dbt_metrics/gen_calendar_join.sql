{% macro trino__gen_calendar_join(group_values) %}
        left join calendar
        {%- if group_values.window is not none %}
            on cast(base_model.{{group_values.timestamp}} as date) > date_add('{{group_values.window.period}}', -{{group_values.window.count}}, calendar.date_day)
            and cast(base_model.{{group_values.timestamp}} as date) <= calendar.date_day
        {%- else %}
            on cast(base_model.{{group_values.timestamp}} as date) = calendar.date_day
        {% endif -%}
{% endmacro %}
