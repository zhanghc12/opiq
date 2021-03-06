#!/bin/bash
HASH=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | head -n 1)
GPU=$1
name=${USER}_explore_GPU_${GPU}_${HASH}

echo "Launching container named '${name}' on GPU '${GPU}'"

if hash nvidia-docker 2>/dev/null; then
  cmd=nvidia-docker
else
  cmd=docker
fi

NV_GPU="$GPU" ${cmd} run --rm \
    --name $name \
    --user $(id -u) \
    -v `pwd`:/src \
    -t tabhid/explore \
    ${@:2}
