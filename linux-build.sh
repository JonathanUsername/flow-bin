#!/bin/bash

cd flow \
	&& git checkout "${FLOW_VERSION}" \
    && ls -al \
	&& eval `opam config env` \
    && make;
