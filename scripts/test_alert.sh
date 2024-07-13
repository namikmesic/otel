#!/bin/bash

# test_alert.sh
# This script fires or resolves a test alert to Alertmanager

ALERTMANAGER_URL="http://localhost:9093/api/v2/alerts"

function fire_alert() {
  START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  ALERT_PAYLOAD=$(cat <<EOF
[
  {
    "labels": {
      "alertname": "TestAlert",
      "severity": "critical"
    },
    "annotations": {
      "summary": "This is a test alert",
      "description": "This alert is for testing purposes only"
    },
    "startsAt": "$START_TIME"
  }
]
EOF
  )

  curl -X POST -H "Content-Type: application/json" -d "$ALERT_PAYLOAD" "$ALERTMANAGER_URL"
  echo "Test alert fired at $START_TIME"
}

function resolve_alert() {
  START_TIME="2024-07-13T11:47:23.520Z" # Ensure this matches the start time of the fired alert
  END_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  RESOLVE_PAYLOAD=$(cat <<EOF
[
  {
    "labels": {
      "alertname": "TestAlert",
      "severity": "critical"
    },
    "annotations": {
      "summary": "This is a test alert",
      "description": "This alert is for testing purposes only"
    },
    "startsAt": "$START_TIME",
    "endsAt": "$END_TIME"
  }
]
EOF
  )

  curl -X POST -H "Content-Type: application/json" -d "$RESOLVE_PAYLOAD" "$ALERTMANAGER_URL"
  echo "Test alert resolved at $END_TIME"
}

if [ "$1" == "fire" ]; then
  fire_alert
elif [ "$1" == "resolve" ]; then
  resolve_alert
else
  echo "Usage: $0 {fire|resolve}"
fi
