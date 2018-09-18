将alexnet改成多标签  
参考：
* [Alexnet多标签](https://blog.csdn.net/u013382233/article/details/78850940)
* [使用ImageData](https://blog.csdn.net/sushiqian/article/details/78763514)

## 1. 修改data layer
```
layer {
  name: "data"
  type: "ImageData"
  top: "data"
  top: "label"
  include {
    phase: TRAIN
  }
  transform_param {
    scale: 0.00390625
  }
  image_data_param {
    source: "/home/multiLabel/train.txt"
	root_folder: "/"
    new_height: 224
	new_width: 224
	is_color: true
    batch_size: 8
	shuffle: true
	label_dim: 2
  }
}
layer {
  name: "data"
  type: "ImageData"
  top: "data"
  top: "label"
  include {
    phase: TEST
  }
  transform_param {
    scale: 0.00390625
  }
  image_data_param {
    source: "/home/multiLabel/val.txt"
	root_folder: "/"
	new_height: 224
	new_width: 224
	is_color: true
    batch_size: 4
    shuffle: true
	label_dim: 2
  }
}
```
## 2. 添加slice layer
```
layer {
  name: "slicer"
  type: "Slice"
  bottom: "label"
  top: "label_1"
  top: "label_2"
  slice_param {
	axis: 1
	slice_point: 1 # point=top-1
  }
}
```
## 3. 尾部修改
根据效果决定什么时候分叉  
```
layer {
  name: "fc7_1"
  type: "InnerProduct"
  bottom: "fc6"
  top: "fc7_1"
  param {
    lr_mult: 1
    decay_mult: 1
  }
  param {
    lr_mult: 2
    decay_mult: 0
  }
  inner_product_param {
    num_output: 4096
    weight_filler {
      type: "gaussian"
      std: 0.005
    }
    bias_filler {
      type: "constant"
      value: 0.1
    }
  }
}
layer {
  name: "relu7_1"
  type: "ReLU"
  bottom: "fc7_1"
  top: "fc7_1"
}
layer {
  name: "drop7_1"
  type: "Dropout"
  bottom: "fc7_1"
  top: "fc7_1"
  dropout_param {
    dropout_ratio: 0.5
  }
}
layer {
  name: "fc7_2"
  type: "InnerProduct"
  bottom: "fc6"
  top: "fc7_2"
  param {
	lr_mult: 1
	decay_mult: 1
  }
  param {
	lr_mult: 2
	decay_mult: 0
  }
  inner_product_param {
	num_output: 4096
	weight_filler {
	  type: "gaussian"
	  std: 0.005
	}
	bias_filler {
      type: "constant"
	  value: 0.1
    }
  }
}
layer {
  name: "relu7_2"
  type: "ReLU"
  bottom: "fc7_2"
  top: "fc7_2"
}
layer {
  name: "drop7_2"
  type: "Dropout"
  bottom: "fc7_2"
  top: "fc7_2"
  dropout_param {
	dropout_ratio: 0.5
  }
}
layer {
  name: "fc8_1"
  type: "InnerProduct"
  bottom: "fc7_1"
  top: "fc8_1"
  param {
    lr_mult: 1
    decay_mult: 1
  }
  param {
    lr_mult: 2
    decay_mult: 0
  }
  inner_product_param {
    num_output: 1000
    weight_filler {
      type: "gaussian"
      std: 0.01
    }
    bias_filler {
      type: "constant"
      value: 0
    }
  }
}
layer {
  name: "fc8_2"
  type: "InnerProduct"
  bottom: "fc7_2"
  top: "fc8_2"
  param {
    lr_mult: 1
	decay_mult: 1
  }
  param {
	lr_mult: 2
	decay_mult: 0
  }
  inner_product_param {
	num_output: 1000
	weight_filler {
	  type: "gaussian"
	  std: 0.01
	}
    bias_filler {
	  type: "constant"
	  value: 0
	}
  }
}
layer {
  name: "accuracy_1"
  type: "Accuracy"
  bottom: "fc8_1"
  bottom: "label_1"
  top: "accuracy_1"
  include {
    phase: TEST
  }
}
layer {
  name: "accuracy_2"
  type: "Accuracy"
  bottom: "fc8_2"
  bottom: "label_2"
  top: "accuracy_2"
  include {
    phase: TEST
  }
}
layer {
  name: "loss_1"
  type: "SoftmaxWithLoss"
  bottom: "fc8_1"
  bottom: "label_1"
  top: "loss_1"
}
layer {
  name: "loss_2"
  type: "SoftmaxWithLoss"
  bottom: "fc8_2"
  bottom: "label_2"
  top: "loss_2"
}
```
