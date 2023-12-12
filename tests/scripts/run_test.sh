#!/bin/sh
cd ~/innoextract-wasm/tests/
exec python3 -m robot --outputdir output --logtitle "Task log" -s smoke_tests ./tests
