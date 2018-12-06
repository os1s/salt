git:
  pkg.installed

/etc/gitconfig:
  file.managed:
    - source: salt://git/gitconfig
    - require:
      - pkg: git
