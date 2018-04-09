#!/bin/bash

cd flow \
	&& git checkout "${FLOW_VERSION}" \
    && ls -al \
    && opam update \
	&& opam pin add flowtype . -n \
	&& opam install --deps-only flowtype \
	&& eval `opam config env` \
    && make;
