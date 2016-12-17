#!/bin/bash


cp ~/fotobox/photobooth_images/*.jpg ~/fotobox/photobooth_archive/

mogrify -resize 1976x1336 ~/fotobox/photobooth_images/*.jpg

montage ~/fotobox/photobooth_images/*.jpg ~/fotobox/photobooth_label.jpg -tile 1x2 -geometry +10+10 ~/fotobox/temp_montage4.jpg


datum=$(date +%Y%m%d_%H%M%S)

cp ~/fotobox/temp_montage4.jpg ~/fotobox/PB_archive/PB_${datum}.jpg

rm ~/fotobox/photobooth_images/*.jpg 
rm ~/fotobox/temp*

