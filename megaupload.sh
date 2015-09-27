#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided. Please specify the remote path to upload to"
    exit 1
fi

DIR=$1

if [ ! -d "/Root/$DIR" ]; then
  echo "Please mount directory you wish to upload using docker -v='/my/path/:/Root/$DIR'"
  exit 1
fi

megamkdir /Root/$DIR
megacopy --local=/Root/$DIR --remote=/Root/$DIR
