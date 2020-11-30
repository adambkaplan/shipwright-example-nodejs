<!--
Copyright Adam B. Kaplan

SPDX-License-Identifier: Apache-2.0
-->

# Shipwright NodeJS Example

This is an example of how to build a containerized NodeJS application using Shipwright.
The source contains a simple "Hello World!" NodeJS application using Express.
The `Build` examples use Shipwright to assemble the NodeJS app and push the application to a public
container registry.

## Prerequisites

Before you begin, make sure you have the following:

1. git installed on your computer
2. kubectl or equivalent k8s command line.
3. A kubernetes cluster that you have access to.

## Setup

1. Clone this repository to your computer:

   ```
   $ git clone https://github.com/adambkaplan/shipwright-example-nodejs.git
   ...
   $ cd shipwright-example-nodejs
   ```

2. Install Shipwright on your Kubernetes cluster:

   - Use the install script in this repostiory

      ```bash
      $ hack/install-shipwright.sh
      ``` 
   - Install via OLM and [OperatorHub](https://operatorhub.io/operator/shipwright-operator)

3. Create a new namespace to run your builds:

   ```
   $ kubectl create namespace example-nodejs
   $ kubectl config set-context --current --namespace=example-nodejs
   ```

## Add your push secret

In your namespace, create a `Secret` which contains your credentials to push the container image to
a container registry.

If you have a push secret stored in a docker `config.json` file, create the following secret:

```
$ kubectl create secret generic push-secret \
  --from-file=.dockerconfigjson=~/path/to/your/docker/config.json \
  --type=kubernetes.io/dockerconfigjson
```

## Create the Builds

Next, add the `Build` instances to your namespace:

```
$ kubectl apply -f shipwright/build/
```

## Run a Build With Buildah

With your `Build` objects set, you can now run an instance of a build and view the results.
The following commands will run a build using the `buildah` build strategy, which is installed by
default:

```
$ kubectl apply -f shipwright/buildrun/buildah-buildrun-1.yaml
...
$ kubectl get buildrun buildah-nodejs-build-1
```

After the `Build` completes, you can can view the logs:

```
$ kubectl logs -l buildrun.build.dev/name=buildah-nodejs-build-1 --all-containers
```

## Try Other Build Strategies

You can run the following build strategies using the `BuildRun` instances in this repository:

**Cloud-Native Buildpacks**

```
$ kubectl apply -f shipwright/buildrun/buildpack-buildrun-1.yaml
```

**Kaniko**

```
$ kubectl apply -f shipwright/buildrun/kaniko-buildrun-1.yaml
```

**Source-to-Image (S2I)**

```
$ kubectl apply -f shipwright/buildrun/s2i-buildrun-1.yaml
```
