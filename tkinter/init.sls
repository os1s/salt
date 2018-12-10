python3-tk:
  pkg.installed

/etc/testfiles:
  file.directory

/etc/testfiles/template.py:
  file.managed:
    - source: salt://tkinter/template.py
    - mode: 644
    - require:
      - pkg: python3-tk
      - file: /etc/testfiles
