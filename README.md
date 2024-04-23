# Standard workload
The standard workload for computing the energy efficiency of a Kubernetes node.   
Based on the [NAS Parallel Benchmarks](https://www.nas.nasa.gov/software/npb.html).

## Usage
Run this workload on a Kubernetes node and measure the energy efficiency.  
To improve measurement accuracy, the node should not be running any other workloads.

```bash
helm repo add standard-workload-repo https://glaciation-heu.github.io/standard-workload/helm-charts/
helm repo update
helm search repo standard-workload
helm install standard-workload standard-workload-repo/standard-workload
```

## Manual build and deployment on Minikube
### Prerequisites
  - [Docker](https://docs.docker.com/get-docker/)
  - [Helm](https://helm.sh/en/docs/)
  - [Minikube](https://minikube.sigs.k8s.io/docs/start/)

### Build and deployment
1. Install [Minikube](https://minikube.sigs.k8s.io/docs/start/).
2. Start Minikube:
```bash
minikube start
```
1. Build a docker image:
```bash
docker build . -t standard-workload:latest
```
1. Upload the docker image to minikube:
```bash
minikube image load standard-workload:latest
```
1.  Deploy the job:
```bash
helm install standard-workload ./charts/standard-workload
  --version 0.1.0
  --set image.repository=standard-workload
  --set image.tag=latest
```
1. Delete the job:
```bash
helm delete standard-workload
```

## Release
To create a release, add a tag in GIT with the format a.a.a, where 'a' is an integer.
```bash
git tag 0.1.0
git push origin 0.1.0
```
The release version for branches, pull requests, and other tags will be generated based on the last tag of the form a.a.a.

## Helm Chart Versioning
The Helm chart version changed automatically when a new release is created. The version of the Helm chart is equal to the version of the release.

## GitHub Actions
[GitHub Actions](https://docs.github.com/en/actions) triggers testing and builds for each release.  

**Initial setup**  
Create the branch [gh-pages](https://pages.github.com/) and use it as a GitHub page.  

**After execution**    
- The index.yaml file containing the list of Helm Charts will be available at `https://glaciation-heu.github.io/standard-workload/helm-charts/index.yaml`.
- The Docker image will be available at `https://github.com/glaciation-heu/standard-workload/pkgs/container/standard-workload`.

# Collaboration guidelines
HIRO uses and requires from its partners [GitFlow with Forks](https://hirodevops.notion.site/GitFlow-with-Forks-3b737784e4fc40eaa007f04aed49bb2e?pvs=4)

## License
[MIT](https://choosealicense.com/licenses/mit/)