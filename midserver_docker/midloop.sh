#!/bin/sh
HOME=/home/servicenow
AGENT=${HOME}/agent
RUNNING=1
stopmid() {
    RUNNING=0
    echo "Stopping MID Server on `date`" > ${HOME}/midloop.log
    ${AGENT}/bin/mid.sh stop
}

trap 'stopmid' SIGTERM

${AGENT}/bin/mid.sh start

while [ 1 ]; do 
    sleep 60
    if [ ${RUNNING} -eq 0 ];
       break
    fi
    ps -p `head -n 1 ${AGENT}/work/mid.pid | tr -d '\n'` -o command= | grep wrapper-linux 
    if [ $? -ne 0 ]; then
        ${AGENT}/bin/mid.sh start
        echo "Restart attempt on `date`" > ${HOME}/midloop.log
    fi
done
