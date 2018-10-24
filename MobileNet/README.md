
## caffe 添加ConvolutionDepthwise 层

参考：  
* https://blog.csdn.net/qq_38451119/article/details/82663649
* https://github.com/farmingyard/caffe-mobilenet

1. 这个层不需要额外在caffe.proto文件中声明  
2. 将conv_dw_layer.cpp， conv_dw_layer.cu 这2个文件放置到src/caffe/layers 目录下  
3. 将conv_dw_layer.hpp 这个文件放置到caffe/include/caffe/layers 目录下  
4. 重新编译caffe文件  
```
$ make clean
$ make all
$ make install
$ make runtest
```
