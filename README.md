# Felix's FotoBox
Meine FotoBox für Feierlichkeiten und Spaß

Für die Installation müssen folgende Verzeichnisse im Home (~/) Verzeichnis angelegt werden:
* mkdir ~/fotobox/
* mkdir ~/fotobox/photobooth_images/
* mkdir ~/fotobox/photobooth_archive/
* mkdir ~/fotobox/PB_archive/
* mkdir ~/fotobox/scripts/

Dann kommen die Scripte:
* pb_assemble_and_print.sh
* pb_assemble_and_print_4.sh
* pb_take4pic.py
in den ~/fotobox/scripts/ Ordner.

Nun brauchen wir noch folgende Programme:
> sudo apt-get update
> sudo apt-get upgrade
> sudo apt-get install screen imagemagick

Und natürlich das gphoto:
> wget https://raw.githubusercontent.com/gonzalo/gphoto2-updater/master/gphoto2-updater.sh && chmod +x gphoto2-updater.sh && sudo ./gphoto2-updater.sh



Damit das ganze Automtisch startet füge ich mit `sudo vi /etc/rc.local` (Ich bin ein VI Kind, der Nano geht aber auch ;-) ) in die rc.local folgendes vor dem `exit 0` folgendes ein:
> su - felix -c 'screen -S foto -d -m python ~/fotobox/scripts/pb_take4pic.py'

Statt felix müsst ihr euren PI Usernamen verwenden.
Damit wird eine deattached Screen Session gestartet und mein FotoBox Script direkt gestartet.

Ebenso ist es mit der aktualisierung der Webgallery. Hier müsst ihr mittels
> crontab -e
folgende Zeile einfügen. Dann wird die Gallery alle 5 Minuten neu gebaut.
> */5 * * * *     /home/felix/fotobox/scripts/gallery.sh



Folgende ToDos gibt es noch:
- Drucken mit CUPS auf Photopapier
- Livescreen
