# ros1_tools

## ros1_message_mirror

Provides the `rosidl_from_ros1_package` cmake macro, allowing one to easily clone message definitions from ROS1 into ROS2

```cmake
...
find_package(ros1_message_mirror REQUIRED)

rosidl_from_ros1_package(
  # Specify the dependencies of the messages and services we need ot build.
  DEPENDENCIES std_msgs

  # Whitelist only certain messages or services for mirroring, useful if mirroring _all_ entities breaks the build process.
  ENTITIES "TriggerSnapshot.srv"
)
...
```
