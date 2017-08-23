# flow-bin [![Build Status](https://travis-ci.org/flowtype/flow-bin.svg?branch=master)](https://travis-ci.org/flowtype/flow-bin)

## How to run this fork

Change the version of package.json to match the version of the fork of flow you want to download. There must be a release for that version of the fork of flow (JonathanUsername/flow).

```
./build.sh $VERSION_OR_BRANCH
```

This should clone the fork of flow, run the patch against it and then compile it ready to be included in the repo.

** THIS REQUIRES MANUALLY COMPILING OCAML ON YOUR MACHINE **

Please follow instructions on http://github.com/facebook/flow for how to prepare yourself for compilation from source.



> Binary wrapper for [Flow](http://flowtype.org) - A static type checker for JavaScript

OS X, Linux (64-bit) and Windows binaries are currently [provided](http://flowtype.org/docs/getting-started.html#_).


## CLI

```
$ npm install --global flow-bin
```

```
$ flow --help
```


## API

```
$ npm install --save flow-bin
```

```js
const execFile = require('child_process').execFile;
const flow = require('flow-bin');

execFile(flow, ['check'], (err, stdout) => {
	console.log(stdout);
});
```


## License

flow-bin is BSD-licensed. We also provide an additional patent grant.


## Releases

### New Release

1. Update the "version" in `package.json` to reflect the flow version to publish. (For now, `flow-bin`'s version is also the version of the `flow` binary).
2. Run `make`.
  * There should be 2 uncommitted changes at this point: `SHASUM256.txt` and `package.json`.
3. Commit the changes with the message `Updated binary to v0.30.0`, with the correct version.
4. Push/merge to `master`.
5. Tag the update:

  ```sh
  git checkout master &&
  git pull &&
  make test &&
  git tag v$(node -p 'require("./package.json").version') &&
  git push v$(node -p 'require("./package.json").version')
  ```

6. Publish to npm.

### Inspect a Release Before Publishing

```sh
npm pack
tar xf "flow-bin-$(node -p 'require("./package.json").version').tgz"
cd package
npm run verify
```
