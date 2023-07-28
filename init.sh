#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
env_filepath="$SCRIPT_DIR/.env"

if [ ! -f "$env_filepath" ]; then
    echo "$env_filepath not found. Please create it from .env.sample"
    exit 1
fi

echo "Exporting variables in ${env_filepath} file into environment"
read -ra args < <(grep -v '^#' "$env_filepath" | xargs)
export "${args[@]}"
