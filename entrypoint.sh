#!/bin/bash

set -e

if [ -z "$JIRA_BASE_URL" ]; then
  echo "JIRA_BASE_URL is not set"
  exit 1
fi

if [ -z "$JIRA_API_TOKEN" ]; then
  echo "JIRA_API_TOKEN is not set"
  exit 1
fi

if [ -z "$JIRA_AUTH_EMAIL" ]; then
  echo "JIRA_AUTH_EMAIL is not set"
  exit 1
fi

echo "Starting ACLI..."

acli --version || {
  echo "ACLI is not installed or not found in PATH"
  exit 1
}

echo $JIRA_API_TOKEN | acli jira auth login --site $JIRA_BASE_URL --email $JIRA_AUTH_EMAIL --token || {
  echo "Failed to authenticate with ACLI"
  exit 1
}

RESULTS=$(acli jira workitem view ZZM-3610) || {
  echo "Failed to search work items with ACLI"
  exit 1
}

# Print results to stdout and set action output
echo "ACLI results:"
echo "${RESULTS}"
