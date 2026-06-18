^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package ros1_message_mirror
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.8.0 (2026-06-18)
------------------
* Fix accessing get_ros1_messages from cmake (#7)
  This works with merged installs, but otherwise does not because the
  CMAKE_INSTALL_PREFIX points to the current package being build
  (json_msgs) for example, not ros1_message_mirror.
  Per Paul's comment, instead of using CMAKE_INSTALL_PREFIX we can
  export the correct path from ros1_message_mirror so dependent
  packages can find the script.
* Contributors: James Prestwood

0.7.0 (2026-03-03)
------------------

0.6.0 (2025-09-30)
------------------

0.5.0 (2025-06-06)
------------------
* Mirror actions using ros1_tools/ros1_message_mirror
* Restore python3 shebang
* Remove proprietary license from adapt_ros1_message
* Remove proprietary licenses
* Initial release to open source
* Contributors: Micaela Angeli, Paul Bovbel
