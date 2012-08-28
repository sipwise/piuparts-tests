#!/bin/sh

# Avoid:
#  ERROR: FAIL: Package purging left files on system:
#   /etc/apt/preferences.d/sipwise         not owned
#   /etc/apt/sources.list.d/sipwise.list   not owned
# esp. when running piuparts without --warn-on-leftovers-after-purge

# run only after upgrade tests, after installation we need the repository
# information to have packages available for upgrade tests
if [ "$PIUPARTS_PHASE" = "upgrade" ] ; then
  echo "*** Removing sources.list/apt preference files as running upgrade tests ***"
  rm -f /etc/apt/preferences.d/sipwise /etc/apt/sources.list.d/sipwise.list
else
  echo "*** Not removing sources.list/apt preference files as not running upgrade tests ***"
fi

## END OF FILE #################################################################
