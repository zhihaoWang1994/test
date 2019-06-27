# 智能考勤 上线部署AI项目到阿里云服务器

## 登录云服务器

`ssh root@39.97.224.231`


## 进入自己专用的目录通过git拉取示例代码

`git clone https://github.com/zhihaoWang1994/test.git`



## docker配置文件(Dockerfile)说明

```
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

# 安装基本依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libopencv-dev \
        libsnappy-dev \
        python-dev \
        python-pip \
        tzdata \
        vim


# 安装anaconda 
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc


# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


# 设置编码
ENV LANG C.UTF-8 LC_ALL=C.UTF-8


# 初始化工作空间
RUN mkdir /workspace

```

`cd test`


## 构建docker镜像

`make build`

根据以上配置文件生成镜像

## 使用镜像

`docker run -it test_bawei`

-it 进入容器的命令行

## 测试anaconda是否安装完成

`conda list`

## 安装各种依赖


1. 用anaconda创建环境

```
conda create -n face_test python=3.6
```

3. 激活虚拟环境

`source activate test_face` 

```
pip install dlib==19.17.0
pip install numpy==1.15.1
pip install scikit-image==0.14.0

```
##使用步骤
```
1.在labels中添加被测试人的姓名，性别等信息，逐行添加
2.python get_data.py
3.python features_to_csv.py
4.python face_test.py
这样就得到了测试的最终结果

```
##说明
```
标准正脸的准确率检测，本系统可达99%以上

```
#6保存项目
```
执行exit退出docker容器 然后输入docker ps -a查看刚才退出的是哪个容器, 复制它的id 执行docker commit 80cdc99d89dd new_container:tag1, 其中80cdc99d89dd就是容器的id号, 自行替换. 后边的参数分别是容器名和标签名

```
#7再次进入项目不需要重新安装环境
```
只用执行docker images查看上一步创建的新镜像名'new_container', 复制他的id号, 假如是12345678

然后docker run -it 12345678 则再次进入容器, 直接运行项目而不需再次安装依赖

```
