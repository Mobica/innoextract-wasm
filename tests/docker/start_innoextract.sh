#!/bin/bash
sudo echo "password" > /home/.Xauthority
sudo x11vnc -storepasswd innoextract /home/passwd
sudo x11vnc -create -auth /home/.Xauthority -forever -loop -noxdamage -repeat -rfbauth /home/passwd -rfbport 5999 -shared -display :99 &
cd /home/innoextract-wasm/build && python3 -m http.server > innoextract_server.log &
sleep 4
cd /home/innoextract-wasm/tests/
exec python3 -m robot --report NONE --outputdir output --logtitle "Task log" -v HOME_PAGE_PATH:http://localhost:8000 tests/smoke_tests.robot
