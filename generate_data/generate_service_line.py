#Author: Filmon G.
#08/24/2015
#Script to generate synthetic Service line data

#import library for random
from random import randint
import random
#open file
f=open("service_line.txt","w")

#initialize id
id=1

#making list of choice for diagnostic code
primary_diag_lst=[0123.0,1234.1,2345.2,3456.3,4567.4,5678.5,6789.6,7890.7,8901.8,9012.9]
addl_diag_lst_1=[1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9]
addl_diag_lst_2=[2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9]
addl_diag_lst_3=[3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9]
addl_diag_lst_4=[4.0,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9]
addl_diag_lst_5=[5.0,5.1,5.2,5.3,5.4,5.5,5.6,5.7,5.8,5.9]
addl_diag_lst_6=[6.0,6.1,6.2,6.3,6.4,6.5,6.6,6.7,6.8,6.9]
addl_diag_lst_7=[7.0,7.1,7.2,7.3,7.4,7.5,7.6,7.7,7.8,7.9]
addl_diag_lst_8=[8.0,8.1,8.2,8.3,8.4,8.5,8.6,8.7,8.8,8.9]
#limit the size of file and randomly generate the rest of attributes
while(id<=100000000):
	record=str(id)+","+str(randint(1,40000000))+","+str(random.choice(primary_diag_lst))+","+str(random.choice(addl_diag_lst_1))+","+str(random.choice(addl_diag_lst_2))+","+str(random.choice(addl_diag_lst_3))+","+str(random.choice(addl_diag_lst_4))+","+str(random.choice(addl_diag_lst_5))+","+str(random.choice(addl_diag_lst_6))+","+str(random.choice(addl_diag_lst_7))+","+str(random.choice(addl_diag_lst_8))+"\n"
	f.write(record)
	#print record
	id+=1
f.close()

