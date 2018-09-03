#!/bin/bash
set -e

echo 'Usage: ./build.sh 0.57.3 1         That will create v0.57.3-1. The last arg is optional.'

BRANCH="v$1";
[[ -n "$2" ]] && EXTRA="-$2" || EXTRA="";
VERSION="$1$EXTRA"

echo "Branch in jonathanusername/flow is: $BRANCH"
echo "Extra suffix to eventual version is: $EXTRA"
echo "Full version to include in package.json will be: $VERSION"

SRC_DIR='flow-src'
if [ -d $SRC_DIR ]; then
    rm -rf $SRC_DIR
fi;

git clone git@github.com:JonathanUsername/flow.git $SRC_DIR;

pushd $SRC_DIR;

# I'm giving up on old way of applying patches, easier to adjust in jonathanusername/flow, make a new branch with the right version and then just pull the new version here, but for posterity, I used to do it like this:  && git am -3 < ../changes.patch && make || exit 1

git fetch && git checkout "$BRANCH" && make || exit 1 

popd;

mv flow-src/bin/flow dist/mac/flow
echo 'Mac binaries installed'

echo 'Building linux binaries in docker. If this fails, try building with --no-cache and re-running'
docker build --no-cache -t flow-bin .
docker run -it  -v `pwd`/dist/linux:/root/flow/bin -e "FLOW_VERSION=$BRANCH" flow-bin:latest '/root/linux-build.sh'
echo 'Linux binaries installed' 


rewrite_package_version() {
  NEWPACK=$(cat package.json | jq "to_entries | map(if .key == \"version\" then . + {\"value\": \"$VERSION\"} else . end) | from_entries")
  echo "$NEWPACK"
}

rewrite_package_version && echo 'Build complete. Please run `npm publish --access=public` if ready to roll.' || echo 'Errors ahoy!';
