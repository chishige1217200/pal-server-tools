#!/bin/bash

TOKEN=''
WAIT=60

echo "再起動開始"

echo "サーバ終了要求送信"

curl -L -X POST 'http://localhost:8212/v1/api/shutdown' \
    -H 'Content-Type: application/json' \
    -H "Authorization: Basic $TOKEN" \
    --data-raw "{
          \"waittime\": $WAIT,
          \"message\": \"$WAIT秒後にサーバーを停止します\"
        }"

sleep $WAIT # サーバ終了待ち

echo ""

echo "サーバ終了予定時刻"

sleep 30 # サーバプロセス終了待ち

/home/palworld/start.sh

echo "再起動終了"
