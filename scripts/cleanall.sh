#!/bin/bash
echo "This will take a while..."

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
oc delete appset openshift-operators-instances --cascade=foreground --wait -n openshift-gitops
oc delete appset openshift-operators --cascade=foreground --wait -n openshift-gitops
oc get project --no-headers -o custom-columns=NAME:..metadata.name | grep knative | xargs oc delete project
oc get csv -n openshift-operators --no-headers -o custom-columns=NAME:..metadata.name | grep -v gitops | xargs oc delete csv -n openshift-operators --cascade=foreground --wait

$SCRIPT_DIR/servicemeshcleanup.sh
