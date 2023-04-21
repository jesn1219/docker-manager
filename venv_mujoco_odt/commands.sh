docker build -t jesn1219/odt:latest .

docker run -it --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -p 60061:6006 -p 22001:22 jesn1219/dt bash
docker run -it --gpus all -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -p 60061:6006 -p 22001:22 --name dt2 jesn1219/odt bash
