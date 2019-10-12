#!/usr/bin/env bash
set -e

if [ $# -eq 0 ]; then
    cmd=("/bin/bash") # default command
else
    cmd=("$@")
fi

USER=${USER:-bootstrap}
USER_UID=${USER_UID:-65535}
USER_GID=${USER_GID:-65535}

# Check if the current user has an entry in the /etc/passwd and /etc/group 
# files, if not add new entries. This allow us to support arbitrary user id to 
# easily match the host and guest file system permissions.
if [ "${USER_UID}" != "65535" ] && [ "${USER_GID}" != "65535" ]; then
    if [ -w /etc/passwd ]; then
        echo "${USER}:x:${USER_UID}:${USER_GID}:${USER}:${HOME}:/bin/bash" >> /etc/passwd
    fi
    if [ -w /etc/group ]; then
        echo "${USER}:x:${USER_GID}:" >> /etc/group
    fi
fi

# Fix home permission
chown -R ${USER_UID}:${USER_GID} /home/bootstrap

# Drop root and execute command
exec gosu ${USER_UID}:${USER_GID} "${cmd[@]}"
