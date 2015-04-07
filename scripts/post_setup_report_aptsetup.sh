#!/bin/sh

for file in /etc/apt/preferences /etc/apt/preferences.d/* ; do
  [ -r "$file" ] || continue
  echo "*** Displaying $file as reference: ***"
  cat "$file"
  echo "*** End of $file ***"
done

echo "*** Displaying apt-cache policy as reference: ***"
apt-cache policy
echo "*** End of apt-cache policy ***"

for file in /etc/apt/sources.list /etc/apt/sources.list.d/*.list ; do
  [ -r "$file" ] || continue
  echo "*** Displaying $file as reference: ***"
  cat "$file"
  echo "*** End of $file ***"
done
