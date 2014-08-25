#!/bin/bash
PLAYBOOK="$1"

if [ -z $PLAYBOOK ]; then
  echo "You need to pass a playback as argument to this script."
  exit 1
fi

export GCE_INI_PATH=$(pwd)/inventory/gce.ini
export SSL_CERT_FILE=$(pwd)/credencials/cacert.pem
export ANSIBLE_HOST_KEY_CHECKING=False

if [ ! -f "$SSL_CERT_FILE" ]; then
  curl -O http://curl.haxx.se/ca/cacert.pem
fi

ansible-playbook --private-key=$(pwd)/credencials/pkey.pem -v -i inventory/ "$PLAYBOOK"
