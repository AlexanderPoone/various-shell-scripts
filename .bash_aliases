alias p='python3 -i -c "import numpy as np;import matplotlib.pyplot as plt"'
alias k=kubectl
alias g=/home/constantine/Documents/apache-tinkerpop-gremlin-console-3.4.0/bin/gremlin.sh
alias a='less /home/constantine/Documents/asdf.txt'
alias u='sudo apt-get update; sudo apt-get -y dist-upgrade; sudo apt-get -y purge --auto-remove'
alias x='fcitx > /dev/null 2>&1 &'
alias c='git add .; git commit -m "."; git push'
f() {
    if [[ -z $(which gtts-cli) ]]; then sudo apt-get update; sudo apt-get -y install python3-gtts; fi
    if [[ -z $(which vlc) ]]; then sudo apt-get update; sudo apt-get -y install vlc; fi
    OUTPUT=$(python3 -c "from urllib.request import urlopen as u, quote as q;from bs4 import BeautifulSoup as b;v=u(f'https://fr.wiktionary.org/wiki/{q(\"$1\")}');h=v.read().decode('utf-8');soup=b(h,'html.parser');print(soup.select('#mw-content-text > div > ol > li:nth-child(1) > ul > li:nth-child(1)')[0].text)")
    echo $OUTPUT | grep -i $1
    if [[ $(echo $OUTPUT | grep -i $1 | wc -c) -eq 0 ]]; then echo $OUTPUT; fi
    gtts-cli -l fr -o abc.mp3 "$(echo ${OUTPUT} | sed 's/—.*//g')"
    cvlc abc.mp3 --play-and-exit 2> /dev/null
}
j() {
    if [[ -z $(which gtts-cli) ]]; then sudo apt-get update; sudo apt-get -y install python3-gtts; fi
    if [[ -z $(which vlc) ]]; then sudo apt-get update; sudo apt-get -y install vlc; fi
    gtts-cli -l ja -o abc.mp3 "$1"
    python3 -c "from pykakasi import kakasi as ka;k=ka();k.setMode('J','a');conv=k.getConverter();print(conv.do('$1'))"
    cvlc abc.mp3 --play-and-exit 2> /dev/null
}
w() {
if [[ -z $(which gtts-cli) ]]; then sudo apt-get update; sudo apt-get -y install python3-gtts; fi
if [[ -z $(which vlc) ]]; then sudo apt-get update; sudo apt-get -y install vlc; fi
python3 -c "import bs4" 2> /dev/null
if [[ $? -eq 1 ]]; then sudo apt-get update; sudo apt-get -y install python3-bs4; fi
python3 -c "from urllib.request import urlopen as u
from bs4 import BeautifulSoup as b
from re import findall as f
from collections import OrderedDict as d
v=u('https://en.wiktionary.org/wiki/$1')
h=v.read().decode('utf-8')
soup=b(h,'html.parser')
t=''
for i in soup.select('div.NavHead'):
    if i.next_sibling != None and i.next_sibling.next_sibling != None:
        tmp=i.next_sibling.next_sibling.text
        for x in tmp.split('\n'):
            if x.startswith('Jap'):
                t += f'{i.text}\n{x}\n'
print(t)
print(list(d.fromkeys(f(r'(?<= )[\u3041-\u3096\u30a0-\u30ff\u4e00-\u9fff]+',t))))"
}
