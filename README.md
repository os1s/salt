# Salt miniproject

Installs and configures a few things to my liking
### setup script
```bash
#!/bin/bash

HOSTNAME="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"

sleep 1
wget -O - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sleep 1
echo -e 'deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main'|sudo tee /etc/apt/sources.list.d/saltstack.list
sleep 1
sudo apt-get update
sleep 1
sudo apt-get -y install salt-minion salt-master
sleep 1
echo -e 'master: '$HOSTNAME'\nid: orja'|sudo tee /etc/salt/minion
sleep 1
sudo systemctl restart salt-minion.service
sleep 5
sudo salt-key -A --yes
echo "All done(maybe)"
```

### Atom files

init.sls:

```salt
{% set user = 'xubuntu' %}
{% set configfiles = ['config.cson','styles.less','keymap.cson'] %}

base:
  pkgrepo.managed:
    - humanname: Atom
    - name: deb https://packagecloud.io/AtomEditor/atom/any/ any main
    - file: /etc/apt/sources.list.d/atom.list
    - require_in:
      - pkg: atom
    - key_url: https://packagecloud.io/AtomEditor/atom/gpgkey

  pkg.installed:
    - name: atom

/home/{{ user }}/.atom:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 744

{% for x in configfiles %}
/home/{{ user }}/.atom/{{ x }}:
  file.managed:
    - source: salt://atom/{{ x??}}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 744
    - require:
      - pkg: atom
      - file: /home/{{ user }}/.atom
{% endfor %}

/home/{{ user }}/.atom/packages:
  file.recurse:
    - user: {{ user }}
    - dir_mode: 744
    - file_mode: 744
    - source: salt://atom/packages
    - include_empty: True
```

config.cson:
```
'*':
  'editor':
    'fontSize': 14
    'tabLength': 4
    'tabType': 'hard'
    'showIndentGuide': true
  'welcome':
    'showOnStartup': false
  'core':
    'telemetryConsent': 'no'
```

keymaps.cson:
```
'.platform-win32 atom-text-editor, .platform-linux atom-text-editor':
  'ctrl-d': 'editor:delete-line'

'atom-workspace':
  'shift-q': 'pane:show-previous-item'
  'shift-e': 'pane:show-next-item'
```

styles.less:
```
.status-bar {
  color: red;
  background-color: black;
}
```

### tkinter files

init.sls:
```
{% from 'atom/init.sls' import user %}

python3-tk:
  pkg.installed

/etc/templates:
  file.directory

/etc/templates/template.py:
  file.managed:
    - source: salt://tkinter/template.py
    - mode: 744
    - user: {{ user }}
    - group: {{??user }}
    - require:
      - pkg: python3-tk
      - file: /etc/templates
```

template.py:
```python3
#!/usr/bin/python3

from tkinter import *
import webbrowser as w
import matplotlib as mat

class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    def open_url(self):
        w.open('http://terokarvinen.com/2018/aikataulu--palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to--loppukevat-2018-5p')

    def init_window(self):

        self.master.title('bing bing wahoo')
        self.pack(fill=BOTH, expand=1)

        butt = Button(self, text='kurssisivut', width=10, height=2, command=self.open_url)
        butt.place(x=50, y=50)

        m = Text(self, height=2, width=20)
        m.place(x=15, y=100)
        m.insert(END, 'matplotlib version:\n'+mat.__version__)

top = Tk()
top.geometry('200x300')
app = Window(top)
top.mainloop()
```

### pip files

init.sls:
```
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
    - bin_env: '/usr/bin/pip3'
```

### git files

init.sls:
```
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
```

gitconfig:
```
[user]
    email = a1400239@myy.haaga-helia.fi
    name = Oscar Isomaki
```

