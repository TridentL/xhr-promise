#!/bin/bash
set -e

port=3900

# Find next available port
# while lsof -i :$((++port)) >/dev/null; do true; done

# Spin a test server in the background
# node ./test/server.js $port &>/dev/null &
node ./test/server.js $port &
server_pid=$!
trap "kill $server_pid" INT EXIT

node ./node_modules/.bin/mocha-phantomjs -s localToRemoteUrlAccessEnabled=true -s webSecurityEnabled=false "http://localhost:$port/test/test.html"
