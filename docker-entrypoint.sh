#!/usr/bin/env bash
set -e

case "$1" in
        btsync-init)
            if [ ! -s /btsync/btsync.conf ]; then
                echo "File not found!"
                # generate secret key if ENV varibale has no value
                : ${BTSYNC_SECRET:=`btsync --generate-secret`}
                # store value of secret key in file
                echo $BTSYNC_SECRET > /btsync/secret

                echo `btsync --get-ro-secret $BTSYNC_SECRET` > /btsync/ro_secret

                # generate config file
                echo "{
                    \"device_name\": \"Sync Server\",
                    \"listening_port\": $BTSYNC_LISTENING_PORT,
                    \"storage_path\": \"/btsync/.sync\",
                    \"pid_file\": \"/var/run/btsync/btsync.pid\",
                    \"check_for_updates\": false,
                    \"use_upnp\": $BTSYNC_USE_UPNP,
                    \"download_limit\": $BTSYNC_DOWNLOAD_LIMIT,
                    \"upload_limit\": $BTSYNC_UPLOAD_LIMIT,
                    \"shared_folders\": [
                        {
                            \"secret\": \"$BTSYNC_SECRET\",
                            \"dir\": \"/data\",
                            \"use_relay_server\": $BTSYNC_USE_RELAY_SERVER,
                            \"use_tracker\": $BTSYNC_USE_TRACKER,
                            \"use_dht\": $BTSYNC_USE_DHT,
                            \"search_lan\": $BTSYNC_SEARCH_LAN,
                            \"use_sync_trash\": $BTSYNC_USE_SYNC_TRASH
                        }
                    ]
                }" > /btsync/btsync.conf
            fi

            exec btsync --config /btsync/btsync.conf --nodaemon "$@"
                    ;;
        *)
            exec "$@"
esac




