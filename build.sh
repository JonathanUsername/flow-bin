#!/bin/bash
set -e

if [ "$#" -eq 0 ]; then
    VERSION=$(node -p 'require("./package.json").version');
    echo 'Taking version/branch $VERSION from package.json since one was not supplied. Please ensure it is an extant branch. Usage: ./build.sh "v0.53.1";';
else
    BRANCH=$1;
    EXTRA="$2";
    VERSION="$BRANCH-$EXTRA"
fi

echo "Branch in jonathanusername/flow is: $BRANCH"
echo "Extra suffix to eventual version is: $EXTRA"
echo "Full version to include in package.json will be: $VERSION"

exit 0

if [ ! -d 'flow-src/' ]; then
    git clone git@github.com:JonathanUsername/flow.git flow-src;
fi;

pushd flow-src;

# I'm giving up on old way of applying patches, easier to adjust in jonathanusername/flow, make a new branch with the right version and then just pull the new version here, but for posterity, I used to do it like this:  && git am -3 < ../changes.patch && make || exit 1

git fetch && git checkout "$BRANCH" && make || exit 1 

popd;

mv flow-src/bin/flow dist/mac/flow
echo 'Mac binaries installed'

docker build -t flow-bin .
docker run -it  -v `pwd`/dist/linux:/home/opam/flow/bin -e "FLOW_VERSION=$BRANCH" flow-bin:latest '/home/opam/linux-build.sh' \
    && echo 'Linux binaries installed'


rewrite_package_version() {
  cat package.json | jq "to_entries | map(if .key == "version" then . + {\"value\": \"$VERSION\"} else . end) | from_entries" > package.json
}

rewrite_package_version && 'Build complete. Please run `npm publish --access=public` if ready to roll.'
