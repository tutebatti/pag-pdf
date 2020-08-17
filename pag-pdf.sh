#!/bin/bash

######################################################
#						     
#	Script to change internal pdf pagination		                            			                             
#	using python script from https://github.com/lovasoa/pagelabels-py                       	                             
#			                             
######################################################

repeat=y

while [ "$repeat" == "y" ]; do

read -e -p "Beginning of new pagination section according to absolute page number of pdf: " secbegin
read -e -p "Optional: different style of pagination; leave empty or type (1) roman lowercase, (2) roman uppercase, (3) letters lowercase, or (4) letters uppercase : " style
if ["$style" == ""]; then style="arabic"; fi
read -e -p "Optional: Add prefix (e.g. fm for frontmatter): " prefix
read -e -p "Optional: different start of pagenumber (e.g. 3 instead of 1): " numbegin
if ["$numbegin" == ""]; then numbegin=1; fi

~/bin/pagelabels-py/addpagelabels.py --startpage "$secbegin" --type "$style" --prefix "$prefix" --firstpagenum "$numbegin" "$1" 

read -e -p "Add/change another section for pagination? (y/n) " repeat

done

echo "Done!"

exit 0
