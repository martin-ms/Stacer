#!/bin/bash

rm -rf build

cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -j $(nproc)
strip -s build/output/stacer build/output/lib/libstacer-core.a

./build/output/stacer
