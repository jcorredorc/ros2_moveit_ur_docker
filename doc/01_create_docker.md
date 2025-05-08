## 📦 Estructura

```


.
├── Dockerfile                # Imagen personalizada basada en MoveIt 2 oficial
├── docker-compose.yml       # Para lanzar fácilmente el entorno
└── README.md



```


# Instalar
remmina -vnc

apt-get update -y
apt install -y iputils-ping

abrir 50001 y 50002, 30001

sudo ufw allow 5900
sudo ufw allow 6080
sudo ufw allow 29999
sudo ufw allow 30001:30004/tcp

verifica si estan abiertos

ss -tuln | grep 5900
nc -zv localhost 50002

# Uso

[info on docker ursim](https://hub.docker.com/r/universalrobots/ursim_cb3)

```bash
DOCKER_IMAGE=humble docker compose -f docker_compose_moveit_ursim.yml up -d ursim
```



Abrir remmina e ingresar la ip localhost:5900

```bash
DOCKER_IMAGE=humble docker compose -f docker_compose_moveit_ursim.yml run --rm --name moveit2_ur gpu
```


```bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur3 robot_ip:=192.168.56.101 launch_rviz:=true
```

# revisar configuraciónd de red

docker inspect ursim | grep -i "NetworkMode"

```bash
$ docker exec -it ursim_container netstat -tulnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:30011           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30013           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30012           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30003           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30002           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30001           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:30004           0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:502             0.0.0.0:*               LISTEN      1198/URControl      
tcp        0      0 0.0.0.0:6080            0.0.0.0:*               LISTEN      44/python3          
tcp        0      0 0.0.0.0:5900            0.0.0.0:*               LISTEN      12/x11vnc           
tcp        0      0 127.0.0.11:46665        0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::29919                :::*                    LISTEN      56/java             
tcp6       0      0 :::29999                :::*                    LISTEN      56/java             
tcp6       0      0 :::5900                 :::*                    LISTEN      12/x11vnc           
tcp6       0      0 127.0.0.1:6666          :::*                    LISTEN      56/java             
udp        0      0 127.0.0.11:43689        0.0.0.0:*     
```


```bash
docker exec -it moveit2_ur netstat -tulnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.11:34355        0.0.0.0:*               LISTEN      -                   
udp        0      0 192.168.56.103:46938    0.0.0.0:*                           947/dashboard_clien 
udp        0      0 127.0.0.11:49755        0.0.0.0:*                           -                   
udp        0      0 0.0.0.0:50896           0.0.0.0:*                           947/dashboard_clien 
udp        0      0 192.168.56.103:52428    0.0.0.0:*                           951/controller_stop 
udp        0      0 0.0.0.0:54455           0.0.0.0:*                           953/urscript_interf 
udp        0      0 192.168.56.103:58461    0.0.0.0:*                           955/robot_state_pub 
udp        0      0 0.0.0.0:7400            0.0.0yo
udp        0      0 0.0.0.0:7400            0.0.0.0:*                           955/robot_state_pub 
udp        0      0 0.0.0.0:7400            0.0.0.0:*                           949/robot_state_hel 
udp        0      0 0.0.0.0:7400            0.0.0.0:*                           951/controller_stop 
udp        0      0 0.0.0.0:7412            0.0.0.0:*                           951/controller_stop 
udp        0      0 0.0.0.0:7413            0.0.0.0:*                           951/controller_stop 
udp        0      0 0.0.0.0:7414            0.0.0.0:*                           949/robot_state_hel 
udp        0      0 0.0.0.0:7415            0.0.0.0:*                           949/robot_state_hel 
udp        0      0 0.0.0.0:7418            0.0.0.0:*                           955/robot_state_pub 
udp        0      0 0.0.0.0:7419            0.0.0.0:*                           955/robot_state_pub 
udp        0      0 0.0.0.0:7420            0.0.0.0:*                           947/dashboard_clien 
udp        0      0 0.0.0.0:7421            0.0.0.0:*                           947/dashboard_clien 
udp        0      0 0.0.0.0:7422            0.0.0.0:*                           953/urscript_interf 
udp        0      0 0.0.0.0:7423            0.0.0.0:*                           953/urscript_interf 
udp        0      0 192.168.56.103:41146    0.0.0.0:*                           953/urscript_interf 
udp        0      0 0.0.0.0:42044           0.0.0.0:*                           951/controller_stop 
udp        0      0 0.0.0.0:43064           0.0.0.0:*                           955/robot_state_pub 
udp        0      0 192.168.56.103:45555    0.0.0.0:*                           949/robot_state_hel 
udp        0      0 0.0.0.0:46462           0.0.0.0:*                           949/robot_state_hel 
```

#conectarse al contendor,

```bash
docker exec -it moveit2_ur /bin/bash
#apt install net-tools
netstat -tulnp | grep 50002
```

https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver/

----


 docker network create --subnet=192.168.56.0/24 ursim_net

 docker network ls

docker network rm ursim_net

docker rmi universalrobots/ursim_cb3:latest

 ros2 run ur_client_library start_ursim.sh -m ur3


---

docker run --rm -d --net ursim_net --ip 192.168.56.101 -p 5900:5900 -p 6080:6080 -p 30001-30004:30001-30004  -p 29999:29999 --name ursim -e ROBOT_MODEL=UR3 -v "${HOME}/docker/ursim/programs:/ursim/programs" jcorredorc/ursim_cb3:external_control


docker run --rm -it -p 5900:5900 -p 6080:6080 -p 30001-30004:30001-30004  -p 29999:29999 --name ursim -e ROBOT_MODEL=UR3 -v "${HOME}/docker/ursim/programs:/ursim/programs" jcorredorc/ursim_cb3:external_control

ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur3 robot_ip:=192.168.0.100 launch_rviz:=false target_filename:="${HOME}/my_robot_calibration.yaml"

----

https://github.com/maffettone/erobs/tree/humble/docker

---

```bash
DOCKER_IMAGE=humble docker compose -f docker_compose_host.yml up -d ursim
```
# Container name: ursim_cb3
docker run --rm -it --name ursim_cb3 universalrobots/ursim_cb3 "control_log"


```bash
DOCKER_IMAGE=humble docker compose -f docker_compose_host.yml run --rm --name moveit2_ur gpu
```


```bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur3 robot_ip:=192.168.56.101 launch_rviz:=true
```

docker exec -it moveit2_ur /bin/bash




https://docs.ros.org/en/ros2_packages/humble/api/ur_robot_driver/doc/installation/ursim_docker.html#ursim-docker
https://hub.docker.com/r/universalrobots/ursim_cb3
