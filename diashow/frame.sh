rm files.txt
find /home/felix/fotobox/PB_archive/ -iname PB_\*.jpg > files.txt
shuf -o files_rnd.txt files.txt
fbi -noverbose -a -t 10 -l files_rnd.txt
