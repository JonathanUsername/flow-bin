#!/bin/bash

if [[ -z "$FLOW_VERSION" ]]; then
    echo "I was not passed a FLOW_VERSION variable! Aborting..."
    exit 1;
fi

# installing lwt at specific version before they broke everything in 4, this may get better in a later release of flow but who knows
# might also need && opam install -y lwt_log \
cd flow \
    && git checkout "$FLOW_VERSION" \
    && opam repo add ocaml.org 'https://opam.ocaml.org' \
    && opam init -a --comp 4.03.0 \
    && opam switch 4.03.0 \
    && eval $(opam config env) \
    && opam update \
    && opam install -y 'lwt=3.3.0' \
    && opam pin add flowtype . -n \
    && opam install -y --deps-only flowtype \
    && make;
