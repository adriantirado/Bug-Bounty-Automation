#!/bin/bash 

domain=$1
mkdir /root/$1
mkdir /root/$1/xray

subfinder -d $1 -silent | anew /root/$1/subs.txt
assetfinder -subs-only $1 | anew /root/$1/subs.txt
amass enum -passive -d $1 | anew /root/$1/subs.txt
                                                                                                                                                                                                             
                                                                                                                                                                                                             
                                                                                                                                                                                                             
cat /root/$1/subs.txt | httpx -silent | anew /root/$1/alive.txt
