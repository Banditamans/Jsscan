#!/bin/bash

cwd=$(pwd)

mkdir -p ~/tools
cd ~/tools

if [[ ! -d ~/tools/LinkFinder ]]
then
        git clone https://github.com/dark-warlord14/LinkFinder
else
        printf "LinkFinder already present in tools folder...!\n\n"
fi

if [[ ! -d ~/tools/SecretFinder ]]
then
        git clone https://github.com/m4ll0k/SecretFinder.git
else
        printf "SecretFinder already present in tools folder...!\n\n"
fi


sudo apt install wget -y

cd LinkFinder

sudo pip3 install -r requirements.txt
sudo python3 setup.py install
pip install jsbeautifier

cd secretfinder
sudo pip3 install -r requirements.txt


echo "alias jsscan='$cwd/script.sh'" >> ~/.bash_profile

. ~/.bash_profile

echo "All set bro, restart your terminal!"
