#!/bin/bash

### .env File:
source ${PWD}/.env

### Source Code:
for enum in ${ENUMS[@]}; do
  make enum source=${enum}
done
