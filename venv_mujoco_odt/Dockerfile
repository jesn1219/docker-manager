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
    curl \
    openssh-server \
    tmux \
    software-properties-common

# Default config
RUN echo "service ssh start" >> ~/.bashrc
RUN echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/.mujoco/mujoco210/bin" >> ~/.bashrc



# 아래 명령들은 infinite loop에 빠지는 경우가 있음
# 이럴 경우, #1 혹은 #2 둘 중 하나를 실행해볼것
# Add deadsnakes PPA for install other python versions
#1
RUN add-apt-repository ppa:deadsnakes/ppa && apt update 
#2
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv F23C5A6CF475977595C89F51BA6932366A755776
RUN apt update


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
RUN echo "source /env/bin/activate" >> ~/.bashrc

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

########################################################################################

# Download Online Decision Transformer
RUN cd / && mkdir research && cd research

RUN cd /research && git clone https://github.com/jesn1219/online-dt.git

# Install Online Decision Transformer Dependencies
RUN . /env/bin/activate && \
    pip install cffi==1.15.1 \ 
                Cython==0.29.33 \
                fasteners==0.18 \ 
                glfw==2.5.6 \
                imageio==2.26.0 \
                mujoco-py==2.1.2.14 \
                Pillow==9.4.0 \
                pycparser==2.21 \
                gym \
                git+https://github.com/rail-berkeley/d4rl@master#egg=d4rl \
                mujoco==2.2.1 \
                numpy==1.23.4 \
                stable-baselines3==1.1.0 \
                tensorboard==2.5.0 \
                torch==1.8.1 \
                transformers==4.6 \
                icecream \
                protobuf==3.20 \
                wandb

# Download datasets for D4RL (AntMaze and Gym) - Online Decision Transformer
#RUN ls /research
#RUN . /env/bin/activate && \
#    cd /research/online-dt/data && \
#    python ./download_d4rl_antmaze_datasets.py && \
#    python ./download_d4rl_gym_datasets.py


########################################################################################
