cmake_minimum_required(VERSION 3.5)
project(rosbag_snapshot_msgs)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

find_package(ament_cmake REQUIRED)
find_package(ros1_message_mirror REQUIRED)

rosidl_from_ros1_package(${PROJECT_NAME}
  ENTITIES
    # SnapshotStatus.msg contains a reference to topic_statistics messages that don't exist in ROS1
    "TriggerSnapshot.srv"
  DEPENDENCIES
    builtin_interfaces
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)

  # Ignore copyright linting, for now
  set(ament_cmake_copyright_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package()
