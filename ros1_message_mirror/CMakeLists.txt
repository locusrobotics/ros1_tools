cmake_minimum_required(VERSION 3.5)
project(ros1_message_mirror)

if(NOT WIN32)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wall -Werror")
endif()

find_package(ament_cmake REQUIRED)

ament_python_install_package(${PROJECT_NAME})

install(
  DIRECTORY cmake
  DESTINATION share/${PROJECT_NAME}
)

install(
  PROGRAMS
    scripts/adapt_ros1_message
    scripts/get_ros1_messages
  DESTINATION lib/${PROJECT_NAME}
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)

  # Ignore copyright linting, for now
  set(ament_cmake_copyright_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package(
  CONFIG_EXTRAS ros1_message_mirror-extras.cmake
)
