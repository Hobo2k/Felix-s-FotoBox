#!/bin/bash
#
# Simple thumbnail picture gallery script.  With some Imagemagick transformations.
#
# 17/8/14  J McDonnell
#


title=$1
workingdir="/home/felix/fotobox/PB_archive/"

echo "Workingdirektory is: $workingdir"

cd "$workingdir"


if [[ -z $title ]]
then
   echo "Argument missing (title)"
   exit
fi

zipfile="$title.zip"


#
# Process pictures, create thumbnails if necessary
#

ls | egrep "jpg$|jpeg$" | egrep -v 'thumb' |
while read picture
do
   echo Processing file $picture
   thumbpic="thumb_$picture"


   #
   # If no thumnail image exists for picture, create one...
   #
   if [ ! -f "$thumbpic" ]
   then

      # If a txt file exists for picture and is not empty use contents as caption
      # Otherwise place no caption
      if [ -s $picture.txt ]
      then
         pictitle=$(cat $picture.txt)
      else
         pictitle=" "
      fi

      #
      # Uncomment one of the four paragraphs below to achieve different effects.
      # (Only have one paragraph at a time uncommented).
      #


      # Option 1. Simple thumbnails with no effects.
      echo convert "$picture" -resize 10% "$thumbpic"
      convert "$picture" -resize 10% "$thumbpic"


      # Option 2. Put a simple frame around each picture, no caption.
      #echo montage -resize 10% -frame 5 -geometry +0+0 "$picture" "$thumbpic"
      #montage -resize 10% -frame 5 -geometry +0+0 "$picture" "$thumbpic"


      # Option 3. Put a simple frame round each picture with a caption at the bottom (-label)
      #echo montage -resize 10% -pointsize 20 -label "$pictitle" "$picture" -frame 5 -geometry +0+0 "$thumbpic"
      #montage -resize 10% -pointsize 20 -label "$pictitle" "$picture" -frame 5 -geometry +0+0 "$thumbpic"


      # Option 4. Put a "polaroid" effect on each picture, including a caption.  Picture is framed,
      # rotated with shadow.  If $angle is zero there is no rotation.
      # Note: the "-repage" is there to offet the rotated/"polaroided" within its actual
      # (unrotated) frame.  Without -repage, there is clipping where the shared/rotated 
      # image goes beyond the image border.
      #
      #convert -resize 10% $picture png:small.png
      #angle=$(($RANDOM % 20 - 10))
      ##angle=0
      #convert -set caption "$pictitle" small.png -pointsize 28 -background black -polaroid $angle -repage +10+5 png:polaroid.png
      #convert polaroid.png -background white -flatten $thumbpic
     
   fi
done

rm -f polaroid.png small.png


# Create zipfile of all pics
if [ ! -f "$zipfile" ]
then
   zip "$zipfile" $(ls | egrep "jpg$|jpeg$" | grep -v thumb)
fi



###############################################################################
#
# Create index.html file
#

cat > index.html <<%
<html>
<font face=arial size=6>
<h3>$title</h3>
<p>Click on a thumbnail to download the full size image</p><br>
%

ls | egrep "jpg$|jpeg$" | egrep -v 'thumb' |
while read picture
do
   thumbpic="thumb_$picture"

   pictitle=$picture
   if [ -s $picture.txt ]
   then
      pictitle=$(cat $picture.txt)
 
   else
      touch $picture.txt
   fi

   echo "<a href=$picture><img src=$thumbpic alt=$thumbpic title=\"$pictitle\"></a>" >> index.html
done

# Create link to zipfile of all pics
size=$(ls -lh "$zipfile" | awk '{print $5}')
#echo "<br><br><p>Download all pictures -->  <a href=\"$zipfile\">\"$zipfile\"</a> ($size)</p>" >> index.html


echo "<br><br><font face=arial size=2>Updated on $(date).  Run time $SECONDS seconds.<br><br></html>" >> index.html


