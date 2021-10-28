#!/bin/sh
#
# Copyleft 2017-21. All WRONGS reserved.
#
packages="traceroute whois curl cowsay fortune-mod lolcat neofetch git gcc g++ vlc terminator steam gparted \
build-essential pluma gimp inkscape p7zip-full p7zip-rar anthy"
printf "\033[0;31m\
+------------------------------------------------------+\n\
|                                                      |\n\
|                  %s                |\n\
|                                                      |\n\
+------------------------------------------------------+\n" "Ubuntu set-up script"
while true; do
    printf "\033[1;97mWould you like to install \033[1;96mChromium\033[1;97m? (Y/N)\033[0m "
    read c
    case $c in
        [Nn]* ) break;;
        [Yy]* ) packages="$packages chromium-browser"; break;;
    esac
done
while true; do
    printf "\033[1;97mWould you like install \033[1;93mPython \033[1;95mstuff\033[1;97m? (Y/N)\033[0m "
    read p
    case $p in
        [Nn]* ) break;;
        [Yy]* ) packages="$packages python3-pip"; break;;
    esac
done
while true; do
    printf "\033[1;97mWould you like install \033[1;92mNode server\033[1;97m? (Y/N)\033[0m "
    read n
    case $n in
        [NYny]* ) break;;
    esac
done
while true; do
    printf "\033[1;97mWould you like install \033[1;95mApache server w/ Flask\033[1;97m? (Y/N)\033[0m "
    read a
    case $a in
        [Nn]* ) break;;
        [Yy]* ) packages="$packages python3-pip apache2 libapache2-mod-wsgi software-properties-common"; break;;
    esac
done
while true; do
    printf "\033[1;97mWould you like install \033[1;94mKDE educational stuff\033[1;97m? (Y/N)\033[0m "
    read k
    case $k in
        [Nn]* ) break;;
        [Yy]* ) packages="$packages kalzium"; break;;
    esac
done
echo
# Disable apport.
sudo chmod 777 /etc/default/apport && \
sudo printf "enabled=0\n" > /etc/default/apport && \
sudo chmod 644 /etc/default/apport && \
# Acquire software from cutting-edge sources.
sudo chmod 777 /etc/apt/sources.list && \
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
sudo printf "\
deb http://archive.ubuntu.com/ubuntu jammy main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu jammy-updates main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu jammy-backports main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu jammy-security main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu jammy-proposed main universe restricted multiverse\n\
deb http://archive.canonical.com/ubuntu jammy partner\n\
deb http://ppa.launchpad.net/canonical-chromium-builds/stage/ubuntu bionic main\n\
deb http://ppa.launchpad.net/videolan/master-daily/ubuntu jammy main\n\
" > /etc/apt/sources.list && \
sudo chmod 664 /etc/apt/sources.list && \
sudo apt-get update && \
sudo apt-get -y dist-upgrade && \
sudo apt-get -y install $packages && \
sudo apt-get -y purge --auto-remove && \
# Install Node v8.
if $(echo $n | grep -q ^[Yy]); then
    curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add - && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 && \
    sudo chmod -R 777 /etc/apt/sources.list.d && \
    sudo echo "deb https://deb.nodesource.com/node_8.x zesty main" > /etc/apt/sources.list.d/nodesource.list && \
    sudo echo "deb-src https://deb.nodesource.com/node_8.x zesty main" > /etc/apt/sources.list.d/nodesource.list && \
    sudo echo "deb [arch=amd64,arm64] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    sudo chmod -R 644 /etc/apt/sources.list.d && \
    sudo chmod 655 /etc/apt/sources.list.d && \
    sudo apt-get update && \
    sudo apt-get -y install nodejs mongodb-org && \
    sudo service mongod start
fi
# Install Python 3 office.
if $(echo $p | grep -q ^[Yy]); then
    sudo apt-get install libgeos-c1v5 libgeos-dev && \
    sudo -H pip3 install --upgrade pip setuptools && \
    sudo -H pip3 install pyqt5 pyqtdatavisualization pyqtchart pyqt3d colorama pyopengl numpy scipy pygments pyyaml pandas matplotlib jupyter roman nltk \
