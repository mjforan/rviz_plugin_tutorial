ARG ROS_DISTRO=jazzy
FROM ros:${ROS_DISTRO}-ros-base
SHELL ["/bin/bash", "-c"]
WORKDIR /colcon_ws
COPY ./colcon_entrypoint.sh /colcon_entrypoint.sh
ENTRYPOINT ["/colcon_entrypoint.sh"]

RUN apt update; \
    rosdep update;

COPY rviz_plugin_tutorial ./src/rviz_plugin_tutorial
COPY rviz_plugin_tutorial_msgs ./src/rviz_plugin_tutorial_msgs
RUN apt update && rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y && apt install -y ros-${ROS_DISTRO}-rviz2

RUN source /ros_entrypoint.sh; \
    colcon build --symlink-install
