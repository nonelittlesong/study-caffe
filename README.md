# study-caffe
<ol>
  <li>https://github.com/BVLC/caffe.git</li>
  <li>http://caffe.berkeleyvision.org/</li>
</ol>

## Install caffe
### 下载caffe
```
sudo git clone http://github.com/BLVC/caffe.git
```
### 配置caffe
```
cd ~/caffe
cp Makefile.config.example Makefile.config
vim Makefile.config
```

### 编译caffe
### 检查编译是否成功
## Install digits
<ol>
  <li>https://github.com/NVIDIA/DIGITS</li>
  <li>https://blog.csdn.net/linyu2016/article/details/78903243</li>
</ol>

### 对于Ubuntu 16.04
CUDA_REPO_PKG=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb  
ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb  
### 安装repo包
```
wget "$CUDA_REPO_PKG" -O /tmp/cuda-repo.deb && sudo dpkg -i /tmp/cuda-repo.deb && rm -f /tmp/cuda-repo.deb  
wget "$ML_REPO_PKG" -O /tmp/ml-repo.deb && sudo dpkg -i /tmp/ml-repo.deb && rm -f /tmp/ml-repo.deb  
```
### 安装digits
```
sudo apt-get update #安装digits  
sudo apt-get install digits #首选方式，这种方法只是安装digits5.0.0版本，bug比较小，官网说这个就已经自动附带安装很多依赖
```
### 启动digits
在浏览器中填入：  
http://localhost/ （这是按照sudo apt-get install digits这种方式安装的打开方法）  
按回车即可  
### 卸载digits
比较容易卸载  
```
sudo apt-get remove digits  
sudo apt-get autoremove  
```
