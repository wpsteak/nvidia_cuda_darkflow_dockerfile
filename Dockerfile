FROM nvidia/cuda
MAINTAINER PIN SHIH WANG <wpsteak@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
 git vim wget vim python3.6 python3-pip libsm6 libxrender1 libxext-dev curl

RUN git clone https://github.com/thtrieu/darkflow.git
WORKDIR /darkflow

# ImportError: libcublas.so.10.0: cannot open shared object file: No such file or directory
# https://github.com/tensorflow/tensorflow/issues/26182
# RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
# RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
# RUN rm Miniconda-latest-Linux-x86_64.sh

# ENV PATH=/miniconda/bin:${PATH}
# RUN conda update -y conda
# RUN conda install -y \
#     cudatoolkit \
#     cudnn

RUN pip3 install Cython
RUN pip3 install numpy
RUN pip3 install tensorflow
# RUN pip3 install tensorflow-gpu
RUN pip3 install opencv-python
RUN pip3 install .
RUN python3.6 setup.py build_ext --inplac

RUN mkdir bin
WORKDIR /darkflow/bin
RUN wget https://pjreddie.com/media/files/yolo.weights
WORKDIR /darkflow

