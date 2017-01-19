# x11-on-HypriotOS
Instructions how to install X11 on a HypriotOS based Raspberry Pi system

This repo contains some scripts and detailled instructions on how to install and use X11 windows manager on a HypriotOS based Raspberry Pi system

Our main intention for HypriotOS for us was, to build a minimal server operating system for the 
Raspberry Pi, which contains all the necessary tools and packages to run Docker out-of-the-box. 
For this reason we didn't include X11 and other graphical application in the default SD card image.

But it's really easy to install all X11 utilities, if you'd like to connect a HDMI monitor or the official 7" touch screen display from the Raspberry Pi Org.

Credits:
these details are based on blog post [Jessie on Raspberry PI 2 with Docker and Chromium](https://medium.com/@icebob/jessie-on-raspberry-pi-2-with-docker-and-chromium-c43b8d80e7e1) by user [icebob](https://medium.com/@icebob).


## 1. Installing X11 and LightDM on HypriotOS

### For RaspberryPi 2

Running the installer script need sudo privileges for some elevated commands.
```
curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-x11-basics.sh | bash
```
Depending on your internet connection this installation procedure takes approx. 10 minutes only.

Please reboot your system now to start X11 on your attached HDMI display.

Disk usage for installing X11 and LightDM on a freshly flashed HypriotOS, here we've used a 8 GByte SD card:
 - before installing
```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       6.9G  743M  5.9G  12% /
```
 - with X11 installed
```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       6.9G  1.1G  5.5G  17% /
```

### For RaspberryPi 3

Running the installer script need sudo privileges for some elevated commands.
```
curl -Lso /tmp/install-x11-basics.sh -H "Cache-Control: no-cache" https://raw.githubusercontent.com/hypriot/x11-on-HypriotOS/master/install-x11-basics.sh && \
chmod +x /tmp/install-x11-basics.sh && \
/tmp/install-x11-basics.sh -pi3
/tmp/install-x11-basics.sh -pi3
```
Depending on your internet connection this installation procedure takes approx. 10 minutes only.

Please reboot your system now to start X11 on your attached HDMI display.

- with X11 installed (8 GByte SD Card)
```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.0G  950M  5.7G  15% /
```

## 2. Installing Chromium web browser on HypriotOS/X11
Running the installer script need sudo privileges for some elevated commands.
```
curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-chromium-browser.sh | bash
```
This takes approx. 5 minutes only.


Hypriot team, 2015

## Re-Compiling fbturbo

If you have fbturbo errors, you'll likely need get a fresh compile for your architecture. On your installation target, do the following:

1. Follow the: [fbturbo Driver Installation](https://github.com/ssvb/xf86-video-fbturbo/wiki/Installation) guide
1. Run the `fbturbo/fbturbo-create-tar.sh` script, on the same host you used to install fbturbo.
1. Capture the SHA-256 Sum of the newly created `fbturbo.tar.gz`, and update the `install-x11-basics.sh` script.
1. Verify that the `xorg.conf` hasn't changed, if it has, capture its SHA-256, and update `install-x11-basics.sh`