{% from 'atom/init.sls' import user %}

python3-tk:
  pkg.installed

/etc/templates:
  file.directory

/etc/templates/template.py:
  file.managed:
    - source: salt://tkinter/template.py
    - mode: 744
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - pkg: python3-tk
      - file: /etc/templates
