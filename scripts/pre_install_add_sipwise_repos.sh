#!/bin/sh

# Environment variables we can use/access:
#  PIUPARTS_DISTRIBUTION=squeeze
#  PIUPARTS_TEST=install
#  PIUPARTS_OBJECTS=/tmp/ngcp-ngcpcfg_0.11.1+0~5.svn6595_all.deb
#  PIUPARTS_PHASE=install
#  PIUPARTS_DISTRIBUTION_NEXT
#  PIUPARTS_DISTRIBUTION_PREV

set -e

default_release=3.1

if [ -z "$release" ] ; then
  release="$default_release"
  echo "*** No release variable set, using default [$release] ***"
fi

# make sure we can rely on wget being present for checks
type wget >/dev/null 2>&1 || apt-get -y install wget

case "$release" in
  trunk)
       echo "*** release variable is set to trunk, enabling TRUNK_RELEASE ***"
       TRUNK_RELEASE=true
       echo "*** Installing autobuild signing key for release-trunk repository ***"
       wget -O - http://deb.sipwise.com/autobuild/EE5E097D.asc | apt-key add -
       [ -n "$distribution" ] || distribution="wheezy"
       ;;
     2.*) [ -n "$distribution" ] || distribution="squeeze"
       ;;
     *) [ -n "$distribution" ] || distribution="wheezy"
       ;;
esac

echo "*** Testing availability of Debian repository for release $release ***"
if wget -O /dev/null http://deb.sipwise.com/spce/${release}/dists/${distribution}/main/binary-amd64/Packages ; then
  echo "*** Repository for release $release seems to be available, accepting. ***"
else
  echo "*** WARNING: Repository for requested release $release does not seem to exist. ***"
  echo "***          Falling back to default release $default_release now. ***"
  release="$default_release"
fi

cat > /etc/apt/preferences.d/sipwise << EOF
Package: *
Pin: origin deb.sipwise.com
Pin-Priority: 990
EOF

if [ -n "$TRUNK_RELEASE" ] ; then
  echo "*** TRUNK_RELEASE is set, using ***"
  cat > /etc/apt/sources.list.d/sipwise.list << EOF
# NGCP_MANAGED_FILE - do not remove this line if it should be automatically handled

# Sipwise repository
deb http://deb.sipwise.com/autobuild/ release-trunk main

# Sipwise ${distribution} backports
deb http://deb.sipwise.com/${distribution}-backports/ ${distribution}-backports main
EOF

else # no $TRUNK_RELEASE
  echo "*** TRUNK_RELEASE is NOT set, using $release ***"
  cat > /etc/apt/sources.list.d/sipwise.list << EOF
# NGCP_MANAGED_FILE - do not remove this line if it should be automatically handled

# Sipwise repository
# deb http://deb.sipwise.com/autobuild/ release-trunk main
deb http://deb.sipwise.com/spce/${release}/ ${distribution} main
deb http://deb.sipwise.com/sppro/${release}/ ${distribution} main

# Sipwise ${distribution} backports
deb http://deb.sipwise.com/${distribution}-backports/ ${distribution}-backports main
EOF
fi

apt-get update
apt-get --allow-unauthenticated -y install ngcp-keyring
apt-get update

## END OF FILE #################################################################
