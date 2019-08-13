#
# Nvidia CUDA Python3 OpenCV
#

FROM nvidia/cuda:10.1-devel-ubuntu18.04

# working directory
WORKDIR /

# install
RUN \
	apt-get update && apt-get install -y \
	autoconf \
        automake \
	libtool \
	build-essential \
    cmake \
    yasm \
    pkg-config \
    libavcodec-dev \
    libxvidcore-dev \
    libx264-dev \
    gfortran \
    python3-dev \
    libatlas-base-dev \
    libdc1394-22-dev \
    libgtk-3-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libpq-dev \
	git \
    nano \
    vim \
    curl \
    unzip \
    ninja-build \
    gcc \
    libv4l-dev \
    ffmpeg \
    libtiff-dev \
    libwebp-dev \
    python3-pip \
    wget && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN pip3 install virtualenv virtualenvwrapper jasper numpy python-osc

WORKDIR /
ENV OPENCV_VERSION="3.4.6"
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip \
&& wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip opencv.zip \
&& unzip opencv_contrib.zip \
&& rm opencv.zip \
&& rm opencv_contrib.zip \
&& mv /opencv-${OPENCV_VERSION} /opencv \
&& mv /opencv_contrib-${OPENCV_VERSION} /opencv_contrib \
&& mkdir /opencv/build \
&& cd /opencv/build

WORKDIR /opencv/build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
 -D CMAKE_INSTALL_PREFIX=/usr/local \
 -D INSTALL_PYTHON_EXAMPLES=ON \
 -D INSTALL_C_EXAMPLES=OFF \
 -D OPENCV_ENABLE_NONFREE=ON \
 -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
 -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
 -D BUILD_EXAMPLES=ON ..

# RUN make -j${nproc}
# RUN make install
# RUN ldconfig 

WORKDIR /
RUN mkdir /work
