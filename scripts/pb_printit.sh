#!/bin/bash


#echo "1" > ~/fotobox/scripts/printit.txt
#echo "~/fotobox/PB_archive/PB_${datum}.jpg" > ~/fotobox/scripts/printfile.txt

#printed =$(cat ~/fotobox/scripts/printit.txt)
#printfile =$(cat ~/fotobox/scripts/printfile.txt)

read printed < ~/fotobox/scripts/printit.txt
read printfile < ~/fotobox/scripts/printfile.txt

echo $printed
echo $printfile

if [ $printed = "1" ]
	then
		lp -d Canon_CP510 $printfile
fi

echo "0" > ~/fotobox/scripts/printit.txt
