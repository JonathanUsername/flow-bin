#!/bin/bash

set -e

echo "FLOW_VERSION=${FLOW_VERSION}"
if [[ -z ${FLOW_VERSION} ]]; then
    echo "flow version env var not set!"
    exit 1;
fi

cd flow
echo "Changing to correct branch..."
git fetch
git checkout "${FLOW_VERSION}"
echo "Updating opam deps..."
opam pin add flowtype . -n
opam install -y --deps-only flowtype
echo "Evaluating opam config..."
eval "$(opam config env)"
echo "Compiling flow for Linux..."
make;
