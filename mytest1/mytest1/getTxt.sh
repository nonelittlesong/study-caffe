#!/usr/bin/env sh

# 配置图片的路径
image_path=/home/song/Documents/VGG_test
image_label=0
# 第一层循环，获取类型名
for mypath in `ls $image_path`
do
	echo "========================================== 读取文件夹: $mypath ================================================="
	for image_name in `ls $image_path/$mypath`
	do
		echo "读取文件: $image_name, 标签: $image_label"
		python inputTxt.py $mypath"/"$image_name $image_label
	done
	image_label=`expr $image_label + 1`
done
