# OpenShift GitOps

A GitOps repo used to initialize various tools within an OpenShift cluster via argocd.

## Cluster Operations
```
oc label node --all node-role.kubernetes.io/infra=""
oc apply -f gitopsservice.yaml
```
