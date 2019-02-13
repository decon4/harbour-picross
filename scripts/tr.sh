#!/bin/bash

for i in $(ls ../translations/harbour-picross2-*.ts)
do
   let ALL=$(grep "<message>" $i | wc -l)
   let DONE=$ALL-$(grep "type=\"unfinished\"" $i | wc -l)
   echo -e "$i\t$DONE/$ALL"
done
#UNFINISHED=$(cat ../translations/harbour-picross2-es.ts | grep "type=\"unfinished\"" | wc -l)
#FINISHED=$(cat ../translations/harbour-picross2-es.ts | grep "<message>" | wc -l)
#echo "Spanish: $UNFINISHED/$FINISHED"
