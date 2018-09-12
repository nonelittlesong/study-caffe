#!/usr/bin/env sh
# create the imagenet lmdb inputs
# N.B. set the path to the imagenet train + val data dirs
set -e
EXAMPLE="/home/song/caffe/examples/mytest1"
# DATA = /add/your/data/path
TOOLS=/home/song/caffe/build/tools

TRAIN_DATA_ROOT=/home/song/Documents/VGG_test/
VAL_DATA_ROOT=/home/song/Documents/VGG_test/

# Set RESIZE=true to resize the images to 224x224. Leave as false if images have
# already been resize using another tool.
RESIZE=true
if $RESIZE; then
  RESIZE_HEIGHT=224
  RESIZE_WIDTH=224
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi

if [ ! -d $TRAIN_DATA_PATH ]; then
  echo "Error: TRAIN_DATA_ROOT is not a path to a directory: $TRAIN_DATA_ROOT"
  echo "Set the TRAIN_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet training data is stored."
  exit 1
fi

if [ ! -d $VAL_DATA_ROOT ]; then
  echo "Error: VAL_DATA_ROOT is not a path to a directory: $VAL_DATA_ROOT"
  echo "Set the VAL_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet validation data is stored."
  exit 1
fi

echo "Creating train lmdb..."
# 调用convert_imageset文件转换文件格式，后面为输入参数

GLOG_logtostderr=1 $TOOLS/convert_imageset \
                   --resize_height=$RESIZE_HEIGHT \
                   --resize_width=$RESIZE_WIDTH \
                   --shuffle \
                   $TRAIN_DATA_ROOT \
                   $EXAMPLE/train.txt \
                   $EXAMPLE/train_lmdb

echo "Creating val lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
                   --resize_height=$RESIZE_HEIGHT \
                   --resize_width=$RESIZE_WIDTH \
                   --shuffle \
                   $VAL_DATA_ROOT \
                   $EXAMPLE/val.txt \
                   $EXAMPLE/test_lmdb

echo "Done."
