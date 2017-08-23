#!/bin/bash
if [ "$#" -ne 1 ]; then
    VERSION=$(node -p 'require("./package.json").version');
    echo 'Taking version/branch $VERSION from package.json since one was not supplied. Please ensure it is an extant branch. Usage: ./build.sh "v0.53.1";';
else
    VERSION=$1;
fi

if [ ! -d 'flow-src/' ]; then
    git clone git@github.com:JonathanUsername/flow.git flow-src;
fi;

pushd flow-src;

git checkout "$VERSION" && git am -3 < ../changes.patch && make

popd;

mv flow-src/bin/flow dist/mac/flow
echo 'Mac binaries installed'

docker build -t flow-bin .
docker run -it  -v `pwd`/dist/linux:/home/opam/flow/bin -e "FLOW_VERSION=$VERSION" flow-bin:latest '/home/opam/linux-build.sh' \
    && echo 'Linux binaries installed'
