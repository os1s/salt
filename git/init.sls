git:
  pkg.installed

/etc/gitconfig:
  file.managed:
    - source: salt://git/gitconfig
    - mode: 640
    - require:
      - pkg: git
