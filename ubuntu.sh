#!/bin/sh
#
# Copyleft 2017.
#
packages="traceroute whois curl cowsay fortune-mod lolcat neofetch git gcc g++ vlc terminator steam gparted build-essential"
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
deb http://archive.ubuntu.com/ubuntu artful main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu artful-updates main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu artful-backports main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu artful-security main universe restricted multiverse\n\
deb http://archive.ubuntu.com/ubuntu artful-proposed main universe restricted multiverse\n\
deb http://archive.canonical.com/ubuntu artful partner\n\
deb http://ppa.launchpad.net/canonical-chromium-builds/stage/ubuntu artful main\n\
deb http://ppa.launchpad.net/videolan/master-daily/ubuntu artful main\n\
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
    sudo echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    sudo chmod -R 644 /etc/apt/sources.list.d && \
    sudo chmod 655 /etc/apt/sources.list.d && \
    sudo apt-get update && \
    sudo apt-get -y install nodejs mongodb-org && \
    sudo service mongod start
fi
# Install Python 3 office.
if $(echo $p | grep -q ^[Yy]); then
    sudo apt-get install libgeos-c1v5 libgeos-dev && \
    sudo -H pip3 install pyqt5 pyopengl numpy scipy pygments pyyaml pandas matplotlib jupyter roman nltk scikit-image scikit-learn Pillow sphinx nose pyttsx3 gmaps && \
    sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    sudo jupyter nbextension enable --py --sys-prefix gmaps && \
    sudo -H pip3 install https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz
fi
sudo sed -ie 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=-1/' /etc/default/grub && \
mkdir .tmp && \
git clone https://github.com/Mikimoto/cowfiles.git .tmp && \
sudo mv .tmp/*.cow /usr/share/cowsay/cows && \
rm -rf .tmp  && \
if ! $(grep -q cowthink ~/.bashrc); then
    printf "\n#Startup message.\nfortune|cowthink -f nyan|lolcat" >> ~/.bashrc
fi
echo
neofetch

