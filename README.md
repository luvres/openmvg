## OpenMVG
### NVIDIA Docker and VirtualGL
-----
##### Pull image
```
docker pull izone/openmvg
```

##### Run
```
mkdir $HOME/openmvg
```
```
```
```
docker run -ti --rm --name OpenMVG \
--net=host \
-e DISPLAY=unix$DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/root/.Xauthority \
-v $HOME/openmvg:/mnt \
-w /mnt \
izone/openmvg
```

#### Build
```
docker build -t izone/openmvg .
```