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

if [ -z "$JIRA_WORKITEM_KEY" ]; then
  echo "JIRA_WORKITEM_KEY is not set, using default ZZM-3610"
  JIRA_WORKITEM_KEY="ZZM-3610"
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

RESULTS=$(acli jira workitem view $JIRA_WORKITEM_KEY) || {
  echo "Failed to search work items with ACLI"
  exit 1
}

# Print results to stdout and set action output
echo "ACLI results:"
echo "${RESULTS}"

# Set the output for GitHub Actions
echo "results<<EOF" >> $GITHUB_OUTPUT
echo "${RESULTS}" >> $GITHUB_OUTPUT
echo "EOF" >> $GITHUB_OUTPUT
