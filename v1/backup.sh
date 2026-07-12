#!/bin/bash

#PalWorldのデータ保存場所を指定
SERVER_DIR=/home/palworld/Steam/steamapps/common/PalServer/Pal/Saved/SaveGames
BACKUP_DIR=/home/palworld/WorldData

DATE=$(date "+%Y-%m-%d_%H:%M:%S")

#バックアップ
cp -r ${SERVER_DIR} ${BACKUP_DIR}/SaveGames_${DATE}
