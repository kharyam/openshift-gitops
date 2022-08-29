# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via ArgoCD.

Run the following commands to create a default ArgoCD instance and initiate the installation of all operators in this repository:

```bash
oc apply -k argocd
# Wait for argo to be available
oc apply -k main
```

Optional - The default synchronization period is 3 minutes.  Set it to a lower value for demo purposes:
```bash
# Set the sync period to 10 seconds
oc patch argocd/openshift-gitops -n openshift-gitops -p '{"spec":{"controller":{"appSync":"10s"}}}' --type=merge

# Restart the repo server
oc scale deployment/openshift-gitops-repo-server -n openshift-gitops --replicas=0
```

## Operators

The following sub-sections describe the operators installed by this repository.

### camelk

### kafka

Also creates a `KafkaCluster` in the `kafka` namespace.

---
**NOTE**
[The subscription](operators/kafka/kafka-subscription.yaml) sets the environment variable `FIPS_MODE` to `disabled` to allow the operator to work properly in a FIPS enabled OpenShift installation.
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

1. Delete the application sets (Will take a while, monitor progresss in argocd):
    ```bash
    oc delete appset openshift-operators-instances --cascade=foreground --wait -n openshift-gitops
    oc delete appset openshift-operators --cascade=foreground --wait -n openshift-gitops
    ```
2. Delete the `knative-*` projects. 
   ```bash
    oc get project --no-headers -o custom-columns=NAME:..metadata.name | grep knative | xargs oc delete project
   ```
3. Manually delete all the remaining operators (cluster service versions) in the admin web console or by cli:
   ```bash
   # Delete individual CSVs
   oc get csv -n opesnhift-operators
   oc delete csv <NAME_HERE> -n openshift-operators

   # OR Delete all CSVs except the gitops csv. Only do this if you have not installed additional operators!
   # oc get csv -n openshift-operators --no-headers -o custom-columns=NAME:..metadata.name | grep -v gitops | xargs oc delete csv -n openshift-operators

   ```
4. Run the [service mesh cleanup](https://docs.openshift.com/container-platform/latest/service_mesh/v2x/removing-ossm.html#ossm-remove-cleanup_removing-ossm) script:
    ```bash
    scripts/servicemeshcleanup.sh
    ```
