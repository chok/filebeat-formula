{% if salt['grains.get']('os_family') == 'Debian' %}
filebeat_repo:
  pkgrepo.managed:
    - name: deb https://artifacts.elastic.co/packages/7.x/apt stable main
    - file: /etc/apt/sources.list.d/elastic-7.x.list
    - gpgcheck: 1
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - require_in:
      - pkg: filebeat.install
    - watch_in:
      - pkg: filebeat.install

https.install:
  pkg.installed:
    - name: apt-transport-https

{% elif salt['grains.get']('os_family') == 'RedHat' %}
filebeat_repo:
  pkgrepo.managed:
    - name: elk_beats
    - humanname: Elasticsearch repository for 7.x packages
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
    - gpgcheck: 1
    - gpgkey: https://packages.elastic.co/GPG-KEY-elasticsearch
    - require_in:
      - pkg: filebeat.install
    - watch_in:
      - pkg: filebeat.install
{% endif %}

filebeat.install:
  pkg.installed:
    - name: filebeat
