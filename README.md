# estos-kurento-scripts
Basic shell scripts for building all needed kurento modules for estos usage.
These scripts are in a VERY basic form, but functional.

To build the Windows version, you will need a Fedora 24 system.
At the moment we recommend a virtual machine as a build machine for the media server. We do not guarantee that there are no side effects on other software on this machine.

Use this software at your own risc.

## Usage
Checkout these scripts in a new Directory. Running first time, execute the **initsystem.sh** script, which will check and install system dependencies (like mingw32 and such) needed for cross compiling the Kurento Media Server. This have to be done only once (or later for possible updates on these dependencies).

To Compile the Media Server and its DLLs, call **build.sh** in the same directory. This will fetch and compile all Module needed. DO NOT RUN WITH ROOT-PRIVILIGES! The Scripts are asking for them when needed.

To get a distribution package call **makedist.sh**, which will assemble all parts generated with build.sh into a subdirectory and compress it into a zip file named *kurento.zip*.
Copy this file to a Windows machine, unzip it into a own Directory and start the kurento media server in the bin directory.

You can now test the server using the [Kurento Tutorials](http://doc-kurento.readthedocs.io/en/stable/tutorials.html). The server will be reachable on localhost, port 8888. The Portnumber can be configured in kurento.conf.json, which is located in the etc/kurento directory.

## License
These Scripts are Copyright 2016 estos GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Licenses of Kurento and used Libraries
The Kurento Media Server ist [licensed under Apache 2.0 License](https://www.kurento.org/blog/kurento-650-released-all-freedom-apache-20-license).
The licenses of the used libraries are listet under "liblicenses".
