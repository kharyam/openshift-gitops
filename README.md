# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via ArgoCD.

Run the following commands to create a default ArgoCD instance and initiate the installation of all operators in this repository:

```bash
oc apply -k argocd
# Wait for argo to be available
oc apply -k main
```

TODO: This doesn't seem to work
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

