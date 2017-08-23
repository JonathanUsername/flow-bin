#!/bin/bash

cd flow \
	&& git checkout "${FLOW_VERSION}" \
    && ls -al \
	&& git am -3 ../changes.patch \
	&& eval `opam config env` \
    && make;
