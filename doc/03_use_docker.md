

```
docker network create --subnet=192.168.56.0/24 ursim_net
```

## terminal 1 - URSIM

```
docker run --rm -it --net ursim_net --ip 192.168.56.101 -p 5900:5900 -p 6080:6080 --expose 29999 --expose 30001 --expose 30004 --expose 30002 --expose 30003 -v ${HOME}/docker/ursim/programs:/ursim/programs -v /etc/localtime:/etc/localtime:ro -e "TZ=America/Bogota" -e ROBOT_MODEL=UR3 ursim_cb3
```

## terminal 2 - driver ros2

```
docker run -it --rm --name moveit2_ur_gpu --privileged --network ursim_net --ip 192.168.56.103  --expose 50002 --expose 50001 --expose 29999 --expose 30001 --expose 30004 --expose 30002 --expose 30003 -v /tmp/.X11-unix:/tmp/.X11-unix -v $XAUTHORITY:/root/.Xauthority  -v /etc/localtime:/etc/localtime:ro -e QT_X11_NO_MITSHM=1 -e DISPLAY=$DISPLAY -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all --gpus device=all ros2_moveit_ur:humble /bin/bash
```

```
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur3 robot_ip:=192.168.56.101 launch_rviz:=true use_sim_time:=true
```

# comandos útiles docker
-v /etc/localtime:/etc/localtime:ro

```
#sincronizar reloj de host
sudo timedatectl set-ntp true
```

# links de interés

[interfaces cliente ur](https://www.universal-robots.com/articles/ur/interface-communication/overview-of-client-interfaces/)


[Puertos en localhost](https://forum.universal-robots.com/t/overview-of-used-ports-on-local-host/8889)
