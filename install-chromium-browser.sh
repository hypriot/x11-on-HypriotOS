#!/bin/bash
set +x
set -e

echo ""
echo "Installing Chromium web browser on HypriotOS/X11"
CHROMIUM_BASEURL=https://launchpad.net/~canonical-chromium-builds/+archive/ubuntu/stage/+build/10468838/+files
CHROMIUM_DEB_FILE1=chromium-codecs-ffmpeg-extra_51.0.2704.106-0ubuntu0.15.04.1.1207_armhf.deb
CHROMIUM_DEB_FILE2=chromium-browser_51.0.2704.106-0ubuntu0.15.04.1.1207_armhf.deb

# --------------------------------------------------------------------
echo ""
echo " STEP 1: download Chromium .deb packages"
if [ ! -f /tmp/${CHROMIUM_DEB_FILE1} ]; then
  curl -Lo /tmp/${CHROMIUM_DEB_FILE1} ${CHROMIUM_BASEURL}/${CHROMIUM_DEB_FILE1}
fi
if [ ! -f /tmp/${CHROMIUM_DEB_FILE2} ]; then
  curl -Lo /tmp/${CHROMIUM_DEB_FILE2} ${CHROMIUM_BASEURL}/${CHROMIUM_DEB_FILE2}
fi
echo "...done"

# --------------------------------------------------------------------
echo ""
echo " STEP 2: install Chromium .deb packages, first try"
# deactivate error check for this run!
set +e
sudo dpkg -i \
  /tmp/${CHROMIUM_DEB_FILE1} \
  /tmp/${CHROMIUM_DEB_FILE2}
set -e
echo "...done"

# --------------------------------------------------------------------
echo ""
echo " STEP 3: now install all dependent packages (apt-get install -y -f)"
sudo apt-get install -y -f
echo "...done"

# --------------------------------------------------------------------
echo ""
echo " STEP 4: install Chromium .deb packages, second try"
sudo dpkg -i \
  /tmp/${CHROMIUM_DEB_FILE1} \
  /tmp/${CHROMIUM_DEB_FILE2}
echo "...done"

# --------------------------------------------------------------------
echo ""
echo " STEP 5: remove Chromium .deb packages"
rm -f \
  /tmp/${CHROMIUM_DEB_FILE1} \
  /tmp/${CHROMIUM_DEB_FILE2}
echo "...done"

# --------------------------------------------------------------------
echo ""
echo "...Chromium installation done"

