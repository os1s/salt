{% set user = 'testaaja' %}
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

/home/{{ user }}/.atom:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 744

{% for x in configfiles %}
/home/{{ user }}/.atom/{{ x }}:
  file.managed:
    - source: salt://atom/{{ x }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - require:
      - pkg: atom
      - file: /home/{{ user }}/.atom
{% endfor %}

/home/{{ user }}/.atom/packages:
  file.recurse:
    - user: {{ user }}
    - dir_mode: 744
    - file_mode: 744
    - source: salt://atom/packages
    - include_empty: True
