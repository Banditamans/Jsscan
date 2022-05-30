# JSScan


To install the required tools use
```
bash install.sh
```

The tool uses the following tools

1. [Linkfinder](https://github.com/dark-warlord14/LinkFinder)
2. [SecretFinder](https://github.com/m4ll0k/SecretFinder.git)
3. [Gau](https://github.com/lc/gau) 


Create a file named alive.txt with the domains you need to test. These should be in below format
```
http://example.com
https://example2.com
```

To run the tool use 
```
jsscan path_to_alive.txt

Eg. jsscan alive.txt
```

The tool helps automating the below tasks: 
1. Gather the javascript file links present in a domain
2. Discover the endpoints present in those javascript
3. Then save those javascript files for further static analysis where we can look for hardcoded credentials and stuff

The output of these files are stored in 2 separate folder in which one folder contains all the js files and other folder contains the output from various tools that provide endpoints and hardcoded creds 


