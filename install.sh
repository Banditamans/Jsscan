#!/bin/bash

sudo apt install wget -y

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
 

if [[ ! -d ~/tools/gau ]]
then
        
        wget https://github.com/lc/gau/releases/download/v2.1.1/gau_2.1.1_linux_amd64.tar.gz && tar xvf gau_2.1.1_linux_amd64.tar.gz
        sudo cp gau /usr/bin/gau
else
        printf "gau already present in tools folder!\n\n"
fi





cd LinkFinder

sudo pip3 install -r requirements.txt
sudo python3 setup.py install
pip install jsbeautifier
sed -i 's/ssl.PROTOCOL_TLSv1_2/ssl.PROTOCOL_TLSv1_3/g' linkfinder.py
sed -i 's/ssl.PROTOCOL_TLSv1/ssl.PROTOCOL_TLSv1_2/g' linkfinder.py

cd ..

cd SecretFinder
sudo pip3 install -r requirements.txt


echo "alias jsscan='$cwd/script.sh'" >> ~/.bash_profile

. ~/.bash_profile

echo "All set bro, restart your terminal!"
