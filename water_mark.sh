#!/bin/bash
# author : Narate Ketram
# created date : 12-1-2014

# water_mark a convert script that using to add watermark on photo

# color
red='\033[31m'
blue='\033[34m'
NC='\033[0m'  # NO COLOR
green='\033[32m'

INDIR=$1
if ! [ $2 ]
then
  OUTDIR=out
else
  OUTDIR=$2
fi

function get_name {
  WATERMARK=$(finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //')
  echo $WATERMARK
}

function set_mark() {
  if [ -d $1 ]
  then
    cd $1
    for f in *.*
    do
      mkdir -p "../$OUTDIR"
      INAME="$f"
      width=`identify -format %w "$INAME"`
      hight=`identify -format %h "$INAME"`
      convert -font Monaco -background none -fill white -gravity\
        east -pointsize 20 -size ${width}x100 caption:"$(get_name) \n$USER $ $(date +%d/%m/%Y)"\
              "$INAME" +swap -gravity south -composite "../$OUTDIR/$INAME"
       echo "Marked ../$OUTDIR/$INAME"
    done
  else
    echo "Directory not exist"
  fi
}

if ! [ $# -gt 0 ]
then
    echo "${red}No arguments${NC}"
    echo "Usage : $0 ${blue}input_dir${NC} ${green}output_dir${NC}"
    exit
fi

set_mark $1
echo "Converted ${blue}$INDIR${NC} directory to ${green}$OUTDIR${NC} directory"
echo "Done"


