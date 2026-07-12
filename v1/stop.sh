#!/bin/bash

TOKEN=''
WAIT=30

#サーバの終了
curl -L -X POST 'http://localhost:8212/v1/api/shutdown' \
    -H 'Content-Type: application/json' \
    -H "Authorization: Basic $TOKEN" \
    --data-raw "{
          \"waittime\": $WAIT,
          \"message\": \"$WAIT秒後にサーバーを停止します\"
        }"

echo ""

echo "Server will stop in '${WAIT} seconds'..."

sleep $WAIT # サーバ終了待ち

echo "Server stopped."
