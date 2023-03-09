FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libghc-x11-dev \
    libglew-dev \
    patchelf \
    git \
    wget \
    virtualenv \
    vim \
    software-properties-common


# Add deadsnakes PPA for install other python versions
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv F23C5A6CF475977595C89F51BA6932366A755776
RUN apt update
RUN add-apt-repository ppa:deadsnakes/ppa && apt update


# Install Python 3.8
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    python3.8 \
    python3.8-dev \
    python3-pip \
    virtualenv \
    python3-setuptools \
    python3-wheel \
    python3.8-venv \
    python3.8-distutils \
    python3-pip

# Create virtual environment
RUN cd / && virtualenv --python=python3.8 env

# Install Mujoco
RUN mkdir -p /root/.mujoco \
    && wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz -O mujoco.tar.gz \
    && tar -xf mujoco.tar.gz -C /root/.mujoco \
    && rm mujoco.tar.gz
ENV LD_LIBRARY_PATH /root/.mujoco/mujoco210/bin:${LD_LIBRARY_PATH}
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:${LD_LIBRARY_PATH}
RUN cd /
RUN apt-get install -y libosmesa6-dev
ENV PATH $PATH:/env/bin
RUN . /env/bin/activate && pip install mujoco-py==2.1.2.14
RUN . /env/bin/activate && python -c "import mujoco_py"