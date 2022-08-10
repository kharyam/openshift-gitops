# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via argocd.

After [installing the GitOps operator](https://docs.openshift.com/container-platform/latest/cicd/gitops/installing-openshift-gitops.html):

```bash
cd main
oc apply -k .
```
## Operators

The following operators are installed by this repository

### camelk

### kafka

If running with FIPS enabled, [patch the deployment to disable FIPS mode](https://access.redhat.com/documentation/en-us/red_hat_amq_streams/2.1/html/release_notes_for_amq_streams_2.1_on_openshift/enhancements-str), e.g.,
```bash
oc set env deployment/amq-streams-cluster-operator-v2.1.0-6 -n openshift-operators FIPS_MODE=disable
```

### knative

### netobserv

### servicemesh

This repository also installs the operators required by service mesh:

* jaeger
* kiali
* elasticsearch

If the servicemesh operator is deleted (e.g., by removing the ApplicationSet), run the following script to perform additional cleanup:
```bash
scripts/servicemeshcleanup.sh
```


# TODOs

* Install the gitops operator?
* 