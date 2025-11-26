===========================================================
             FPC libfprint driver for Linux
===========================================================


================
DESCRIPTION
================

This package is a Linux based package to install FPC Fingerprint driver and it also
upgrades device firmware and sensor firmware.

Support:
ubuntu OS:20.04
fprintd:1.90.9.1

ubuntu OS:22.04
fprintd:1.94.2-2

================
Release Materials
================
1. .\usr\lib\x86_64-linux-gnu\libfprint-2.so.*
	Compliance with LGPL2.1 (.\LICENCE-LGPL2.1.txt)
	Source Codes: https://github.com/fingerprint-cards/libfprint/commit/ad1933814a775c11f9581507910bae525c67ff2a

2. .\lib\udev\rules.d\60-libfprint-2-device-fpc.rules
	Configuration file

3. .\install.sh
	installation script

================
Ubuntu 20.04 LVFS installation
================
1. sudo apt update && sudo apt install git
2. git clone https://github.com/fwupd/fwupd.git && cd fwupd
3. ./contrib/setup（download kinds of software to prepare the enviroment. This will take some time!）
4. sudo apt-get install libgcab-dev gcab valac libjcat-dev libpci-dev curl libcurl4-gnutls-dev libftdi1-dev liblzma-dev libgirepository1.0-dev gtk-doc-tools gettext
5. mkdir build && cd build
6. sudo apt install python3-pip
7. sudo apt remove meson
8. sudo pip3 install meson
9. sudo cp /usr/local/bin/meson /usr/bin/ && meson
10. sudo ninja install
11. cd src
12. sudo ./fwupd --verbose (start the fwupd service, don't stop it)
13. sudo ./fwupdmgr refresh --force (start the other terminal to type this command)
14. sudo ./fwupdmgr get-devices (get device id)
15. sudo apt remove fwupd
16. sudo cp /usr/local/share/polkit-1/actions/org.freedesktop.fwupd.policy /usr/share/polkit-1/actions/org.freedesktop.fwupd.policy
17. sudo cp /usr/local/share/polkit-1/rules.d/org.freedesktop.fwupd.rules /usr/share/polkit-1/rules.d/org.freedesktop.fwupd.rules
18. sudo ./fwupdmgr install $DEVICEID (choose y to start firmware upgrading)

================
Ubuntu 22.04 LVFS installation
================
1. sudo apt update && sudo apt install git
2. git clone https://github.com/fwupd/fwupd.git && cd fwupd
3. ./contrib/setup(download kinds of software to prepare the enviroment. This will take some time!)
4. sudo apt-get install libgcab-dev gcab valac libjcat-dev libpci-dev curl libcurl4-gnutls-dev libftdi1-dev liblzma-dev libgirepository1.0-dev gtk-doc-tools gettext
5. mkdir build && cd build
6. meson
7. sudo ninja install
8. cd src
9. sudo ./fwupd --verbose (start the fwupd service, don't stop it)
10. sudo ./fwupdmgr refresh --force (start the other terminal to type this command)
11. sudo ./fwupdmgr get-devices (get device id)
12. sudo apt remove fwupd
13. sudo cp /usr/local/share/polkit-1/actions/org.freedesktop.fwupd.policy /usr/share/polkit-1/actions/org.freedesktop.fwupd.policy
14. sudo cp /usr/local/share/polkit-1/rules.d/org.freedesktop.fwupd.rules /usr/share/polkit-1/rules.d/org.freedesktop.fwupd.rules
15. sudo ./fwupdmgr install $DEVICEID (choose y to start firmware upgrading)

================
libfprint installation
================
1. sudo chmod 755 install.sh
2. ./install.sh

================
GETTING STARTED
================

The installation package
-------------------
The installation package is named FPC_driver_linux_libfprint.zip


Fingerprint enroll & identify
-----------------------------
Enroll:
  Fingerprint enroll enable option is present at settings, it can be easily located using search option with string "users"
  Enroll the fingerprint and follow the GUI guidelines to enroll the finger and post enroll, close the Fingerprint GUI.

Identify:
  Press "WIN + L" key on keyboard to lock the computer, user can login to computer using Fingerprint option at login screen.

Note:
1. If install driver correctly, please run: "sudo systemctl restart fprintd.service" to restart the fprintd service
2. (date: 1/10/23) fwupd may be built error. The error message is :
   " [1/6] Generating docs/doc-fwupd with a custom command
   FAILED: docs/libfwupd..."
The way suggested to solve the comiling error is :
   1) vi ./fwupd/subprojects/gi-docgen/gidocgen/gidocmain.py
   2) comment the line 73-85 and add "return 0"
The commit id the problem will be met is : 2627e8ab6a8dd779f0e494bd0f6ff9dd76fa70cb
