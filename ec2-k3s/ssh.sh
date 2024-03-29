#!/bin/bash

function tf_output(){
  terraform output -raw "$1"
}

rsync -vPr \
  --exclude=".terraform/" \
  --exclude="*.tfstate.*/" \
  -e "ssh $(tf_output server_ssh_args)" \
  ../ "$(tf_output server_username_and_host):~"

eval "$(tf_output server_ssh_command)"
