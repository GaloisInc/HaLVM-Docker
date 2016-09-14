#!/bin/sh

file=$1
name=halvm/`echo ${file} | sed -e "s!/.*!!g"`
tag=`echo ${file} | sed -e "s/^.*Dockerfile.//g"`
docker build --no-cache -t ${name}:${tag} -f ${file} .
 
