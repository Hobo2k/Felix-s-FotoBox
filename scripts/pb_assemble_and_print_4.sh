#!/bin/bash


cp ~/fotobox/photobooth_images/*.jpg ~/fotobox/photobooth_archive/

mogrify -resize 968x648 ~/fotobox/photobooth_images/*.jpg

montage ~/fotobox/photobooth_images/*1.jpg ~/fotobox/photobooth_images/*2.jpg -tile 2x1 -geometry +10+10 ~/fotobox/temp_montage2.jpg
montage ~/fotobox/photobooth_images/*3.jpg ~/fotobox/photobooth_images/*4.jpg -tile 2x1 -geometry +10+10 ~/fotobox/temp_montage3.jpg
montage ~/fotobox/temp_montage2.jpg ~/fotobox/photobooth_label.jpg ~/fotobox/temp_montage3.jpg -tile 1x3 -geometry +0+0 ~/fotobox/temp_montage4.jpg


datum=$(date +%Y%m%d_%H%M%S)

cp ~/fotobox/temp_montage4.jpg ~/fotobox/PB_archive/PB_${datum}.jpg

echo "1" > ~/fotobox/scripts/printit.txt
echo "/home/felix/fotobox/PB_archive/PB_${datum}.jpg" > ~/fotobox/scripts/printfile.txt

rm ~/fotobox/photobooth_images/*.jpg
rm ~/fotobox/temp*

