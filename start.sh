#!/bin/bash

#screenでの識別名を指定
SCREEN_NAME='palworld'
#PalServer.shのパスを指定
SH_FILE_PATH='/home/palworld/Steam/steamapps/common/PalServer/PalServer.sh'

#サーバの起動
echo "Server is starting..."

screen -UAmdS ${SCREEN_NAME} bash ${SH_FILE_PATH}
