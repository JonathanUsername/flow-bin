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
	&& opam pin add wtf8 ocaml-wtf8

RUN git clone https://github.com/JonathanUsername/flow.git

COPY linux-build.sh linux-build.sh

ENTRYPOINT /root/linux-build.sh
