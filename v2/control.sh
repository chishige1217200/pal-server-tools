#!/bin/bash

# tmuxでの識別名を指定
SESSION="palworld"
# PalServer.shのパスを指定
SH_FILE_PATH="/home/palworld/Steam/steamapps/common/PalServer/PalServer.sh"
# サーバ終了時の猶予時間を指定します(60秒以上にする場合はserviceファイルも変更が必要)。
WAIT=30
# 認証トークンを指定
TOKEN=''

start() {
    if tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバは既に起動しています。"
        exit 1
    fi

    if [ ! -f "$SH_FILE_PATH" ]; then
        echo "PalServer.shが見つかりません: $SH_FILE_PATH"
        exit 1
    fi

    tmux new-session -d -s $SESSION "bash $SH_FILE_PATH"
    echo "サーバを起動しました。"
}

stop() {
    if ! tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバが起動していません。"
        exit 1
    fi

    curl -L -X POST 'http://localhost:8212/v1/api/shutdown' \
        -H 'Content-Type: application/json' \
        -H "Authorization: Basic $TOKEN" \
        --data-raw "{
              \"waittime\": $WAIT,
              \"message\": \"$WAIT秒後にサーバーを停止します\"
            }"

    echo ""
    echo "サーバ停止待機中..."
    sleep $WAIT

    while tmux has-session -t $SESSION 2>/dev/null; do
        sleep 1
    done
    echo "サーバを停止しました。"
}

attach() {
    tmux attach -t $SESSION
}

case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
attach)
    attach
    ;;
*)
    echo "Usage: $0 {start|stop|attach}"
    exit 1
esac
