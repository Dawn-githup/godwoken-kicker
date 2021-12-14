#!/bin/bash

# import some helper function
source /code/gw_util.sh

cd /code/ckb2
if ! [ -f ckb.toml ]; then
  /bin/ckb init --chain "$CKB_CHAIN" --ba-arg "$BA_ARG" --ba-code-hash "$BA_CODE_HASH" --ba-hash-type "$BA_HASH_TYPE" --ba-message "$BA_MESSAGE"
fi


echo "ready to ckb node2..."

exec /bin/ckb run &

# wait for ckb rpc setup
while true; do
    sleep 1;
    if isCkbRpcRunning "http://localhost:8117";
    then
      echo "start ckb-miner now.."
      break;
    else echo "keep waitting for ckb rpc .."
    fi
done

exec /bin/ckb miner &
exec /bin/ckb miner
