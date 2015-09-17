#Author: Filmon G.
#08/24/2015
#Script to generate synthetic Patient data

from random import randint
import random
#open file
f=open("patient.txt","w")

id=1 #initialize the id
#limit the range of id and random choice of other parameters
while(id<=10000000):
	record=str(id)+","+str(randint(2004,2014))+"-"+str(randint(1,12))+"-"+str(randint(1,29))+","+str(random.choice(['M','F']))+","+str(94303)+"\n"
	f.write(record)
	id+=1
#close file
f.close() 
