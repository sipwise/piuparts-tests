#!/bin/sh

echo "Making sure the chroot is up2date (piuparts until at least v0.66 is affected, see #798266):"
apt-get -yf dist-upgrade
