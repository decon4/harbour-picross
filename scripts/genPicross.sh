#!/bin/bash
#
# Picross, a picross/nonogram game for Sailfish
#
# Copyright (C) 2015-2018 Bastien Laine
# Copyright (C) 2019-2022 Matti Viljanen
#
# Picross is free software: you can redistribute it and/or modify it under the terms of the
# GNU General Public License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Picross is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# See the GNU General Public License for more details. You should have received a copy of the GNU
# General Public License along with Picross. If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.
#
# Authors: Bastien Laine, Matti Viljanen
#
FILE="../qml/Levels.js"


echo -n "Title: "
read title

echo -n "HintTitle: "
read hintTitle

echo -n "Dimension: "
read gridSize

dim=$(echo $gridSize | sed 's/[^0-9]*//g')

if [[ $dim == "" ]]
then
    echo "\"$gridSize\" does not contains any number"
    exit 2
fi

if [ $dim -gt 25 ] || [ $dim -lt 3 ]
then
    echo "Please enter grid size between 3 and 25 (included)"
    exit 1
fi

#####################
# Init final string #
#####################
out="
    {\n
           title: qstr(\"$title\"),\n
           hintTitle: qstr(\"$hintTitle\"),\n
           gridSize: $dim,\n
           grid:\n
           [\n"

drawing=""
echo "Everything is fine, please enter the map"
for i in $(seq 1 $dim)
do
    # Read line ( Re-read if size != gridSize or if it contains other characters than 0 or 1)
    echo -n "$i: "
    read line
    while [ $(echo $line | wc -c) -ne $((dim+1)) ]||[ $(echo $line | sed 's/[01io]//g' | wc -c) -ne 1 ]
    do
        if [ $(echo $line | sed 's/[01io]//g' | wc -c) -ne 1 ]
        then
            echo 'Your line can only have 4 characters : 0/o(void) or 1/i(full)'
        else
            echo "Wrong line size ($(echo $line | head -c -1| wc -c)), you must enter a line whose size is $dim"
        fi
        echo -n "$i: "
        read line
    done

    drawing+=$(echo $line | sed "s/0/../g; s/1/##/g")
    drawing+="
"

    # We add comma between every number
    line=$(echo $line | sed 's/i/1/g; s/o/0/g; s/\(.\)/\1, /g' | head -c -2)

    # If last line, remove last comma
    if [ $i -eq $dim ]
    then
        line=$(echo $line | head -c -2)
    fi

    # Line added to out
    out+="                $line\n"
done

# Line closed
out+="            ]\n        }"

# Visual check
clear
echo "Check drawing :"
echo "==============="
echo ""
echo "$drawing"
echo ""
echo ""

# Read difficulty
echo -n "Difficulty [0=Tutorial, 1=Easy, 2=Medium, 3=Hard, 4=Expert, 5=Insane]: "
read difficulty
diff=$(echo $difficulty| sed 's/[^0-9]*//g')
if [[ $diff == "" ]]
then
    echo "\"$difficulty\" does not contains any number"
    exit 2
fi
if [ $diff -gt 5 ] || [ $diff -lt 0 ]
then
    echo "Please enter a number between 0 and 4 (included)"
    exit 1
fi

# Adding comment to find in the file
out+="\n    ]//END$diff"

out=$(echo "$out"| sed "s/\ /\\\ /g; s/\n/\\n/g")

# Get line number where to add a comma next to the }
lineNumber=$(cat $FILE | grep -n "}$" | cut -d ':' -f 1 | head -n $(($diff+1)) | tail -n 1 | head -c -1)

cp $FILE $(echo $FILE).old
cat $FILE | sed "$(echo $lineNumber)s/}/},/; s|\]//END$diff|$(echo $out)|g"> $FILE
#echo "$out"
