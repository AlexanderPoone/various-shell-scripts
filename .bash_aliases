alias p='python3 -i -c "import numpy as np;import matplotlib.pyplot as plt"'
alias k=kubectl
alias g=/home/constantine/Documents/apache-tinkerpop-gremlin-console-3.4.0/bin/gremlin.sh
alias a='less /home/constantine/Documents/asdf.txt'
alias u='sudo apt-get update; sudo apt-get dist-upgrade; sudo apt-get purge --auto-remove'
alias x='fcitx > /dev/null 2>&1 &'
alias c='git add .; git commit -m "."; git push'
f() {
    gtts-cli -l fr -o abc.mp3 "$1"
    cvlc abc.mp3 --play-and-exit
}
j() {
    gtts-cli -l ja -o abc.mp3 "$1"
    cvlc abc.mp3 --play-and-exit
}
