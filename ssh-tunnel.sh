#!/bin/sh
set -e

export SSH_HOSTS="/root/ssh-hosts/"

# check for mandatory environment variables and exit if not defined
[[ -z "$SSH_HOSTS" ]] && { echo "Please specify SSH_HOSTS" ; exit 1; }
[[ -z "$SSH_USER" ]] && { echo "Please specify SSH_USER" ; exit 1; }

for HOSTINFO in `ls ${SSH_HOSTS}`
do
  REMOTE_HOST=${HOSTINFO}
  LOCAL_PORT=`cat ${SSH_HOSTS}/${HOSTINFO}`
  # autossh -M 0 -f -o "StrictHostKeyChecking no" -o "ExitOnForwardFailure yes" -o "BatchMode yes" -o "ConnectionAttempts 3" -NL ${LOCAL_PORT}:localhost:3306 ${SSH_USER}@${REMOTE_HOST}
  autossh -M 0 -f -o "StrictHostKeyChecking no" -o "ExitOnForwardFailure yes" -o "BatchMode yes" -o "ConnectionAttempts 3" -o "GatewayPorts yes" -gNL *:${LOCAL_PORT}:0.0.0.0:3306 ${SSH_USER}@${REMOTE_HOST}
done

## hang forever until killed
tail -f /dev/null
