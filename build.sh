#!/bin/sh

buildImage () {
  dockerFile=$1
  imageName=$2
  imageTag=$3

  tmpdir=`mktemp -d -t halvmdocker-XXXXXX` || return 1
  cp $1 ${tmpdir}/Dockerfile
  docker build -t ${imageName}:${imageTag} ${tmpdir} || (rm -rf ${tmpdir} && return 2)
  rm -rf ${tmpdir}
  return 0
}

buildImageFromFile () {
  file=$1
  name=halvm/`echo ${file} | sed -e "s!/.*!!g"`
  tag=`echo ${file} | sed -e "s/^.*Dockerfile.//g"`
  echo "Got name '${name}' and tag '${tag}' from ${file}"
  buildImage "${file}" "${name}" "${tag}"
  return $?
}

buildImagesForSystem () {
  dir=$1
  images=`ls ${dir}*/Dockerfile.*`
  for i in ${images}; do
    buildImageFromFile ${i} || return 3
  done
}

buildImagesForSystem "base" || exit $?
buildImagesForSystem "extended"
# buildImageFromFile "extended-gmp/Dockerfile.fedora23"
