# x11-on-HypriotOS
Instructions how to use X11 on a HypriotOS based Raspberry Pi system

This repo contains some scripts and detailled instructions on how to install and use X11 windows manager on a HypriotOS based Raspberry Pi system

Our main intention for HypriotOS for us was, to build a minimal server operating system for the 
Raspberry Pi, which contains all the necessary tools and packages to run Docker out-of-the-box. 
For this reason we didn't include X11 and other graphical application in the default SD card image.

But it's really easy to install all X11 utilities, if you'd like to connect a HDMI monitor or the official 7" touch screen display from the Raspberry Pi Org.


## Installing X11 and LightDM on HypriotOS
Running the installer script need sudo privileges for some elevated commands.
```
wget https://github.com/hypriot/x11-on-HypriotOS/raw/master/install-x11-basics.sh
chmod +x install-x11-basics.sh
./install-x11-basics.sh
```
