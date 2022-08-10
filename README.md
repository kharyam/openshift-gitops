# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via argocd.

## kafka

If running with FIPS enabled, [patch the deployment to disable FIPS mode](https://access.redhat.com/documentation/en-us/red_hat_amq_streams/2.1/html/release_notes_for_amq_streams_2.1_on_openshift/enhancements-str), e.g.,
```bash
oc set env deployment/amq-streams-cluster-operator-v2.1.0-6 -n openshift-operators FIPS_MODE=disable
```
