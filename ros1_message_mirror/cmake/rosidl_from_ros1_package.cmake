macro(rosidl_from_ros1_package package)

  cmake_parse_arguments(args "" "" "DEPENDENCIES;ENTITIES" ${ARGN})

  find_package(rosidl_default_generators REQUIRED)
  find_package(builtin_interfaces REQUIRED)

  foreach(dependency ${args_DEPENDENCIES})
    find_package(${dependency})
  endforeach()

  # TODO(pbovbel) register bin path
  set(bin_path ${CMAKE_INSTALL_PREFIX}/lib/ros1_message_mirror)

  set(message_types "msg" "srv")

  foreach(message_type ${message_types})
    execute_process(COMMAND ${bin_path}/get_ros1_messages ${package} --type ${message_type}
      OUTPUT_VARIABLE ${message_type}_ROS1_LIST
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    set(${message_type}_ROS2_LIST "")

    file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${message_type}/")

    foreach(input_message ${${message_type}_ROS1_LIST})
      stamp(${input_message})  # Reconfigure if the upstream message file changes
      get_filename_component(filename ${input_message} NAME)

      if(args_ENTITIES AND NOT filename IN_LIST args_ENTITIES)
        continue()
      endif()

      execute_process(
        COMMAND ${bin_path}/adapt_ros1_message ${input_message} ${CMAKE_BINARY_DIR}/${message_type}/${filename}
        OUTPUT_VARIABLE output_message
        OUTPUT_STRIP_TRAILING_WHITESPACE
      )

      # TODO(pbovbel) automatically generate mapping_rules.yaml
      list(APPEND ${message_type}_ROS2_LIST ${output_message})

    endforeach()
  endforeach()

  # How does rosidl know if something's a srv or msg? By the file extension?
  # No! by the containing directory! *facepalm*
  # https://github.com/ros2/rosidl/issues/213
  if(msg_ROS2_LIST OR srv_ROS2_LIST)
    rosidl_generate_interfaces(${package}
      ${msg_ROS2_LIST}
      ${srv_ROS2_LIST}
      DEPENDENCIES ${args_DEPENDENCIES} builtin_interfaces
      ADD_LINTER_TESTS
    )
  else()
    message(FATAL_ERROR "No interface files imported from ROS1 package ${package}")
  endif()

  ament_export_dependencies(rosidl_default_runtime)
endmacro()
