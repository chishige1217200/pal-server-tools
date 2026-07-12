# pal-server-tools v2
サーバの起動・終了・バックアップをsystemdで自動化します．
Debian/Ubuntuを対象システムとしています。

Proxmoxコンテナを前提としているため、バックアップ機能はスクリプト内にありません。

## Requirements
下記の機能が使用できること。
- bash
- curl
- systemd
- tmux

## How to use
1. `/opt/palworld`に`control.sh`を配置する。
2. `/etc/systemd/system`に`palworld.service`を配置する。
3. `systemctl enable palworld.service`を実行して、OS起動時にサーバプロセスを起動するように設定する。
4. `systemctl start palworld.service`を実行して、サーバプロセスを起動する。

意図的にサーバプロセスを終了したい場合は、`systemctl stop palworld.service`で終了できます。

OS終了時に自動でサーバプロセスが終了されます。  
サーバプロセス終了時の待機時間をデフォルトで30秒に設定しているため、OS終了には30秒以上かかります。  
待機時間は`control.sh`内の`WAIT`で変更できます。
