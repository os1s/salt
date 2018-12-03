python3-pip:
  pkg.installed

pip-packages:
  pip.installed:
    - pkgs:
      - virtualenv
    - require:
      - python3-pip
