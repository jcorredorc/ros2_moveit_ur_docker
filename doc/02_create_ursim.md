

# crear el contenedor docker

este archivo esta [aqui](../ursim_cb3/docker_ursim_cb3)

```docker
FROM universalrobots/ursim_cb3

# Install the URCap
COPY externalcontrol-1.0.5.urcap /urcaps/externalcontrol-1.0.5.jar
```

```
docker build -f docker_ursim_cb3 -t ursim_cb3 .
```

Revisar que se encuentre la imagen que se acada de crear

```
docker images
```

Ejecutar la imagen,

```
# VNC port: 5900
# Web browser VNC port: 6080
docker run --rm -it -p 5900:5900 -p 6080:6080 -v ${HOME}/docker/ursim/programs:/ursim/programs ursim_cb3

```

Crear un terminal en el contenedor
```
docker exec -it 5aa4d2b33dbd /bin/bash
```

# links de interés

[descara de external control](https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap/releases)

[Instrucciones instalar en el robot](https://github.com/UniversalRobots/Universal_Robots_ROS_Driver/blob/master/ur_robot_driver/doc/install_urcap_cb3.md)

[Instrucciones para instalar y usar el simulador ursim_cb3](https://hub.docker.com/r/universalrobots/ursim_cb3)

[External Control Urcap para URSim](https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap/releases)