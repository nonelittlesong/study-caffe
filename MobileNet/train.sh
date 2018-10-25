#!/usr/bin/env sh
set -e

../../caffe_framework/caffe/caffe/build/tools/caffe train --solver=/home/ubuntu/workspace/train_model/mobilenet_v2_multi_label/mobilenet_v2_multi_solver.prototxt --weights=/home/ubuntu/workspace/train_model/mobilenet_v2_multi_label/mobilenet_v2_multi_solver_iter_56400.caffemodel 2>&1 | tee /home/ubuntu/workspace/train_model/mobilenet_v2_multi_label/log/mobilenet_v2_multi_0925.txt & $@
