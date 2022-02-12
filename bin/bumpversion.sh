#!/usr/bin/env bash

CHART="$1"
SCRIPT_PATH=$(dirname "$0")

cd "$SCRIPT_PATH/../charts/$CHART"

shift

exec bumpversion $@
