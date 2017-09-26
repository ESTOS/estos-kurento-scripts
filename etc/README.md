
# estos-kurento-scripts
Basic shell scripts for building all needed kurento modules for estos usage.
These scripts are in a VERY basic form, but functional.

To build the Windows version, you will need a Fedora 24 system.
At the moment we recommend a virtual machine as a build machine for the media server. We do not guarantee that there are no side effects on other software on this machine.

Use this software at your own risc.

## Usage
Checkout these scripts in a new Directory. Running first time, execute the **initsystem.sh** script, which will check and install system dependencies (like mingw32 and such) needed for cross compiling the Kurento Media Server. This have to be done only once (or later for possible updates on these dependencies).

To Compile the Media Server and its DLLs, call **build.sh** in the same directory. This will fetch and compile all Module needed. DO NOT RUN WITH ROOT-PRIVILIGES! The Scripts are asking for them when needed.

To get a distribution package call **makedist.sh**, which will assemble all parts generated with build.sh into a subdirectory and compress it into a zip file named *emswindows_current-timestamp.zip*.
Copy this file to a Windows machine, unzip it into a own Directory and start the estos uc media server in the bin directory.

You can now test the server using the [Kurento Tutorials](http://doc-kurento.readthedocs.io/en/stable/tutorials.html). The server will be reachable on localhost, port 8888. The Portnumber can be configured in kurento.conf.json, which is located in the etc/kurento directory.

Further builds shoud be made using either **rebuild.sh** (if you made local changes) or **update.sh + rebuild.sh** (if you need updates from the repositories).

**lastcommits.sh** is used by **makedist.sh** to get information about the last commits in the respositories to make it possible to reproduce each build.


## License
estos uc-media-service is based on the kurento media server.
Licensed under the Apache License, Version 2.0 (the "License");

See **NOTICE.txt** and **LICENSE-2.0.txt** for Details.

### Licenses of Kurento and used Libraries
The Kurento Media Server is [licensed under Apache 2.0 License](https://www.kurento.org/blog/kurento-650-released-all-freedom-apache-20-license).
The licenses of the used 3rd-party libraries are listet under **etc/liblicenses**.
