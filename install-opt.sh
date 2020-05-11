#!/bin/bash

# Set all directories to full group perms.
#1: find . -type d -exec chmod g+rwx {} \;

# Set all user executable files to allow execute for group as well.
#2: find . -type f -perm -u+x -exec chmod g+x {} \;

# Finally change to correct ownership
#3: chown -R root:users
