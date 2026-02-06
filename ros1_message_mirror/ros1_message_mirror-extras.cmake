include("${CMAKE_CURRENT_LIST_DIR}/find_ros1_package.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/rosidl_from_ros1_package.cmake")

# Export the lib directory so other packages can get the correct path for
# scripts under .../lib/
# CMAKE_CURRENT_LIST_DIR points to .../share/ros1_message_mirror/cmake,
# we need .../lib/ros1_message_mirror.
get_filename_component(up1 "${CMAKE_CURRENT_LIST_DIR}" DIRECTORY)       # .../share/ros1_message_mirror
get_filename_component(up2 "${up1}" DIRECTORY)                          # .../share
get_filename_component(ros1_message_mirror_PREFIX "${up2}" DIRECTORY)   # .../<prefix>

set(ros1_message_mirror_LIBEXEC_DIR
  "${ros1_message_mirror_PREFIX}/lib/ros1_message_mirror")
