参考：  
* https://github.com/zhanglaplace/MobileFaceNet
* https://github.com/happynear/AMSoftmax
* https://blog.csdn.net/u010579901/article/details/81198950

TODO:  
- [ ] 可分离卷积，Prelu是否要修改caffe

## 配置AMSoftmax
原版的caffe没有label_specific_add, 需要配置以下文件：  
* src/caffe/proto/caffe.proto
* include/caffe/layers/label_specific_add.hpp
* src/caffe/layers/label_specific_add.cpp
* src/caffe/layers/label_specific_add.cu

## 配置DepthwiseConvolution
* https://github.com/yonghenglh6/DepthwiseConvolution

## 重新編譯caffe.pb.cc caffe.pb.h:
```
$ cd YOUR_CAFFE_ROOT_PATH/src/caffe/proto
$ protoc --cpp_out=/YOUR_CAFFE_ROOT_PATH/src/caffe/proto caffe.proto
$ cp /YOUR_CAFFE_ROOT_PATH/src/proto/caffe.pb.h /YOUR_CAFFE_ROOT_PATH/include/caffe/proto/caffe.ph.h
```

## 修改代码
* 修改scale
* 修改innerproduct
* 添加Normalize
* 调试label_specific_add.cpp的bug
