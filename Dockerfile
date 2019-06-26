FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
ENV PYTHONUNBUFFERED 1
ENV C_FORCE_ROOT true

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
RUN mkdir /src
RUN mkdir /static
WORKDIR /src

#把物理机src里的所有文件添加到容器src目录里
ADD ./src /src

# RUN pip install --upgrade pip
# RUN pip install -r requirements2.pip

# CMD python gan.py


#====================


# install psycopg2
# RUN apk update \
#     && apk add --virtual build-deps gcc python3-dev musl-dev \
#     && apk add postgresql-dev \
#     && pip install psycopg2 \
#     && apk del build-deps

# RUN pip install --upgrade pip
# RUN pip install -r requirements.pip


# CMD python gan.py

# CMD python manage.py collectstatic --no-input;python manage.py migrate; gunicorn mydjango.wsgi -b 0.0.0.0:8000 & celery worker --app=myapp.tasks
# command: bash -c "python manage.py makemigrations && python manage.py migrate && gunicorn mydjango.wsgi -b 0.0.0.0:8000"
