#!/bin/bash

######################################################
#
#	Script to change internal pdf pagination;
# useful for scanned books or articles
#
# requirement: https://github.com/lovasoa/pagelabels-py must be installed in ~/bin
# (adapt script to custom location if necessary)
#
######################################################

# checking if file is a pdf file

mtype=$(file --mime-type -b "$1")

if ! echo $mtype | grep -q pdf ; then
	echo "The provided file is not a pdf. Script is aborted."
	exit 0
fi

# checking if python script is installed

if [ ! -d "~/bin/pagelabels-py" ]; then
  echo "Script \"pagelabels-py\" by lovasoa is not installed (https://github.com/lovasoa/pagelabels-py). Script is aborted."
  exit 0
fi

# running script

repeat=y

while [ "$repeat" == "y" ]; do

read -ep "Beginning of new pagination section according to absolute page number of pdf: " secbegin

read -ep "Optional: different style of pagination; leave empty or type (1) \"lr\" for lowercase roman numerals (i, ii, etc.), (2) \"ur\" for uppercase roman numerals (I, II, etc.), (3) \"ll\" for lowercase letters (a, b, etc.), or (4) \"ul\" for uppercase letters (A, B, etc.): " style
case "$style" in
	"") style="arabic";;
	"lr") style="roman lowercase";;
	"ur") style="roman uppercase";;
	"ll") style="letter lowercase";;
	"ul") style="letter uppercase";;
esac

read -ep "Optional: add prefix (e.g. \"fm\" for frontmatter): " prefix
read -ep "Optional: different start of pagenumber (e.g. 3 instead of 1): " numbegin
if ["$numbegin" == ""]; then numbegin=1; fi

~/bin/pagelabels-py/addpagelabels.py --startpage "$secbegin" --type "$style" --prefix "$prefix" --firstpagenum "$numbegin" "$1"

read -ep "Add/change another section for pagination? (y/n) " repeat

done

echo "Done!"

exit 0
