base:
  pkgrepo.managed:
    - humanname: Atom
    - name: deb https://packagecloud.io/AtomEditor/atom/any/ any main
    - file: /etc/apt/sources.list.d/atom.list
    - require_in:
      - pkg: atom
    - key_url: https://packagecloud.io/AtomEditor/atom/gpgkey

  pkg.latest:
    - name: atom
    - refresh: True

/etc/atomconfig666:
  file.recurse:
    - source: salt://atom/atomconfig
    - file_mode: 750

'export ATOM_HOME=/etc/atomconfig666':
  cmd.run
