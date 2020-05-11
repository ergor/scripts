#!/bin/bash

install_path="$1"

if [ ! -d "$install_path" ]; then
    echo supplied argument is not a directory.
fi

# Set directory and subdirectories to full group perms.
chmod g+rwx "$install_path"
find "$install_path" -type d -exec chmod g+rwx {} \;

# Set all user executable files to allow execute for group as well.
find "$install_path" -type f -perm -u+x -exec chmod g+x {} \;

# Finally change to correct ownership
sudo chown -R root:users "$install_path"
