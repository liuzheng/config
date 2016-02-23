#!/bin/bash

docker ps|grep -q registry
if [ $? == 0 ]; then
    echo 'docker registry already running!'
else
    docker ps -a|grep -q registry
    if [ $? == 0 ]; then
        echo "start docker registry "
    fff=`docker ps -a|grep registry|awk '{print $1}'`
        docker start ${fff}
    else
        echo "run docker registry "
        docker run -d -p 50000:5000 \
            -v /opt/registry:/registry \
            -e STORAGE_PATH=/registry --name registry registry
    fi
fi
