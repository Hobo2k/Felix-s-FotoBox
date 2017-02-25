#!/usr/bin/python

import RPi.GPIO as GPIO, time, os, subprocess

i = 1


# GPIO setup
GPIO.setmode(GPIO.BOARD)
SWITCH1 = 18
GPIO.setup(SWITCH1, GPIO.IN)
SWITCH4 = 16
GPIO.setup(SWITCH4, GPIO.IN)
PRINTIT = 15
GPIO.setup(PRINTIT, GPIO.IN)

LED1 = 35	# A
LED2 = 33	# B
LED4 = 31	# C
LED8 = 29	# D
LEDAUS = 37	# BI

GPIO.setup(LED1, GPIO.OUT)
GPIO.setup(LED2, GPIO.OUT)
GPIO.setup(LED4, GPIO.OUT)
GPIO.setup(LED8, GPIO.OUT)
GPIO.setup(LEDAUS, GPIO.OUT)


#LED Matrix  -  der Dezimalpunkt ist noch nicht implementiert
#(a,b,c,d,e,f,g)
# 1 = b,c           = BI A
# 2 = a,b,d,e,g     = BI B
# 3 = a,b,c,d,g     = BI A,B
# 4 = b,c,f,g       = BI C
# 5 = a,c,d,f,g     = BI A,C
# 6 = c,d,e,f,g     = BI B,C
# 7 = a,b,c         = BI A,B,C
# 8 = a,b,c,d,e,f,g = BI D
# 9 = a,b,c,f,g     = BI A,D
# 0 = a,b,c,d,e,f   = BI



def output_num(num):
	A,B,C,D=bin(num+16)[-4:]
	if A=='1':
		GPIO.output(LED1,1)
	else:
		GPIO.output(LED1,0)
	if B=='1':
		GPIO.output(LED2,1)
	else:
		GPIO.output(LED2,0)
	if C=='1':
		GPIO.output(LED4,1)
	else:
		GPIO.output(LED4,0)
	if D=='1':
		GPIO.output(LED8,1)
	else:
		GPIO.output(LED8,0)

def countdown(count):
	while (count >= 0):
		GPIO.output(LEDAUS,1)
		output_num(count)
		count -= 1
		time.sleep (1)
		

while True:
	if (GPIO.input(PRINTIT)==GPIO.LOW):
		print("Jetzt druck gestartet!")
	if (GPIO.input(SWITCH4)==GPIO.LOW):
		while (i<5):
			countdown(9)
			gpout4 = subprocess.check_output("gphoto2 --capture-image-and-download --filename ~/fotobox/photobooth_images/photobooth_%Y%m%d_%H%M%S_" + str(i) +".jpg", stderr=subprocess.STDOUT, shell=True)
			print(gpout4)
			GPIO.output(LEDAUS,0)
			if "ERROR" not in gpout4: 
				i += 1
		subprocess.call("~/fotobox/scripts/pb_assemble_and_print_4.sh", shell=True)
		print("Bitte warten, Collage wird gedruckt...")

	if (GPIO.input(SWITCH1)==GPIO.LOW):
		countdown(9)
		gpout1 = subprocess.check_output("gphoto2 --capture-image-and-download --filename ~/fotobox/photobooth_images/photobooth_%Y%m%d_%H%M%S_" + str(i) +".jpg", stderr=subprocess.STDOUT, shell=True)
		print(gpout1)
		GPIO.output(LEDAUS,0)
		subprocess.call("~/fotobox/scripts/pb_assemble_and_print.sh", shell=True)
		print("Bitte warten, Photo wird gedruckt...")
	
	i = 1

