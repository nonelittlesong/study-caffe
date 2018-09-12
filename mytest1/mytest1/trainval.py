from numpy.matlib import random

dataSet = []
fileIn = open('/home/song/caffe/examples/mytest1/all.txt')
for line in fileIn.readlines():
    dataSet.append(line.strip())

random.shuffle(dataSet)
pos = int(len(dataSet)*0.9)
traindata = dataSet[:pos]
testdata = dataSet[pos:]

f = open('/home/song/caffe/examples/mytest1/train.txt', 'w')
for row in traindata:
    f.write(row+'\n')
f.close()
f = open('/home/song/caffe/examples/mytest1/val.txt', 'w')
for row in testdata:
    f.write(row+'\n')
f.close()

