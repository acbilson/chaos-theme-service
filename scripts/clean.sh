#!/bin/bash
. .env

ENVIRONMENT=$1

case $ENVIRONMENT in

dev)
  echo "backing up sensitive .env file"
  mkdir -p ~/safe/${IMAGE_NAME} && cp .env ~/safe/${IMAGE_NAME}/env.bk

  echo "removing dist/"
  rm -rf dist/

  echo "removing site/"
  rm -rf site/
;;

uat)
  ssh -t ${UAT_HOST} \
    rm -rf ${UAT_DIST}
;;

prod)
  ssh -t ${PROD_HOST} \
    rm -rf ${PRD_DIST}
;;

*)
  echo "please provide one of the following as the first argument: dev, uat, prod."
  exit 1

esac
