FROM ocaml/opam:ubuntu

RUN opam init --comp 4.03.0 \
	&& opam update \
	&& opam install -y ocamlfind sedlex \
    && eval `opam config env`;

RUN git clone https://github.com/JonathanUsername/flow.git

COPY linux-build.sh linux-build.sh
ADD changes.patch changes.patch

