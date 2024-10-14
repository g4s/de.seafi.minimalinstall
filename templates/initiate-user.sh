#! /usr/bin/env bash

$REMOTE_SCRIPT="{{ initiate_script }}"

if [[ -e ${HOME}/.initiate ]]; then
  # isolate tmp-dir to user
  export TMPDIR="${HOME}/.local/tmp"
  export TEMP=${TMPDIR}
  export TMP=${TMPDIR}
  mktemp

  # installing ellipsis and source the installaton script
  source <(curl -s ellipsis.sh)
  export PATH=$PATH:${HOME}/.ellipsis/bin
  source <(curl -s ${REMOTE_SCRIPT})

  # finally remove the intiate-flag
  rm -f ${HOME}/.initiate
fi