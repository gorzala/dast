#!/bin/bash

usable_services="dancer, chat-dancer, show-dancer, recommendation"

if [ -z ${RUN_ENV} ];
  then 
    echo "You have to provide the path to the docker-compose file as an environment-variable RUN_ENV"
    exit 1;
fi

cd ${RUN_ENV}

function deploy() {
    export SERVICE=$1
    VAR_NAME=${SERVICE^^}_TAG
    VAR_NAME=${VAR_NAME//-/_}
    export ${VAR_NAME}=${2}
    echo "Using Tag var: ${VAR_NAME}"
    echo "With Value: ${!VAR_NAME}"
    echo "Pulling ${SERVICE} with TAG: $2"
    docker-compose pull ${SERVICE}
    docker-compose up -d --no-deps ${SERVICE}
}

case $1 in
    deploy)
        if (( $# == 3 ))   ;
            then
                deploy $2 $3
            else
                echo "the deploy commands needs two parameters"
                
        fi
    ;;
    up)
        docker-compose up -d $2
    ;;
    stop)
        docker-compose stop $2 
    ;;
    ps)
        docker-compose ps
    ;;
    stats)
        docker stats --no-stream
    ;;
    *|help)
        echo "Usage: 2nd-level-wrapper.sh command command_options..."
        echo "Where command can be deploy, up, stop, ps, stats"
        echo "Deploy options are: servicename and tag"

esac