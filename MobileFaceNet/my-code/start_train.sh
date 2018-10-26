#!/bin/bash
# Usage:
# ./start_train.sh 
#
# Example:
# ./start_train.sh 
mkdir -p face_snapshot
mkdir -p result
../../../../build/tools/caffe train -solver face_solver.prototxt -gpu all 2>&1 | tee result/mobileFaceNet_20180507_0pt3.log

#!/usr/bin/env sh
set -e
../../caffe_framework/caffe/caffe/build/tools/caffe train \
  --solver=/home/ubuntu/workspace/Song/face_solver.prototxt \
  2>&1 | tee /home/ubuntu/workspace/Song/log/mobilefacenet.txt & $@
