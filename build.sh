#!/bin/sh

ls base*/Dockerfile* | xargs -P 3 -n 1 ./build-one.sh
ls extended*/Dockerfile* | xargs -P 3 -n 1 ./build-one.sh

