# Base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV PATH="/root/miniconda3/bin:${PATH}"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/root/anaconda3/envs/odt/lib"

ARG PATH="/root/miniconda3/bin:${PATH}"


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


RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 


# Clone and install the repository
RUN /bin/bash -c "cd /root/ && \
    git clone https://github.com/jesn1219/online-dt.git && \
    cd /root/online-dt && \
    conda env create -f conda_env.yml && \
    conda install -c conda-forge gcc=12.1.0"


# Install Modified Python dependencies
#RUN . ~/.bashrc && \
RUN /bin/bash -c "conda activate odt && \
    pip install -U transformers==4.6 && \
    pip install icecream "

# Install MuJoCo
RUN /bin/bash -c "conda activate odt && \
    apt-get install -y libosmesa6-dev libosmesa6-dev libgl1-mesa-glx libglfw3 && \
    wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz && \
    tar -xzf mujoco210-linux-x86_64.tar.gz && \
    mkdir /root/.mujoco && \
    mv mujoco210 /root/.mujoco && \
    rm mujoco210-linux-x86_64.tar.gz && \
    pip install mujoco_py && \
    python -c 'import mujoco_py'"

RUN /bin/bash -c "conda activate odt && \
    cd /root/online-dt/data && \
    python ./download_d4rl_antmaze_datasets.py && \
    python ./data/download_d4rl_gym_datasets.py"

