python-pip:
  pkg.installed:
    - pkgs:
      - python-pip
      - python3-pip

venv:
  pip.installed:
    - name: virtualenv
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: python-pip
