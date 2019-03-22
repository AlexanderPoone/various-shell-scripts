alias p='python3 -i -c "import numpy as np;import matplotlib.pyplot as plt"'
alias k=kubectl
alias g=/home/constantine/Documents/apache-tinkerpop-gremlin-console-3.4.0/bin/gremlin.sh
alias a='less /home/constantine/Documents/asdf.txt'
alias u='sudo apt-get update; sudo apt-get dist-upgrade; sudo apt-get purge --auto-remove'
alias x='fcitx > /dev/null 2>&1 &'
alias c='git add .; git commit -m "."; git push'
f() {
    OUTPUT=$(python3 -c "from urllib.request import urlopen as u;from bs4 import BeautifulSoup as b;v=u('https://fr.wiktionary.org/wiki/$1');h=v.read().decode('utf-8');soup=b(h,'html.parser');print(soup.select('#mw-content-text > div > ol > li:nth-child(1) > ul > li:nth-child(1)')[0].text)")
    echo $OUTPUT | grep -i $1
    if [[ $(echo $OUTPUT | grep -i $1 | wc -c) -eq 0 ]]; then echo $OUTPUT; fi
    gtts-cli -l fr -o abc.mp3 "$(echo ${OUTPUT} | sed 's/—.*//g')"
    cvlc abc.mp3 --play-and-exit 2> /dev/null
}
j() {
    gtts-cli -l ja -o abc.mp3 "$1"
    python3 -c "from pykakasi import kakasi as ka;k=ka();k.setMode('J','a');conv=k.getConverter();print(conv.do('$1'))"
    cvlc abc.mp3 --play-and-exit 2> /dev/null
}
