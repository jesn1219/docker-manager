docker build -t jesn1219/odt:latest .

docker run -it --gpus al -e DISPLAY=$DISPLAY -p 60062:6006 -p 22002:2202 jesn1219/odt bash