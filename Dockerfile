# Base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
FROM continuumio/miniconda3

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV PATH="/root/miniconda3/bin:${PATH}"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/conda/envs/odt/lib"


# Install dependencies

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libghc-x11-dev \
    libglew-dev \
    patchelf \
    git \
    wget

RUN apt-get install -y --no-install-recommends \
    software-properties-common

RUN apt install -y --no-install-recommends \
    net-tools \
    vim

RUN apt install -y --no-install-recommends \
    virtualenv \
    wget
#    xpra
RUN apt-get install -y --no-install-recommends \
    xserver-xorg-dev

# Clone and install the repository
RUN /bin/bash -c "cd /root/ && \
    git clone https://github.com/jesn1219/online-dt.git && \
    cd /root/online-dt && \
    conda env create -f conda_env.yml" 

ARG conda_env=odt
ENV PATH /opt/conda/envs/$conda_env/bin:$PATH
ENV CONDA_DEFAULT_ENV $conda_env
SHELL ["conda", "run", "-n", "odt", "/bin/bash", "-c"]

RUN /bin/bash -c "source activate odt"

RUN conda install -y -c conda-forge gcc=12.1.0 





# Install Modified Python dependencies
#RUN . ~/.bashrc && \
RUN pip install -U transformers==4.6 && \
    pip install icecream

# Install MuJoCo
RUN apt-get install -y libosmesa6-dev libgl1-mesa-glx libglfw3
RUN conda install -c conda-forge mesalib glew glfw ncurses

RUN wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz && \
    tar -xzf mujoco210-linux-x86_64.tar.gz && \
    mkdir /root/.mujoco && \
    mv mujoco210 /root/.mujoco && \
    rm mujoco210-linux-x86_64.tar.gz


RUN conda install -c menpo glfw3

ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/root/.mujoco/mujoco210/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/lib/nvidia
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/conda/envs/odt/lib
ENV LD_LIBRARY_PATH /root/.mujoco/mujoco210/bin:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib64:${LD_LIBRARY_PATH}


RUN pip install mujoco-py==2.1.2.14
ENV C_INCLUDE_PATH ${C_INCLUDE_PATH}:${CONDA_PREFIX}/include


ENV CPATH ${CONDA_PREFIX}/include
RUN apt-get install libglu1-mesa-dev libosmesa6-dev

RUN echo ${CONDA_PREFIX}
RUN echo $(ls -a /opt)
RUN echo ${CONDA_DEFAULT_ENV}


RUN apt-get install -y \
    curl \
    git
RUN apt-get install -y \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglew-dev \
    libosmesa6-dev


ENV PATH $CONDA_PREFIX/bin:$PATH


RUN conda update -y gcc

RUN apt install -y libgl1-mesa-glx

RUN find / -name "osmesa.h"
RUN conda install -c menpo osmesa

                                                
ENV C_INCLUDE_PATH ${C_INCLUDE_PATH}:/opt/conda/pkgs/mesalib-18.3.1-h590aaf7_0/include/          
ENV C_INCLUDE_PATH ${C_INCLUDE_PATH}:/usr/include/
ENV C_INCLUDE_PATH ${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu/
ENV C_INCLUDE_PATH /opt/conda/envs/odt/include/:${C_INCLUDE_PATH}


ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/root/.mujoco/mujoco210/bin/
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/lib/nvidia
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/conda/envs/odt/lib/
ENV LD_LIBRARY_PATH /root/.mujoco/mujoco210/bin:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/include/:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /opt/conda/envs/odt/include/:${LD_LIBRARY_PATH}


RUN echo ${C_INCLUDE_PATH}

RUN find / -name "libc-header-start.h"
RUN pip install cython
RUN ls -a /opt/conda/pkgs/mesalib-18.3.1-h590aaf7_0
ENV LD_LIBRARY_PATH /opt/conda/pkgs/mesalib-18.3.1-h590aaf7_0/lib/:${LD_LIBRARY_PATH}
RUN echo "test"
RUN ls -a /opt/conda/envs/odt/include/GL



RUN python -c "import mujoco_py"


RUN cd /root/online-dt/data && \
    python ./download_d4rl_antmaze_datasets.py && \
    python ./data/download_d4rl_gym_datasets.py

