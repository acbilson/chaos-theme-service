#!/bin/bash
. .env

ENVIRONMENT=$1

case $ENVIRONMENT in

uat)
  echo "runs container in uat..."
  ssh -t ${UAT_HOST} \
    sudo podman run --rm -d \
      --expose ${UAT_EXPOSED_PORT} -p ${UAT_EXPOSED_PORT}:${CONTAINER_PORT} \
      -e "FLASK_SECRET_KEY=${FLASK_SECRET_KEY}" \
      -v ${UAT_CONTENT_SRC}:${CONTENT_DST} \
      --name ${UAT_IMAGE_NAME} \
      ${USER_NAME}/${UAT_IMAGE_NAME}:${IMAGE_TYPE}
;;

prod)
  echo "enabling ${IMAGE_NAME} service..."
  ssh -t ${PROD_HOST} sudo systemctl daemon-reload
  ssh -t ${PROD_HOST} sudo systemctl enable --now container-${IMAGE_NAME}.service
;;

*)
  echo "please provide one of the following as the first argument: uat, prod."
  exit 1

esac
