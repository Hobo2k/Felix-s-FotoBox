#!/usr/bin/python

import RPi.GPIO as GPIO, time, os, subprocess

i = 1


# GPIO setup
GPIO.setmode(GPIO.BCM)
SWITCH1 = 24
GPIO.setup(SWITCH1, GPIO.IN)
SWITCH4 = 25
GPIO.setup(SWITCH4, GPIO.IN)
PRINTIT = 22
GPIO.setup(PRINT, GPIO.IN)


while True:
	if (GPIO.input(SWITCH4)):
		while (i<5):
			def countdown(count):
				while (count >= 0 ):
					print 'The count is: ', count
					count -= 1
					time.sleep (1)
			countdown(9)
			print("ende")

			gpout4 = subprocess.check_output("gphoto2 --capture-image-and-download --filename ~/fotobox/photobooth_images/photobooth_%Y%m%d_%H%M%S_" + str(i) +".jpg", stderr=subprocess.STDOUT, shell=True)
			print(gpout4)
			if "ERROR" not in gpout4: 
				i += 1
		subprocess.call("~/fotobox/scripts/pb_assemble_and_print_4.sh", shell=True)
		print("Bitte warten, Collage wird gedruckt...")

	if (GPIO.input(SWITCH1)):
		def countdown(count):
			while (count >= 0 ):
				print 'The count is: ', count
				count -= 1
				time.sleep (1)
		countdown(9)
		print("ende")
		gpout1 = subprocess.check_output("gphoto2 --capture-image-and-download --filename ~/fotobox/photobooth_images/photobooth_%Y%m%d_%H%M%S_" + str(i) +".jpg", stderr=subprocess.STDOUT, shell=True)
		subprocess.call("~/fotobox/scripts/pb_assemble_and_print.sh", shell=True)
		print(gpout1)
		print("Bitte warten, Photo wird gedruckt...")
	
	i = 1

