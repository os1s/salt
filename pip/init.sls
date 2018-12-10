python-pip:
  pkg.installed:
    - pkgs:
      - python-pip
      - python3-pip

pippackages:
  pip.installed:
    - pkgs:
      - virtualenv
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: python-pip     
