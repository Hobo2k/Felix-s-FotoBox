#!/usr/bin/python

import RPi.GPIO as GPIO, time, os, subprocess
import time

i = 1


# GPIO setup
GPIO.setmode(GPIO.BOARD)
SWITCH1 = 18
GPIO.setup(SWITCH1, GPIO.IN)
SWITCH4 = 16
GPIO.setup(SWITCH4, GPIO.IN)
PRINTIT = 15
GPIO.setup(PRINTIT, GPIO.IN)


while True:
	if (GPIO.input(PRINTIT)==GPIO.LOW):
		print("Jetzt druck gestartet!")
		time.sleep (5)
	if (GPIO.input(SWITCH4)==GPIO.LOW):
		print("Jetzt mach vier Bilder")
		time.sleep (5)
	if (GPIO.input(SWITCH1)==GPIO.LOW):
		print("Jetzt mach ein Bild!")
		time.sleep (5)

