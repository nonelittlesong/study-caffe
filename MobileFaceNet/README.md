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
