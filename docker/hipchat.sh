#!/bin/bash

# Set the ROOM_ID & AUTH_TOKEN variables below.
# Further instructions at https://www.hipchat.com/docs/apiv2/auth
check=$(ps -ef | grep java | grep -v grep)
if [[ "${check}" ]]; then
echo "running"
exit 0
else
     ROOM_ID=3338070
     AUTH_TOKEN=UCSvRnxFZRpVNsUUVGuCgOsIGoPdGTpKlb23iBUm
     MESSAGE="TORO integrate is down!"

     curl -H "Content-Type: application/json" \
          -X POST \
          -d "{\"color\": \"purple\", \"message_format\": \"text\", \"message\": \"$MESSAGE\" }" \
          https://api.hipchat.com/v2/room/$ROOM_ID/notification?auth_token=$AUTH_TOKEN
        exit 1
	
fi
