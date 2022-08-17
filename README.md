# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via ArgoCD.

Run the following commands to create a default ArgoCD instance and initiate the installation of all operators in this repository

```bash
oc apply -k argocd
# Wait for argo to be available
oc apply -k main
```

## Operators

The following sub-sections describe the operators installed by this repository.

### camelk

### kafka

Also creates a `KafkaCluster` in the `kafka` namespace.

---
**NOTE**
If running with FIPS enabled, [patch the deployment to disable FIPS mode](https://access.redhat.com/documentation/en-us/red_hat_amq_streams/2.1/html/release_notes_for_amq_streams_2.1_on_openshift/enhancements-str), e.g.,
```bash
oc set env deployment/amq-streams-cluster-operator-v2.1.0-6 -n openshift-operators \
   FIPS_MODE=disabled
```
---

### knative

Also creates `KnativeEventing`, `KnativeServing`, and `KnativeKafka` instances in the correct namespaces. The `KnativeKafka` instance references the `KafkaCluster` that is created in the `kafka` namespace.

### netobserv

A non-production Loki instance and `FlowControl` object will also be created. NetObserv will be available in the admin console.

### servicemesh

This repository also installs the operators required by service mesh:

* jaeger
* kiali
* elasticsearch

## Deletion

1. Delete the application set:
    ```bash
    oc delete appset openshift-gitops -n openshift-gitops
    ```
2. Delete the `knative-eventing`, `knative-serving`, `knative-serving-ingress` namespaces. (May require deleting the *KnativeEventing* object from the `knative-eventing` namespace and the *KnativeServing* object from the `knative-serving` namespaces)
   ```bash
    oc delete project knative-eventing knative-serving knative-serving-ingress
   ```
3. Manually delete all the remaining operators (cluster service versions) in the admin web console or by cli:
   ```bash
   oc get csv -n opesnhift-operators
   oc delete csv <NAME_HERE> -n openshift-operators
   ```
4. Run the [service mesh cleanup](https://docs.openshift.com/container-platform/latest/service_mesh/v2x/removing-ossm.html#ossm-remove-cleanup_removing-ossm) script:
    ```bash
    scripts/servicemeshcleanup.sh
    ```
