# Felix's FotoBox
Meine FotoBox für Feierlichkeiten und Spaß

##Installation

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
> */5 * * * *     /home/felix/fotobox/scripts/gallery.sh "FotoBox"


Die Datei `gallery.sh` im Verzeichnis scripts muss auch entsprechend mit dem Usernamen angepasst werden.

Wenn das Bild erstellt ist, kann man es einmal drucken. Wenn ein Neues Bild aufgenommen ist, ist es vorbei.


Nun wird immer das letzte Bild betrachtet. Dazu müsst ihr incron und fbi installieren:
> sudo apt-get install incron fbi
und einen neuen User anlegen:
> useradd -m fotobox
in dessen homeverzeichnis kommen folgende Dateien aus dem scripts Ordner:
* frame.sh
* re_login.sh
und geben die Berechtigung mit
> chmod +x /home/fotobox/re_login.sh
> chmod +x /home/fotobox/frame.sh
> chown fotobox /home/fotobox/re_login.sh /home/fotobox/frame.sh
an den User. Anschließend loggen wir uns als fotobox User ein:
> sudo su - fotobox

Jetzt müssen wir einstellen, dass die Fotoshow beim Login geladen wird.
Dazu fügen wir ans Ende der `.profile` Datei folgende Zeile an:
> /home/fotobox/frame.sh

Nun loggen wir uns als fotobox wieder aus und arbeiten als normaluser weiter.
Dazu muss der User fotobox dann zugriff auf das FrameBufferInterface erhalten und wir führen ein `sudo adduser fotobox video`aus.

Dass der User fotobox automatisch eingeloggt wird, wird in der `/etc/inittab` eingetragen. Dass müssen wir wieder mit sudo machen und tragen die Zeile ein:
> 1:2345:respawn:/bin/login -f fotobox tty1 </dev/tty1 >/dev/tty 2>&1

Dann die User, die incron verwenden dürfen, mittels root/sudo in die Datei `/etc/incron.allow` eintragen. Jeweils ein User pro Zeile.
Anschließend wird mittels `incrontab -e` den Befehl eintragen, dass wenn es eine neue Datei gibt, diese auch hinten angezeigt wird. Bei mir sieht es dann so aus:
> /home/felix/fotobox/PB_archive IN_CREATE sudo /home/fotobox/re_login.sh

Nun einen Reboot durchführen und schauen ob es geht.
Fertig. Wenn jetzt eine neue Datei erstellt wird, wird der fotobox User ausgeloggt, loggt sich automatisch wieder ein und lädt das letzte Bild.



## Folgende ToDos gibt es noch:
- Livescreen
