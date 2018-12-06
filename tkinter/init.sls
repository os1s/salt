python3-tk:
  pkg.installed

/etc/testfiles:
  file.directory

/etc/testfiles/testi.py:
  file.managed:
    - source: salt://tkinter/test.py
    - require:
      - pkg: python3-tk
      - file: /etc/testfiles
