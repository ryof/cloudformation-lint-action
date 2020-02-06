#!/bin/sh -e

cp /matcher.json .
echo "::add-matcher::matcher.json"
set +e
cfn-lint --format parseable "$@" > output
exit_status=$?
set -e
< output sed 's/:E\([0-9]\+\):/:error\1:/' | sed 's/:W\([0-9]\+\):/:warning\1:/' | sed 's/:I\([0-9]\+\):/:debug\1:/'
exit ${exit_status}