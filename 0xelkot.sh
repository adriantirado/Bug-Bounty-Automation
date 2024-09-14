#!/bin/bash 

domain=$1
mkdir /root/$1
mkdir /root/$1/xray

subfinder -d $1 -silent | anew /root/$1/subs.txt
assetfinder -subs-only $1 | anew /root/$1/subs.txt
#amass enum -passive -d $1 | anew /root/$1/subs.txt
                                                                                                                                                                                                             
                                                                                                                                                                                                             
                                                                                                                                                                                                             
cat /root/$1/subs.txt | httpx -silent | anew /root/$1/alive.txt              
                                                                                                                                                                                                                                                                                                                                                                                                                      

## test for nuclei 

cat /root/$1/alive.txt |  nuclei -t /home/parrot/cent-nuclei-templates -es info,unknown -etags ssl,network -c 25 | anew /root/$1/nuclei.txt
