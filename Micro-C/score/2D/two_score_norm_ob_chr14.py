import numpy as np
import math



fr = open("/mnt/disk4/whh/score/bin/100kb/chr14.bed")
for line in fr.readlines():
	line=line.strip()
	listFromLine=line.split('\t')

a = math.ceil(int(listFromLine[1])/100000)
fr.close()

fr = open("MNase-1min_OE_chr14.bed")
returnMat_1min = np.zeros((a,a))
for line in fr.readlines():
    line=line.strip()
    listFromLine=line.split('\t')
    returnMat_1min[int(listFromLine[0]),int(listFromLine[1])]=float(listFromLine[2])
sum_1min=returnMat_1min.sum()
#Mat_1min=returnMat_1min/sum_1min
Mat_1min=returnMat_1min
where_are_nan = np.isnan(Mat_1min)
where_are_inf = np.isinf(Mat_1min)
Mat_1min[where_are_nan] = 0
Mat_1min[where_are_inf] = 0
fr.close()

fr = open("MNase-5min_OE_chr14.bed")
returnMat_5min = np.zeros((a,a))
for line in fr.readlines():
    line=line.strip()
    listFromLine=line.split('\t')
    returnMat_5min[int(listFromLine[0]),int(listFromLine[1])]=float(listFromLine[2])
sum_5min=returnMat_5min.sum()
Mat_5min=returnMat_5min/sum_5min
Mat_5min=returnMat_5min
where_are_nan = np.isnan(Mat_5min)
where_are_inf = np.isinf(Mat_5min)
Mat_5min[where_are_nan] = 0
Mat_5min[where_are_inf] = 0
fr.close()


fr = open("MNase-20min_OE_chr14.bed")
returnMat_30min = np.zeros((a,a))
for line in fr.readlines():
    line=line.strip()
    listFromLine=line.split('\t')
    returnMat_30min[int(listFromLine[0]),int(listFromLine[1])]=float(listFromLine[2])
sum_30min=returnMat_30min.sum()
Mat_30min=returnMat_30min/sum_30min
Mat_30min=returnMat_30min
where_are_nan = np.isnan(Mat_30min)
where_are_inf = np.isinf(Mat_30min)
Mat_30min[where_are_nan] = 0
Mat_30min[where_are_inf] = 0



for i in range(a):
	for j in range(a):
		Mat_5min[j,i]=Mat_5min[i,j]

for i in range(a):
	for j in range(a):
		Mat_1min[j,i]=Mat_1min[i,j]


for i in range(a):
	for j in range(a):
		Mat_30min[j,i]=Mat_30min[i,j]




col_ave = np.sum(Mat_30min, axis=0)/np.sum(Mat_5min, axis=0) + np.sum(Mat_5min, axis=0)/np.sum(Mat_1min, axis=0)
np.savetxt("col_ave_OE_chr14_new.txt",col_ave,fmt='%.6f')

#np.savetxt("Mat_1min_norm.txt",Mat_1min,fmt='%.6f')
#np.savetxt("Mat_5min_norm.txt",Mat_5min,fmt='%.6f')
#np.savetxt("Mat_20min_norm.txt",Mat_30min,fmt='%.6f')

fr.close()


