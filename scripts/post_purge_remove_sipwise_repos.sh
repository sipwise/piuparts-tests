#!/bin/sh

# Avoid:
#  ERROR: FAIL: Package purging left files on system:
#   /etc/apt/preferences.d/sipwise         not owned
#   /etc/apt/sources.list.d/sipwise.list   not owned
# esp. when running piuparts without --warn-on-leftovers-after-purge

rm -f /etc/apt/preferences.d/sipwise /etc/apt/sources.list.d/sipwise.list

## END OF FILE #################################################################
