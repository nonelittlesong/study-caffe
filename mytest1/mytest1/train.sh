#!/usr/bin/env sh
set -e
./build/tools/caffe train --solver=models/bvlc_alexnet/solver.prototxt $@
