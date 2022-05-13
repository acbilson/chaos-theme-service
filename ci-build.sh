#!/bin/bash

selected_rev=${1:0:7}
current_rev=$(git rev-parse --short HEAD)

if [ $selected_rev = $current_rev ]; then
   podman build --target=prod -t acbilson/chaos-theme-service-$current_rev:alpine -t acbilson/chaos-theme-service:latest .;
else
   echo "the current git commit and the selected commit do not match";
fi
