#!/usr/bin/env bash
export NOVETUS_BIN=/Launcher/data/bin
export PORT=${PORT:-53640}
export MAP=${MAP:-"Z:\\default.rbxl"}
export MAXPLAYERS=${MAXPLAYERS:-12}
export CLIENT=${CLIENT:-"2012M"}

export WINEPREFIX=/home/novetus/.wine
export WINEDEBUG=-all
export SDL_AUDIODRIVER=dummy
export XDG_RUNTIME_DIR=/tmp/sockets
wine reg add "HKCU\Software\Wine\Drivers" /v Audio /d "null" /f 1>/dev/null # force using no audio driver

sed -i '3s/.*/Addons = {"Utils", "URLSetup", "NDUtils"}/' /Launcher/data/addons/core/AddonLoader.lua # change loaded novetus addons

# clean logs
mkdir -p /home/novetus/.wine/drive_c/users/novetus/AppData/Local/Roblox/logs/ 1>/dev/null
rm -rf /home/novetus/.wine/drive_c/users/novetus/AppData/Local/Roblox/logs/* 1>/dev/null

echo "
-----------------------------------------------------

		    NOVETUSDOCKER		    

  Github: https://github.com/Mollomm1/NovetusDocker
-----------------------------------------------------
"

# start everything
cd /defaults
/defaults/forceloadserver.sh &
uvicorn server:app --host 0.0.0.0 --port 3000 --log-level critical > /dev/null 2>&1 &
wine $NOVETUS_BIN/Novetus.exe -cmdonly -load server -no3d -hostport $PORT -client $CLIENT -map $MAP -maxplayers $MAXPLAYERS &
/defaults/getlogs.sh
