#!/bin/bash
# /startup.sh
xvfb-run -n 99 -e /dev/stdout -s '-screen 0 1366x768x24' -f /home/.Xauthority sh -c 'startlxde& /home/start_innoextract.sh'
cp -r /home/innoextract-wasm/tests/output/ /artifacts
