FROM ubuntu:16.04

# Building with standard ubuntu base, m4 is needed
RUN apt-get update \
    && apt-get install -y opam m4

# Change this if they change the compiler version
RUN opam init --comp 4.05.0 \
    && opam update

# Ditto, compiler version
RUN opam switch 4.05.0 \
	&& eval "$(opam config env)" 

# TODO: It complains being in root
WORKDIR /root

# wtf8 is needed, so we compile and add that
RUN git clone https://github.com/flowtype/ocaml-wtf8.git \
	&& cd ocaml-wtf8 \
	&& opam pin add wtf8 .

COPY linux-build.sh linux-build.sh

# Grab my actual source finally and compile that. Should be last step because it'll change the most, hopefully
RUN git clone https://github.com/JonathanUsername/flow.git \
	&& cd flow \
	&& git checkout "${FLOW_VERSION}" \
	&& opam pin add flowtype . -n \
	&& opam install --deps-only flowtype


