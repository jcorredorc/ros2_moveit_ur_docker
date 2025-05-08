FROM moveit/moveit2:main-humble-tutorial-source

# Instalar dependencias del sistema y ROS 2 necesarias
RUN apt-get update && apt-get install -y \
    ros-humble-joint-state-publisher-gui \
    ros-humble-joint-state-publisher \
    ros-humble-xacro \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-position-controllers \
    ros-humble-force-torque-sensor-broadcaster \
    ros-humble-controller-manager \
    ros-humble-hardware-interface \
    ros-humble-forward-command-controller \
    ros-humble-realtime-tools \
    ros-humble-ur \
    telnetd \
    iputils-ping \
    python3-colcon-common-extensions \
    python3-vcstool \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Crear el workspace
WORKDIR /ws

# Copiar archivo .repos al contenedor
COPY ur_driver.repos .

# Clonar todos los repositorios necesarios con vcs
COPY ur_driver.repos /ws/ur_driver.repos
WORKDIR /ws
RUN mkdir -p src && vcs import src < ur_driver.repos || cat src/.rosinstall

# Install dependencies
RUN apt-get update && rosdep install --from-paths src --ignore-src -r -y

# Build workspace
RUN . /opt/ros/humble/setup.sh && \
    rm -rf build install log && \
    colcon build --event-handlers console_direct+

# Compilar el workspace
#RUN bash -c "source /opt/ros/humble/setup.bash && colcon build --symlink-install"
#RUN bash -c "source /opt/ros/humble/setup.bash && colcon build --symlink-install --event-handlers console_direct+"
# RUN . /opt/ros/humble/setup.sh && \
#     rm -rf build install log && \
#     colcon build --event-handlers console_direct+


# Configurar entorno por defecto al iniciar el contenedor
ENV ROS_WS=/ws
CMD ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && source /ws/install/setup.bash && exec bash"]
