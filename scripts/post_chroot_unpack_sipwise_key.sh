#!/bin/sh

echo "** Executing $0 to fix apt-key usage after bootstrapping/unpacking chroot **"

echo "** Running apt-get update to make sure we have up2date package information available **"
apt-get update

# make sure we can rely on wget being present for checks
echo "** Installing wget **"
which wget >/dev/null 2>&1 || apt-get --allow-unauthenticated -y install wget

echo "** Setting up http://deb.sipwise.com/autobuild/680FBA8A.asc for apt-get usage **"
wget -O - http://deb.sipwise.com/autobuild/680FBA8A.asc | apt-key add -

echo "** Setting up http://deb.sipwise.com/autobuild/F411A836.asc for apt-get usage **"
wget -O - http://deb.sipwise.com/autobuild/F411A836.asc | apt-key add -

echo "** Running apt-get update to have a verified Debian repository available **"
apt-get update
