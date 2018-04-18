#!/bin/sh
NAME=amule

if [ ! "$(docker ps -q -f name=$NAME)" ]; then
    echo "No running container with name $NAME"
    if [ "$(docker ps -aq -f status=exited -f name=$NAME)" ]; then
        echo "Found exited container, removing it now."
        # cleanup
        docker rm $NAME
    fi
    # run your container
    echo "Starting container $NAME"

    docker run -d \
    --name $NAME \
    --restart=unless-stopped \
    -p 4811:4711 \
    -p 9062:9062 \
    -p 9072:9072/udp \
    -v /dockerdata/amule/config:/home/amule/.aMule \
    -v /dockerdata/amule/downloads:/incoming \
    tchabaud/amule

else
    echo "Active container with name $NAME found. Exiting"
fi
