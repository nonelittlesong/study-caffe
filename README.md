# study-caffe
<ol>
  <li>https://github.com/BVLC/caffe.git</li>
  <li>http://caffe.berkeleyvision.org/</li>
</ol>

*wiki*
* [训练alexnet](https://github.com/nonelittlesong/study-caffe/wiki/%E8%AE%AD%E7%BB%83alexnet)
* [labelImg标注数据](https://github.com/nonelittlesong/study-caffe/wiki/LabelImg)


## 一、 Install dependencies
```
$ sudo pip install easydict protobuf pydot
$ sudo apt-get install graphviz libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libopenblas-dev liblapack-dev libatlas-base-dev libgflags-dev libgoogle-glog-dev liblmdb-dev python-tk python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf python-leveldb python-networkx python-nose python-pandas python-gflags
# 执行完上面这一句后生成了/usr/bin/protoc
# 且pkg-config --modversion protobuf的结果为2.6.1 (ubuntu18.04为3.0.0)
$ sudo apt-get install --no-install-recommends libboost-all-dev
```
抛错1：  
```
Could not install packages due to an EnvironmentError: [Errno 13] Permission denied: '/usr/local/lib/python2.7/dist-packages/easydict'
Consider using the `--user` option or check the permissions.
```
解决方法：  
```
$ pip install --user easydict
```
## 二、 Install caffe
**下载caffe**  
```
$ git clone https://github.com/BVLC/caffe.git
```
**配置caffe**  
```
$ cd ~/caffe
$ cp Makefile.config.example Makefile.config
$ vim Makefile.config
```

**编译caffe**  
```
$ mkdir build
$ cd build
$ cmake ..
$ make all -j16
$ make install -j16
$ make runtest -j16
```
**检查编译是否成功**  
在.bashrc或.zshrc末尾添加：  
export PYTHONPATH=/home/song/caffe/python  
从终端进入python    
```
$ python
$ import caffe
```
ctrl + d退出Python  
重启电脑  
```
$ cd caffe # (如果不在这个目录下测试，会有bug，好坑)
$ sudo ./data/mnist/get_mnist.sh # 下载数据
$ sudo ./examples/mnist/create_mnist.sh # 把数据改造成lmdb格式
$ sudo ./examples/mnist/train_lenet.sh # 训练模型
```
## 三、 Install digits
<ol>
  <li>https://github.com/NVIDIA/DIGITS</li>
  <li>https://blog.csdn.net/linyu2016/article/details/78903243</li>
</ol>

### 对于Ubuntu 16.04
```
$ CUDA_REPO_PKG=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb  
$ ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb  
```
**安装repo包**  
```
$ wget "$CUDA_REPO_PKG" -O /tmp/cuda-repo.deb && sudo dpkg -i /tmp/cuda-repo.deb && rm -f /tmp/cuda-repo.deb  
$ wget "$ML_REPO_PKG" -O /tmp/ml-repo.deb && sudo dpkg -i /tmp/ml-repo.deb && rm -f /tmp/ml-repo.deb  
```
**安装digits**  
```
$ sudo apt-get update #安装digits  
$ sudo apt-get install digits #首选方式，这种方法只是安装digits5.0.0版本，bug比较小，官网说这个就已经自动附带安装很多依赖
```
**启动digits**  
在浏览器中填入：  
http://localhost/ （这是按照sudo apt-get install digits这种方式安装的打开方法）  
按回车即可  
**卸载digits**  
比较容易卸载  
```
$ sudo apt-get remove digits  
$ sudo apt-get autoremove  
```
## 四、 Troubleshooting
### Cannot use GPU in CPU-only Caffe 错误
examples/mnist/lenet_solver.prototxt 中  
```
#solver mode:CPU or GPU
solver_mode:GPU
```
改为
```
#solver mode:CPU or GPU
solver_mode:CPU
```
### 再次编译caffe时出错
>protobuf compiler 和 protobuf 版本不一致  

删除并重建build文件夹  
### Could NOT find HDF5 (missing: HDF5_HL_LIBRARIES) (found version "1.10.0.1")
治不了，告辞。  
2018.09.15，治好了：我的cmake是ln -s的AndroidStudio的cmake，版本是3.6  
对于ubuntu18.04的hdf5来说，太low了  
通过`sudo apt install cmake`升级到3.10  
当然，别忘了删除软连接：/usr/local/bin/cmake  
2018.09.17:上面不对，今天ubuntu16在重新编译caffe时也遇到了一样的问题，使用系统apt安装的cmake可解决问题  

### OpenCV配置
在caffe根目录，`vim cmake/Dependencies.cmake`  
找到opencv相关配置  
添加：  
```
set(OpenCV_DIR /usr/local/share/OpenCV)
...
set(OpenCV_FOUND 1)
```
### ffmpeg
ubuntu18.04 caffe在make all的时候找不到ffmpeg相关的库  
无能为力了，只能退回ubuntu16.04。

### SolverParameter
ubuntu16：将caffe修改为多标签，重新编译caffe  
>src/caffe/solver.cpp:116:38: error: ‘class caffe::SolverParameter’ has no member named ‘weights_size’  
>src/caffe/solver.cpp:117:33: error: ‘class caffe::SolverParameter’ has no member named ‘weights’  

原因可能是因为错误地修改了caffe内部的文件导致的  
但是通过删除caffe重新下载编译  
编译通过  

### Accuracy波动大
base_lr 或 momentum 过大？？
