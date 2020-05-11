#!/bin/bash

install_path="$1"

if [ $(whoami) != "root" ] ; then
      echo sorry, you must be root to run this script. >&2
      exit 1
fi

if [ ! -d "$install_path" ]; then
    echo supplied argument is not a directory. >&2
    exit 1
fi

# Set directory and subdirectories to full group perms.
chmod g+rwx "$install_path"
find "$install_path" -type d -exec chmod g+rwx {} \;

# Set all user writable files to allow write for group as well
find "$install_path" -type f -perm -u+w -exec chmod g+w {} \;

# Set all user readable files to allow read for group as well
find "$install_path" -type f -perm -u+r -exec chmod g+r {} \;

# Set all user executable files to allow execute for group as well.
find "$install_path" -type f -perm -u+x -exec chmod g+x {} \;

# Finally change to correct ownership
chown -R root:users "$install_path"

