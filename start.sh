#!/usr/bin/env bash

# ssh-keygen -t ed25519 -C "your_email@example.com"
# ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


echo "* ssh-keygen -t rsa"
if ssh-keygen -t rsa | grep -q COMMAND_FAILED ; then 
    echo " - Failed to create ssh-keygen -t rsa"
    exit 1
fi

echo "* start a second agent"
if eval "$(ssh-agent -s)" | grep -q COMMAND_FAILED ; then 
    echo " - Failed to create ssh-keygen -t rsa"
    exit 1
fi

echo "* cat .ssh/id_rsa.pub | ssh root@$remoteip 'cat >> .ssh/authorized_keys'"
if cat .ssh/id_rsa.pub >> .ssh/authorized_keys | grep -q COMMAND_FAILED ; then 
  echo " - Failed to move local id_rsa to remote folder: .ssh"
	exit 1
fi

echo "* Fixed permissions"
if chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys; | grep -q COMMAND_FAILED ; then 
	echo " - Failed to assign permissions"
fi

echo "* ssh-add"
if ssh-add | grep -q COMMAND_FAILED ; then 
	echo " - Failed to add ssh permision"
	exit 1
fi

echo "* Done"
