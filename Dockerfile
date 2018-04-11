FROM ocaml/opam:ubuntu

RUN opam init -a --comp 4.03.0 \
    && opam switch 4.03.0

COPY linux-build.sh linux-build.sh

RUN git clone https://github.com/JonathanUsername/flow.git

