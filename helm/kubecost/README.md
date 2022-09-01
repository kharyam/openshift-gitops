# Kube Cost

## TODO!!
Deploy using [these directions](https://guide.kubecost.com/hc/en-us/articles/8241029276567-Install-Kubecost-on-Redhat-OpenShift-cluster) after the kubecost folks respond with a fix to a permission denied error due to permissions on the /data directory within the prometheus server pod.

## Updating this repo
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm pull kubecost/cost-analyzer
tar -xzvf cost-analyzer-1.96.0.tgz

## [Manual Install](https://guide.kubecost.com/hc/en-us/articles/4407601821207-Installing-Kubecost)

Manual installation for reference:
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm upgrade --install kubecost kubecost/cost-analyzer --namespace kubecost --create-namespace
