#!/bin/sh

KINDS=`find * -type d -depth 0 -name "[a-z]*"`
RECENT=fedora24

for k in ${KINDS}; do
  ID=$(docker images halvm/$k | grep ${RECENT} | awk "{print \$3}")
  docker tag ${ID} halvm/$k:latest
done
