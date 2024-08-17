#!/bin/bash

TOKEN=''

rss_text=''
rss=$(ps -eo pid,comm,rss | grep PalServer-Linux | awk '{print $3}')

echo "メモリ使用量監視開始"

if [ -n "$rss" ]; then # 対象プロセスが存在するとき

    if [ $rss -ge $((1024*1024)) ]; then
        rss_text=$(printf '%.2f GB\n' $(echo "$rss / (1024*1024)" | bc -l))
    elif [ $rss -ge 1024 ]; then
        rss_text=$(printf '%.2f MB\n' $(echo "$rss / 1024" | bc -l))
    else
        rss_text="${rss} KB"
    fi

    echo "現在のメモリ使用量: $rss_text"

    curl -L -X POST 'http://localhost:8212/v1/api/announce' \
        -H 'Content-Type: application/json' \
        -H "Authorization: Basic $TOKEN" \
        --data-raw "{
      \"message\": \"現在のメモリ使用量: $rss_text\"
    }"

    echo ""

    if [ $rss -ge $((15*1024*1024)) ]; then # プロセスのRSSが15GBを超過したとき
        echo "閾値超え"

        curl -L -X POST 'http://localhost:8212/v1/api/announce' \
            -H 'Content-Type: application/json' \
            -H "Authorization: Basic $TOKEN" \
            --data-raw "{
      \"message\": \"メモリ使用量が閾値を超えたため、15分後にサーバーを再起動します\"
    }"

        echo ""

        #14分後にサーバの再起動
        at now + 14 min -f /home/palworld/restart.sh
    fi

fi

echo "メモリ使用量監視終了"
