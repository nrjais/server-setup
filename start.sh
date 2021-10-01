#!/bin/bash

set -e
MARKER_FILE=replaced
DATA_MARKER=/data/marker
RCLONE_CONFIG=rclone/rclone.conf
set -a
source /secrets/.env
set +a

replace_secrets() {
  FILES=("$RCLONE_CONFIG")

  for file in "${FILES[@]}"; do
    mv $file ${file}.temp
    envsubst -no-unset -no-empty -o $file -i ${file}.temp
    rm ${file}.temp
  done
  touch $MARKER_FILE
}

fetch_server_data() {
  echo "fetching rclone data"
  rclone --config=$RCLONE_CONFIG copy enc:/ /data
  touch $DATA_MARKER
  echo "fetch completed"
}

[[ -f "$MARKER_FILE" ]] || replace_secrets

[[ -f "$DATA_MARKER" ]] || fetch_server_data

# docker compose up -d --remove-orphans --force-recreate --build
# docker compose up -d --no-deps --build caddy
docker compose up -d --remove-orphans
# docker compose restart caddy

docker image prune -af
