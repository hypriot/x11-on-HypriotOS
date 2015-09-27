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

## 2. Installing Chromium web browser on HypriotOS/X11
Running the installer script need sudo privileges for some elevated commands.
```
curl -sSL https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-chromium-browser.sh | bash
```
This takes approx. 15 minutes only.


Hypriot team, 2015
