#!/bin/bash

bail()
{
  echo "$1"
  exit 1
}

if [ -z "${VNCADDR}" ]; then
  bail "VNCADDR cannot be null!"
fi

unset SSLCERT
unset SSLARG
if [ -n "${CERTFILE}" ]; then
  SSLCERT="/cert/${CERTFILE}"
  if [ -e "${SSLCERT}" ]; then
    SSLARG="--cert=${SSLCERT}"
  else
    bail "${SSLCERT} does not exist!"
  fi
fi

exec websockify --web=/usr/share/novnc/ ${SSLARG} 8080 "${VNCADDR}"
