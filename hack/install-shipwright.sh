#!/bin/bash

set -e

PLATFORM=${1:-k8s}

echo "Installing Shipwright on ${PLATFORM}"
mkdir -p /tmp/shipwright-install
pushd /tmp/shipwright-install

echo "Cloning Shipwright build operator..."
git clone https://github.com/shipwright-io/build.git
pushd build

echo "Installing Shipwright and Tekton..."
hack/install-tekton.sh
hack/shipwright-build.sh install

popd
popd

echo "Cleaning up resources..."
rm -rf /tmp/shipwright-install
echo "Done"