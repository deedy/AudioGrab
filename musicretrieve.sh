#!/bin/bash
#!/usr/bin/curl
# 1. Updater. Whenever called again, existing check is performed.
# 2. Database storage in hidden file to store what has been found before.
# 3. ID3 Tag editor
# 4. Naming in format Artist - Track name
# 5. Album art fetcher
# 6. Downloadable by search
# 7. Music genre specifier

url=http://feeds.feedburner.com/itunestop100songsusa
curl $url | sed 's/<[^<]*>//g' | grep -Eo "[[:digit:]]{1,3}\. .*[^\/]" | sed -E 's/&[[:alpha:]]+;/and/g' | sed -E 's/- //g' | sed -E 's/\(.*\)//g' | sed -E 's/\[.*\]//g' | tr -d [:punct:] | sed -E 's/ {1,}/ /g' | tr ' ' '_' | sed -E 's/[[:digit:]]{1,3}_/http:\/\/mp3skull.com\/mp3\//g' | sed 's/[[:space:]]/\.html/g' > $PWD/links.txt

curl $url | sed 's/<[^<]*>//g' | grep -Eo "[[:digit:]]{1,3}\. .*[^\/]" | sed -E 's/[[:digit:]]{1,3}\. //g' | sed -E 's/&[[:alpha:]]+;/and/g' > $PWD/names.txt

x=1;
while read i
do 
j=`curl $i | grep -Eo 'http:\/\/[^(ac)].{1,}\.mp3'  | head -2 | tail -1`
echo $j;
name=`cat names.txt | head -$x | tail -1`
echo $name
wget -O "$name".mp3 $j;
let 'x=x+1'
done < $PWD/links.txt
