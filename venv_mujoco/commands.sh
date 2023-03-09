docker build -t jesn1219/mujoco:latest .

docker run -it --gpus all -p 6006:6006 -p 2202:2202 jesn1219/mujoco bash