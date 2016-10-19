#!/bin/bash
set +x
set -e

OPTION=${1}
DEFAULT="-pi2"

PI2_FBTURBO_SHA256=2c919c28735bf2f694580bfa7ff79fee7b9da11b6f62d81f871ff0c6e6e1c0f1
PI3_FBTURBO_SHA256=aa276f213bb6d64269d1828cb520d27050c5582d1d57d5b1a4356709399f6531
PI3_XORG_CONF_SHA256=d757fb4efd14fe1cf5b3892378a939b9d4119b50eb8e74e80b5e4562b95cceef

PI_VERSION=$(echo "${OPTION:-${DEFAULT}}" | sed 's/-//')
PI_VERSION_FBTURBO_SHA256=$(eval "echo $(echo "\${${PI_VERSION}_FBTURBO_SHA256}" | awk '{print toupper($0)}')")

echo "PI_VERSION=${PI_VERSION}"
echo "PI_VERSION_FBTURBO_SHA256=${PI_VERSION_FBTURBO_SHA256}"

usage() {

    cat << EOF

Usage: ${0} [options]

Options:
    -pi2        Installing x11 on a RaspberryPi 2 (This is the default if no option is supplied.)
    -pi3        Installing x11 on a RaspberryPi 3

EOF

}

case "${OPTION}" in

    -h|-help|--h|--help)
        usage
        exit 0
        ;;

esac

echo ""
echo "Installing basic X11 packages on HypriotOS"

# --------------------------------------------------------------------
echo ""
echo " STEP 1: create a /boot/config.txt"
CONFIG_TXT_FILE=/boot/config.txt
if [ ! -f ${CONFIG_TXT_FILE} ]; then

cat << EOF | sudo tee ${CONFIG_TXT_FILE} >/dev/null
display_rotate=0	# normal HDMI displays
#display_rotate=2	# 7" Touch Screen display from RaspberryPi.Org
EOF

fi
cat ${CONFIG_TXT_FILE}
echo "...done"


# --------------------------------------------------------------------
echo ""
echo " STEP 2: install X11 and LightDM"
sudo apt-get update
sudo apt-get install -y --no-install-recommends xserver-xorg xinit xserver-xorg-video-fbdev lxde lxde-common lightdm x11-xserver-utils dbus-x11
sudo apt-get install -y policykit-1 hal
echo "...done"


# --------------------------------------------------------------------
echo ""
echo " STEP 3: enable LightDM autologin for user=pirate"
LIGHTDM_CONF_FILE=/etc/lightdm/lightdm.conf
if [ ! -f ${LIGHTDM_CONF_FILE}.sav ]; then
  # backup original file
  sudo mv ${LIGHTDM_CONF_FILE} ${LIGHTDM_CONF_FILE}.sav

cat << EOF | sudo tee ${LIGHTDM_CONF_FILE} >/dev/null
[SeatDefaults]
autologin-user=pirate
autologin-user-timeout=0
EOF

fi
cat ${LIGHTDM_CONF_FILE}
echo "...done"


# --------------------------------------------------------------------
echo ""
echo " STEP 4: install pre-compiled fbturbo"
FBTURBO_TAR_URL=https://github.com/hypriot/x11-on-HypriotOS/raw/master/fbturbo/${PI_VERSION}/fbturbo.tar.gz
FBTURBO_TAR_TMPFILE=/tmp/fbturbo.tar.gz
curl -Lo ${FBTURBO_TAR_TMPFILE} ${FBTURBO_TAR_URL}
echo "${PI_VERSION_FBTURBO_SHA256}  ${FBTURBO_TAR_TMPFILE}" | sha256sum -c
sudo tar xvf ${FBTURBO_TAR_TMPFILE} -C /
rm -f ${FBTURBO_TAR_TMPFILE}
echo "...done"


# --------------------------------------------------------------------
if [ "${PI_VERSION}" == "pi3" ]; then

    echo ""
    echo " STEP 5: update xorg.conf (pi3 only)"
    XORG_CONF_URL=https://github.com/hypriot/x11-on-HypriotOS/raw/master/fbturbo/${PI_VERSION}/xorg.conf
    XORG_CONF_TMPFILE=/tmp/xorg.conf
    curl -Lo ${XORG_CONF_TMPFILE} ${XORG_CONF_URL}
    echo "${PI3_XORG_CONF_SHA256}  ${XORG_CONF_TMPFILE}" | sha256sum -c
    sudo mv ${XORG_CONF_TMPFILE} /etc/X11/xorg.conf
    echo "...done"

fi

# --------------------------------------------------------------------
echo ""
echo "...X11 installation done, please reboot"
