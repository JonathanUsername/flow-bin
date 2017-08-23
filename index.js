/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */
'use strict';

var VERSION = require('./package.json').version;

var path = require('path');

module.exports =
  process.platform === 'darwin'
    ? path.join(__dirname, 'dist/mac/flow') :
  process.platform === 'linux' && process.arch === 'x64'
    ? path.join(__dirname, 'dist/linux/flow') :
  process.platform === 'win32' &&  process.arch === 'x64'
    ? path.join(__dirname, 'flow-win64-v' + VERSION, 'flow.exe') :
  null;
