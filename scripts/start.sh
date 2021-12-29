#!/bin/bash
. .env

ENVIRONMENT=$1

case $ENVIRONMENT in

dev)
docker run --rm \
  --expose ${EXPOSED_PORT} -p ${EXPOSED_PORT}:${CONTAINER_PORT} \
  -e "FLASK_SECRET_KEY=${FLASK_SECRET_KEY}" \
  -e "UAT_CONTENT_SRC=${UAT_CONTENT_SRC}" \
  -e "PRD_CONTENT_SRC=${PRD_CONTENT_SRC}" \
  -v ${CODE_SOURCE_SRC}:${CODE_SOURCE_DST} \
  -v ${DEV_CONTENT_SRC}:${CONTENT_DST} \
  --name ${IMAGE_NAME} \
  ${USER_NAME}/${DEV_IMAGE_NAME}:${IMAGE_TYPE}
;;

test)
# entrypoint args must come after image name (weird)
docker run --rm \
  -v ${CODE_SOURCE_SRC}:${CODE_SOURCE_DST} \
  -v ${DEV_CONTENT_SRC}:${CONTENT_DST} \
  --name ${TST_IMAGE_NAME} \
  --entrypoint "python" \
  ${USER_NAME}/${DEV_IMAGE_NAME}:${IMAGE_TYPE} \
  -m unittest discover tests
;;

*)
  echo "please provide one of the following as the first argument: dev, test."
  exit 1

esac
