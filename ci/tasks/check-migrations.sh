#!/bin/bash

set -e

# https://stackoverflow.com/a/66118031
# try to create a new migration from our data model
# if it succeeds, that means we missed creating one

apt update -y && apt install jq -y
set -o allexport
source <(cat .env | \sed -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +o allexport
export DATABASE_URI="$(echo "$VCAP_SERVICES" | jq --raw-output --arg service_name "pages-editor-$APP_ENV-rds" ".[][] | select(.name == \$service_name) | .credentials.uri")"
yes \r | PGSSLMODE='no-verify' npm run payload migrate:create check
! find src/migrations -type f -name "*check.ts" -print0 | grep check
