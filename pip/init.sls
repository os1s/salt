pip:
  pkg.installed:
    - pkgs:
      - python-pip
      - python3-pip

pip-packages:
  pip.installed:
    - pkgs:
      - virtualenv
      - matplotlib
    - require:
      - pkg: pip
#   - bin_env: '/usr/bin/pip3'
