#!/bin/sh
IMAGE=$1
shift
NUMBER=$1
shift
COMMAND=$1
shift
ARGUMENTS="$@"
shift

if [ -z "$NUMBER" -o -z "$IMAGE" ]; then
    echo "Usage: `basename $0` <IMAGE TAG> <NUMBER>"
    exit 1
fi

MIDNAME=mid${NUMBER}
SOURCE_CONFIG=`pwd`/${MIDNAME}/servicenow/agent/config.xml
SOURCE_WORK=`pwd`/${MIDNAME}/servicenow/agent/work
SOURCE_KEYSTORE=`pwd`/${MIDNAME}/servicenow/agent/keystore
SOURCE_LOGS=`pwd`/${MIDNAME}/servicenow/agent/logs

if [ ! -e ${SOURCE_CONFIG} ]; then
    echo "${SOURCE_CONFIG} does not exist!"
    mkdir -p `dirname ${SOURCE_CONFIG}`
    `pwd`/generate_config.py ${NUMBER} > ${SOURCE_CONFIG}
fi

if [ ! -d ${SOURCE_WORK} ]; then
    mkdir -p ${SOURCE_WORK}
fi

if [ ! -d ${SOURCE_KEYSTORE} ]; then
    mkdir -p ${SOURCE_KEYSTORE}
fi

if [ ! -d ${SOURCE_LOGS} ]; then
    mkdir -p ${SOURCE_LOGS}
fi

# if [ -z "${COMMAND}" ]; then
#     COMMAND=/bin/bash
# else
#     COMMAND="/bin/bash -c \"${COMMAND}\""
# fi

docker run -it -t -u 0 \
       --mount type=bind,source=`pwd`/servicenow,target=/home/servicenow  \
       --mount type=bind,source=`pwd`/midloop.sh,target=/home/servicenow/midloop.sh  \
       --mount type=bind,source=${SOURCE_CONFIG},target=/home/servicenow/agent/config.xml  \
       --mount type=bind,source=${SOURCE_WORK},target=/home/servicenow/agent/work  \
       --mount type=bind,source=${SOURCE_KEYSTORE},target=/home/servicenow/agent/keystore  \
       --mount type=bind,source=${SOURCE_LOGS},target=/home/servicenow/agent/logs  \
       --entrypoint ${COMMAND} \
       ${IMAGE} \
       ${ARGUMENTS}
