#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
END='\033[0m'


if [[ $# -eq 0 ]] ; then
    printf '\nNo Host File or URLs file Given!'
    printf '\n\nUsage: jsscan path-to-urls-file\n\n'
    exit 0
fi

printf "${YELLOW}[+]${END} JSScan started.\n"

mkdir -p Jsscan_results
mkdir -p Jsscan_results/js
mkdir -p Jsscan_results/db

linkf=~/tools/LinkFinder/linkfinder.py
secf=~/tools/SecretFinder/SecretFinder.py

touch subdomains_gau.txt

touch temp.txt
cat $1  >> temp.txt

cat $1 | gau --providers wayback  >> subdomains_gau.txt

#done

cat temp.txt >> subdomains_gau.txt


cat subdomains_gau.txt | sort -u > subdomains_gau1.txt



for i in $(cat subdomains_gau1.txt)
do
        cd Jsscan_results
        n1=$(echo $i | awk -F/ '{print $3}')
        n2=$(echo $i | awk -F/ '{print $1}' | sed 's/.$//')
        mkdir -p js/$n1-$n2
        mkdir -p db/$n1-$n2
        timeout 40 python3 $linkf -d -i $i -o cli > js/$n1-$n2/raw.txt
	#timeout 40 python3 $secf -i $i -e  -g 'jquery;bootstrap;api.google.com' -o cli > js/$n1-$n2/raw1.txt



        jslinks=$(cat js/$n1-$n2/raw.txt | grep -oaEi "https?://[^\"\\'> ]+" | grep '\.js' | grep "$n1" | sort -u)
	#echo $jslinks
        if [[ ! -z $jslinks ]]
        then
                for js in $jslinks
                do
                        python3 $linkf -i $js -o cli >> js/$n1-$n2/js_endpoints.txt
                        echo "$js" >> js/$n1-$n2/jslinks.txt 
			python3 $secf -i $i -e  -g 'jquery;bootstrap;api.google.com' -o cli > js/$n1-$n2/js_secrets.txt
                        #wget $js -P db/$n1-$n2/ -q
                        filename=$(echo $js | awk -F/ '{print $(NF-0)}')
                        curl -L --connect-timeout 10 --max-time 10 --insecure --silent $js | js-beautify - > db/$n1-$n2/$filename 2> /dev/null
                done
        fi
        cd ..
        printf "${GREEN}[+]${END} $i ${YELLOW}done${END}.\n"
done

printf "${YELLOW}[+]${END} Script is done.\n"
printf "\n${YELLOW}[+]${END} Results stored in Jsscan_results.\n"
