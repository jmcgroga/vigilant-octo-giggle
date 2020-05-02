#!/bin/sh
HOME=/home/servicenow
AGENT=${HOME}/agent

${AGENT}/bin/mid.sh start

while [ 1 ]; do 
    sleep 60
    ps -p `head -n 1 ${AGENT}/work/mid.pid | tr -d '\n'` -o command= | grep wrapper-linux 
    if [ $? -ne 0 ]; then
        ${AGENT}/bin/mid.sh start
        echo "Restart attempt on `date`" > ${HOME}/midloop.log
    fi
done
