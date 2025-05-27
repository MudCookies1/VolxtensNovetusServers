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
wine reg add "HKCU\Software\Wine\Drivers" /v Audio /d "null" /f 1>/dev/null

echo "
-----------------------------------------------------

		    NOVETUSDOCKER		    

  Github: https://github.com/Mollomm1/NovetusDocker
-----------------------------------------------------
"

/defaults/forceloadserver.sh & wine $NOVETUS_BIN/Novetus.exe -cmdonly -load server -no3d -hostport $PORT -client $CLIENT -map $MAP -maxplayers $MAXPLAYERS
pkill forceloadserver
