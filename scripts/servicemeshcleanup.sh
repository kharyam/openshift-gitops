# https://docs.openshift.com/container-platform/4.10/service_mesh/v2x/removing-ossm.html

oc delete validatingwebhookconfiguration/openshift-operators.servicemesh-resources.maistra.io
oc delete mutatingwebhookconfigurations/openshift-operators.servicemesh-resources.maistra.io
oc delete svc maistra-admission-controller -n openshift-operators
oc delete -n openshift-operators daemonset/istio-node
oc delete -n openshift-operators daemonset/istio-cni-node
oc delete clusterrole/istio-admin clusterrole/istio-cni clusterrolebinding/istio-cni
oc delete clusterrole istio-view istio-edit
oc delete clusterrole jaegers.jaegertracing.io-v1-admin jaegers.jaegertracing.io-v1-crdview jaegers.jaegertracing.io-v1-edit jaegers.jaegertracing.io-v1-view
oc get crds -o name | grep '.*\.istio\.io' | xargs -r -n 1 oc delete
oc get crds -o name | grep '.*\.maistra\.io' | xargs -r -n 1 oc delete
oc get crds -o name | grep '.*\.kiali\.io' | xargs -r -n 1 oc delete
oc delete crds jaegers.jaegertracing.io
oc delete secret -n openshift-operators maistra-operator-serving-cert
oc delete cm -n openshift-operators maistra-operator-cabundle
