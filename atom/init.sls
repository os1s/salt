{% set user = 'osku' %}
{% set configfiles = ['config.cson','styles.less','keymap.cson'] %}

base:
  pkgrepo.managed:
    - humanname: Atom
    - name: deb https://packagecloud.io/AtomEditor/atom/any/ any main
    - file: /etc/apt/sources.list.d/atom.list
    - require_in:
      - pkg: atom
    - key_url: https://packagecloud.io/AtomEditor/atom/gpgkey

  pkg.installed:
    - name: atom

{% for x in configfiles %}
/home/{{ user }}/.atom/{{ x }}:
  file.managed:
    - source: salt://atom/{{ x }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
{% endfor %}
