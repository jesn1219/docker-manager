docker build -t jesn1219/beta:latest .

docker run -it --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -p 60061:6006 -p 22001:22 -p 22002:22002 -p 22003:22003 jesn1219/beta bash

docker run -it --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/jskang/.Xauthority:/root/.Xauthority -e DISPLAY=$DISPLAY -p 60061:6006 -p 22001:22 -p 22002:22002 -p 22003:22003 jesn1219/beta bash


docker run -it --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -p 60061:6006 -p 22001:22 --name dt2 jesn1219/odt bash
