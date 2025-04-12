#!/bin/bash

# this will read in credentials
source ./common.lib

# GATEWAY_URL is optional argument
# if ignore this argument, then it uses the Public DT API
# Base URL to an ActiveGate is https://{your-activegate-domain}:9999/e/{your-environment-id}
# example usage with an ActiveGate argument
# ./sendlogs.sh https://111.222.333.444:9999/e/dyk71272

GATEWAY_URL=$1

if [ -z "${GATEWAY_URL}" ]; then
  DT_API_URL=$DT_BASE_URL
else
  DT_API_URL=$GATEWAY_URL
fi
echo "Sending logs to $DT_API_URL"

for loop in {1..100};
do
  if [ $(expr $loop % 10) == "0" ]; then
    level="error"
  else
    level="info"
  fi

  echo "loop #: $loop Sending log level $level"
  curl -k -X POST \
  ${DT_API_URL}/api/v2/logs/ingest \
  -H 'Content-Type: application/json; charset=utf-8' \
  -H 'Authorization: Api-Token '$DT_API_TOKEN' ' \
  -d '[
    {
     "attribute-a": "Custom Log Message '$loop'",
     "attribute-b": "'$loop'",
     "attribute-c": "Log level '$level' Loop '$loop'",    
     "attribute-d": "'$level'"
    }
   ]'
done


