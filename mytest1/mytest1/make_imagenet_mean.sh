#!/usr/bin/env sh
OUTPUT=/home/song/caffe/examples/mytest1
TOOLS=/home/song/caffe/build/tools

$TOOLS/compute_image_mean $OUTPUT/train_lmdb $OUTPUT/imagenet_mean.binaryproto

echo "Done."
