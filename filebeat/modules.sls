{% set modules = salt['pillar.get']('filebeat:modules', []) %}

{% if modules|length > 0 %}
filebeat.modules_enable:
  cmd.run:
    - name: filebeat modules enable {{modules|join(" ")}}
{% endif %}