scikit-image scikit-learn twython pywavelets networkx mistune pillow sphinx nose pyttsx3 gmaps pymongo fiona spacy pykakasi kubernetes && \
    sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    sudo jupyter nbextension enable --py --sys-prefix gmaps && \
    sudo -H pip3 install https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz && \
    mkdir -p ~/twitter-files && \
    printf "app_key=\n\
app_secret=\n\
oauth_token=\n\
oauth_token_secret=\
" > ~/twitter-files/credentials.txt && \
    printf '\n#NLTK Twitter API keys.\nexport TWITTER="~/twitter-files"' >> ~/.bashrc && \
    (pluma ~/twitter-files/credentials.txt &)                                                           # Operator precedence
fi
if $(echo $a | grep -q ^[Yy]); then
    sudo -H pip3 install --upgrade pip setuptools && \
    sudo -H pip3 install flask feedparser && \
    sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    sudo chmod -R 777 /etc/apt/sources.list.d && \
    sudo echo "deb [arch=amd64,i386] http://mariadb.nethub.com.hk/repo/10.4/ubuntu eoan main" > /etc/apt/sources.list.d/mariasource.list && \
    sudo chmod -R 644 /etc/apt/sources.list.d && \
    sudo chmod 655 /etc/apt/sources.list.d && \
    sudo apt-get update && \
    sudo apt-get -y install mariadb-server
fi
sudo sed -ie 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=-1/' /etc/default/grub && \
sudo update-grub && \
mkdir .tmp && \
git clone https://github.com/Mikimoto/cowfiles.git .tmp && \
sudo mv .tmp/*.cow /usr/share/cowsay/cows && \
rm -rf .tmp  && \
if ! $(grep -q cowthink ~/.bashrc); then
    printf "\n#Startup message.\nfortune|cowthink -f nyan|lolcat" >> ~/.bashrc
fi
echo
neofetch
# sudo apt-get install libqt5bluetooth5 libqt5clucene5 libqt5concurrent5 libqt5core5a libqt5dbus5 libqt5designer5 libqt5designercomponents5 libqt5gui5 libqt5help5 libqt5location5 libqt5location5-plugins libqt5multimedia5 libqt5multimedia5-plugins libqt5multimediaquick-p5 libqt5multimediawidgets5 libqt5network5 libqt5nfc5 libqt5opengl5 libqt5opengl5-dev libqt5positioning5  libqt5positioning5-plugins libqt5printsupport5 libqt5qml-graphicaleffects libqt5qml5 libqt5quick5  libqt5quickparticles5 libqt5quicktest5 libqt5quickwidgets5 libqt5scintilla2-11 libqt5scintilla2-11-dbg libqt5scintilla2-designer libqt5scintilla2-designer-dbg libqt5scintilla2-dev libqt5scintilla2-l10n libqt5script5 libqt5scripttools5 libqt5sensors5 libqt5sensors5-dev libqt5serialport5 libqt5serialport5-dev libqt5sql5 libqt5sql5-mysql libqt5sql5-sqlite libqt5svg5 libqt5svg5-dev libqt5svg5-private-dev libqt5test5 libqt5webkit5 libqt5webkit5-dbg libqt5webkit5-dev libqt5webkit5-qmlwebkitplugin libqt5widgets5  libqt5x11extras5 libqt5x11extras5-dev libqt5xml5 libqt5xmlpatterns5 libqt5xmlpatterns5-dev libqt5xmlpatterns5-private-dev
# sudo add-apt-repository ppa:moka/daily
# sudo add-apt-repository ppa:numix/ppa
# sudo add-apt-repository ppa:webupd8team/java
# sudo add-apt-repository ppa:canonical-chromium-builds/stage
# sudo add-apt-repository ppa:danielrichter2007/grub-customizer
