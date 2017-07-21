#!/bin/bash

# Ubersicht widget : tsushin
# By Ryuei Sasaki
# 2016
# https://github.com/louixs/tsushin

#### sourcing the paths of the necessary commands that are usually in different paths just to make sure they work
whereAwk=$(which awk)
whereCat=$(which cat)
whereNetstat=$(which netstat)

foundPaths="${whereCat///cat}:${whereAwk///awk}:${whereNetstat///netstat}"
####
function getnetwork(){
  export PATH="$foundPaths" &&
  netstat -iw 1 | head -n3 | tail -n1 | awk '{print $3 " " $6}' > "$1/network.db" &
  process=$!
  sleep 1.5
  pkill -P $process

  in=$(cat "$1/network.db" | awk '{print $1}')
  out=$(cat "$1/network.db" | awk '{print $2}')

  echo $in $out
}
####

#### the code below handles cases where a user might have copied files of widget to a non-default widget folder
if [ ! -e "$PWD/assets/network.sh" ]; then
  getnetwork "$PWD/mini-system-charts.widget/assets"
else
  getnetwork "$PWD"
fi
