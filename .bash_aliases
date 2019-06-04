alias p='python3 -i -c "import numpy as np;import matplotlib.pyplot as plt"'
alias k=kubectl
alias kgd='k get deploy'
alias kgp='k get pods'
alias kgn='k get nodes'
alias kgs='k get svc'
alias kge='k get events --sort-by=".metadata.creationTimestamp" | tail -8'

export nks='-n kube-system'
export ETCDCTL_API=3
export k8s='https://k8s.io/examples'
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
s(){
python3 -c "from bs4 import BeautifulSoup as b
from urllib.request import urlopen as u
from urllib.parse import quote as q
import json as j
from re import sub, I
ugga=q(' '.join(t[0].upper() + t[1:] for t in '$1'.split()))
v=u(f'https://wikipedia.org/w/api.php?action=query&format=json&prop=langlinks&titles={ugga}&lllang=es&lllimit=100')
h=v.read().decode('utf-8')
parsed=j.loads(h)
es=q(list(parsed['query']['pages'].values())[0]['langlinks'][0]['*'])
v=u(f'https://es.wikipedia.org/wiki/{es}')
h=v.read().decode('utf-8')
soup=b(h,'html.parser')
a=[]
for x in soup.select('#toc')[0].findPreviousSiblings('p'):
    a.insert(0, sub(r'\[(n. |nota )?[0-9]*?\]', '', sub('(?<!c)h', '\'', x.text, flags=I).replace('cue','kwe').replace('cui','kwi').replace('a y', 'ay').replace('e y', 'ey').replace('o y', 'oy').replace('y', 'i').replace('ll', 'y').replace('ge', 'he').replace('Ge', 'He').replace('gi', 'hi').replace('Gi', 'Hi').replace('l a', 'l·a').replace('l e', 'l·e').replace('l o', 'l·o').replace('l i', 'l·i').replace('s u', 's·u').replace('s a', 's·a').replace('s e', 's·e').replace('s o', 's·o').replace('s i', 's·i').replace('s u', 's·u').replace('n a', 'n·a').replace('n e', 'n·e').replace('n i', 'n·i').replace('n o', 'n·o').replace('n u', 'n·u').replace('r a', 'r·a').replace('r e', 'r·e').replace('r i', 'r·i').replace('r o', 'r·o').replace('r u', 'r·u').replace('v', '*b').replace('V','*B').replace('lr', 'lrr').replace('nr', 'nrr').replace(' r', ' rr').replace('ñ', 'ny').replace('ü', 'w').replace('ee', 'ēė').replace('ado', 'ađo').replace('e a', 'ea').replace('a e','ae').replace('s s','ß')).replace('  ', ' ').replace(' se e', ' s\'e'))
print('\n'.join(a))"
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
from subprocess import Popen as p 
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
w=list(d.fromkeys(f(r'(?<= )[\u3041-\u3096\u30a0-\u30ff\u4e00-\u9fff]+',t)))
print(w)
for i in w:
    y = p(['/bin/bash', '-i', '-c', f'j {i}'])
    y.communicate()"
}
d() {
    dig $1
}
