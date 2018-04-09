FROM ocaml/opam:ubuntu

RUN opam update \
    && opam init --comp 4.03.0 

RUN opam switch 4.03.0 \
	&& eval "$(opam config env)" 

COPY linux-build.sh linux-build.sh

RUN git clone https://github.com/flowtype/ocaml-wtf8.git \
	&& cd ocaml-wtf8 \
	&& opam pin add wtf8 . \
	&& cd .. \
	&& git clone https://github.com/JonathanUsername/flow.git \
	&& cd flow \
	&& git checkout "${FLOW_VERSION}" \
	&& opam pin add flowtype . -n \
	&& opam install --deps-only flowtype

