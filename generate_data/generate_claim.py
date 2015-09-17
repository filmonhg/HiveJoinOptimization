#Author: Filmon G.
#08/24/2015
#Script to generate synthetic claim data

#import random library
from random import randint
import random
#open file to write
f=open("claim.txt","w")

#intialize id
id=1
#limit the size of the file and randomly generate the other attributes
while(id<=40000000):
	record=str(id)+","+str(randint(1,1000000))+","+"2015-08-23"+"\n"
	f.write(record)
	id+=1
f.close()
