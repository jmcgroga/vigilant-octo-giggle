FROM ubuntu

RUN adduser --gid 100 --disabled-login --system servicenow

COPY --chown=servicenow:users agent /home/servicenow/agent
COPY --chown=servicenow:users config.xml /home/servicenow/agent/
COPY --chown=servicenow:users midloop.sh /home/servicenow/

USER servicenow
ENTRYPOINT /home/servicenow/midloop.sh
