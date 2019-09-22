#!/bin/bash


REDCOLOR='\033[0;31m'

read -p "title: " TITLE
NOW=$(date +"%Y-%m-%d")
RESULT=$NOW'-'$TITLE
printf "creando articulo ${REDCOLOR}$RESULT\n"
mkdir images/$RESULT
FILENAME=$RESULT'.md'
cp template.md _posts/$FILENAME
sed -i "s/TITLE/$TITLE/g" _posts/$FILENAME 
sed -i "s/FOLDER/$RESULT/g" _posts/$FILENAME
