#!/bin/bash

######################################################
#						     
#	Script to change internal pdf pagination		   
#
# requirement: https://github.com/lovasoa/pagelabels-py must be installed in ~/bin 
# (adapt script if necessary)
# 
#			                             
######################################################

# Checking if file is a pdf file

mtype=$(file --mime-type -b "$1")

if ! echo $mtype | grep -q pdf ; then
	echo "The provided file is not a pdf. Script is aborted."
	exit 0
fi

# Checking if python script is installed

if [ ! -d "~/bin/pagelabels-py" ]; then
  echo "Script "pagelabels-py" by lovasoa is not installed (https://github.com/lovasoa/pagelabels-py). Script is aborted." 
  exit 0
fi

# running actual script

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
