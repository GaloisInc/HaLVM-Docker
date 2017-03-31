#!/bin/sh

FEDORA_VERSIONS="24 25"
UBUNTU_VERSIONS="trusty xenial"
CENTOS_VERSIONS="7"

function build_image() {
  NAME=$1
  TEMPLATE=$2
  VERSION=$3
  LIBTOOL=$4
  EXTRA_FILE=$5

  DIR=`mktemp -d`
  sed -e "s/VERSION/${VERSION}/g" -e "s/LIBTOOL/${LIBTOOL}/g" ${TEMPLATE} > ${DIR}/Dockerfile
  cp ${EXTRA_FILE} ${DIR}/
  pushd ${DIR}
  docker build -t halvm/builder:${NAME} -f Dockerfile .
  popd
  rm -rf ${DIR}
}

for v in ${FEDORA_VERSIONS}; do
  echo "Building Fedora $v builder."
  build_image "fedora-$v" "builders/Dockerfile.fedora" $v "" "builders/ubuntu.zshrc"
done

for v in ${UBUNTU_VERSIONS}; do
  echo "Building Ubuntu $v builder."
  if [ "trusty" = $v ]; then
    LIBTOOL="libtool"
  else
    LIBTOOL="libtool-bin"
  fi
  build_image "ubuntu-$v" "builders/Dockerfile.ubuntu" $v $LIBTOOL "builders/ubuntu.zshrc"
done

for v in ${CENTOS_VERSIONS}; do
  echo "Building CentOS $v builder."
  build_image "centos-$v" "builders/Dockerfile.centos" $v "" "builders/centos-ghc.repo"
done

