packer-definitions
==================

Builds Real Geeks virtual machines with all the puppet provisioning
already done.  Also serves as a smoke test for our puppet configuation.

Designed to be run from a CI server like jenkins

Usage:

1. Clone this repository
2. run `make`

`make` will clone a copy of RealGeeks/server_config so make sure you have permissions to access this repository.

Then, `make` will call `generate_http_files` which will generate a different kickstart file for each server defined in rgenvs.py.

We need a different kickstart file for each since the hostname is set by kickstart.

Finally, `make` will call `build.sh` which will call packer to build each of the hosts defined in `rgenvs.py`.

If you only want to build 1 host manually, you can call `build.sh` with the hostname of the machien you want to build.

