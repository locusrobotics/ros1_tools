# Copyright 2015-2016 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import os
import sys

# import rospkg which is required by rosmsg
# and likely only available for Python 2
try:
    import rospkg
except ImportError:
    from importlib.machinery import SourceFileLoader
    import subprocess
    for python_executable in ['python2', 'python2.7']:
        try:
            rospkg_path = subprocess.check_output(
                [python_executable, '-c', 'import rospkg; print(rospkg.__file__)'])
        except (subprocess.CalledProcessError, FileNotFoundError):
            continue
        rospkg_path = rospkg_path.decode().strip()
        if rospkg_path.endswith('.pyc'):
            rospkg_path = rospkg_path[:-1]
        rospkg = SourceFileLoader('rospkg', rospkg_path).load_module()
    if not rospkg:
        raise

# more ROS 1 imports
# since ROS 2 should be sourced after ROS 1 it will overlay
# e.g. the message packages, to prevent that from happening (and ROS 1 code to
# fail) ROS 1 paths are moved to the front of the search path
rpp = os.environ.get('ROS_PACKAGE_PATH', '').split(os.pathsep)
for package_path in reversed([p for p in rpp if p]):
    if not package_path.endswith(os.sep + 'share'):
        continue
    ros1_basepath = os.path.dirname(package_path)
    for sys_path in sys.path:
        if sys_path.startswith(os.path.join(ros1_basepath, '')):
            sys.path.remove(sys_path)
            sys.path.insert(0, sys_path)
import rosmsg  # noqa



extension_to_rosmsg_mode = {
    'msg': rosmsg.MODE_MSG,
    'srv': rosmsg.MODE_SRV,
}


def get_ros1_message_paths(package, extension):
    rospack = rospkg.RosPack()
    mode = extension_to_rosmsg_mode[extension]
    path = os.path.join(rospack.get_path(package), extension)
    msgs = rosmsg.list_types(package, mode, rospack)
    return [os.path.join(path, msg.split('/')[-1] + '.' + extension) for msg in msgs]
