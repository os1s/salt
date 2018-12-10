{% from 'atom/init.sls' import user %}

git:
  pkg.installed

/etc/gitconfig:
  file.managed:
    - source: salt://git/gitconfig
    - user: {{ user }}
    - group: {{ user }}
    - mode: 640
    - require:
      - pkg: git
