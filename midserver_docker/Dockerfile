FROM ubuntu

RUN adduser --gid 100 --disabled-login --system servicenow

USER servicenow
ENTRYPOINT ["/home/servicenow/midloop.sh"]
