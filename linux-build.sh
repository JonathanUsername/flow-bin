#!/bin/bash

echo "Evaluating opam config..."
eval "$(opam config env)"
echo "Compiling flow for Linux..."
cd flow && make;
