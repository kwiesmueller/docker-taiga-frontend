#!/bin/bash

set -e

public_hostname=${PUBLIC_HOSTNAME:-'taiga.benjamin-borbe.de'}
public_register_enabled=${PUBLIC_REGISTER_ENABLED:-'false'}

sed_script=""
for var in public_register_enabled public_hostname; do
  sed_script+="s,{{$var}},${!var},g;"
done

echo "create conf.json"
cat /taiga/dist/conf.json.template | sed -e "$sed_script" > /taiga/dist/conf.json

echo "starting django $@"
exec "$@"
