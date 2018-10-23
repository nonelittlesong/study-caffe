参考：  
https://blog.csdn.net/Muzythoof/article/details/79976584  

## 配置CenterLoss
原版的caffe没有centerloss层，需要手动添加。需要配置以下文件：  
* src/caffe/proto/caffe.proto
* include/caffe/layers/center_loss_layer.hpp
* src/caffe/layers/center_loss_layer.cpp
* src/caffe/layers/center_loss_layer.cu

1. 下载这几个文件：https://github.com/ydwen/caffe-face 上下载caffe-face  
把center_loss_layer.hpp 复制到include/caffe/layers/ 下  
把center_loss_layer.cpp 和center_loss_layer.cu 复制到src/caffe/layers/ 下  

2. 在原本caffe/src/caffe/proto/caffe.proto 路径下对caffe.proto进行修改：  
在message LayerParameter{}中添加如下代码：  
optional CenterLossParameter center_loss_param = 149;  
（其中149为当前最后一个ID，根据自己的提示来改）  
在文档末尾加入：  
```cpp
message CenterLossParameter {
  optional uint32 num_output = 1; // The number of outputs for the layer
  optional FillerParameter center_filler = 2; // The filler for the centers
  // The first axis to be lumped into a single inner product computation;
  // all preceding axes are retained in the output.
  // May be negative to index from the end (e.g., -1 for the last axis).
  optional int32 axis = 3 [default = 1];
}
```

3. 重新编译caffe  
```sh
$ make clean
$ make all
$ make install
$ make runtest
```

## CenterLoss的使用
CenterLoss不能单独使用，需要和SoftmaxWithLoss联合使用。  
设置loss_weight: 0.5  
