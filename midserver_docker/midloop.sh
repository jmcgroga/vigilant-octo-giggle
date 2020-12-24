#!/bin/sh
HOME=/home/servicenow
AGENT=${HOME}/agent
LOGFILE=${AGENT}/logs/midloop.log
RUNNING=1
stopmid() {
    RUNNING=0
    echo "Stopping MID Server on `date`" >> ${LOGFILE}
    ${AGENT}/bin/mid.sh stop
}

trap stopmid SIGHUP SIGINT SIGTERM SIGKILL

echo "Starting midloop.sh" > ${LOGFILE}

${AGENT}/bin/mid.sh start

while [ 1 ]; do 
    sleep 60 &
    wait $!
    if [ ${RUNNING} -eq 0 ]; then
       break
    fi
    ps -p `head -n 1 ${AGENT}/work/mid.pid | tr -d '\n'` -o command= | grep wrapper-linux 
    if [ $? -ne 0 ]; then
        ${AGENT}/bin/mid.sh start
        echo "Restart attempt on `date`" > ${LOGFILE}
    fi
done

echo "Exiting midloop.sh" >> ${LOGFILE}
