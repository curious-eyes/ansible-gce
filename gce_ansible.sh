#!/bin/bash
PLAYBOOK="$1"

if [ -z $PLAYBOOK ]; then
  echo "You need to pass a playback as argument to this script."
  exit 1
fi

export GCE_INI_PATH=$(pwd)/inventory/gce.ini
export SSL_CERT_FILE=$(pwd)/credentials/cacert.pem
export ANSIBLE_HOST_KEY_CHECKING=False

DIR_CRD=$(pwd)"/credentials"
DIR_INV="inventory"
SECRETS_PY=${DIR_CRD}"/secrets.py"

if [ ! -f "$SSL_CERT_FILE" ]; then
  curl -o $DIR_CRD/cacert.pem http://curl.haxx.se/ca/cacert.pem
fi

# generate pkey.pem
if [ ! -f $DIR_CRD/pkey.pem ]; then
  if [ ! -f $DIR_CRD/*.p12 ]; then
    echo "Error: ${DIR_CRD}/*.p12 を配置してください"
    echo "(${DIR_CRD}/pkey.pem を生成します)"
    exit 1
  fi
  for f in $DIR_CRD/*.p12; do
    openssl pkcs12 -in $f -passin pass:notasecret -nodes -nocerts | openssl rsa -out $DIR_CRD/pkey.pem
    break
  done
fi

# setting gce.ini
if [ ! -f $DIR_INV/gce.ini ]; then
  sed -e "s|%absolute-path-to-secrets-py%|${SECRETS_PY}|" $(pwd)\/$DIR_INV\/gce-sample.ini > $(pwd)\/$DIR_INV\/gce.ini
fi

# setting secrets.py
if [ ! -f $SECRETS_PY ]; then
  echo -n "OAuthサービスアカウントのメールアドレス: "
  read gaccount
  echo -n "GCEプロジェクト名: "
  read gproj
  sed -e "s|%developer-gserviceaccount-com%|${gaccount}|" $DIR_CRD\/secrets-sample.py |
    sed -e "s|%path-to-pem%|${DIR_CRD}/pkey.pem|" |
    sed -e "s|%your-project-name%|${gproj}|" > $DIR_CRD\/secrets.py
  # setting gce vars/main.yml
  sed -e "s|%developer-gserviceaccount-com%|${gaccount}|" $(pwd)\/roles\/gce\/vars\/main-sample.yml |
    sed -e "s|%path-to-pem%|${DIR_CRD}/pkey.pem|" |
    sed -e "s|%your-project-name%|${gproj}|" > $(pwd)\/roles\/gce\/vars\/main.yml
fi

ansible-playbook --private-key=$DIR_CRD/pkey.pem -v -i inventory/ "$PLAYBOOK"
