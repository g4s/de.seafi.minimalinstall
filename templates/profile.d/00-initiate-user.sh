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

  if [[ $(command -v op) ]]; then
    if [[ -z ${DISPLAY} ]]; then
      user_email=$(zenity --entry --text "Enter 1password user emaul")
      secret_key=$(zenity --password --text "Enter secret key")
    else
      read -p "Enter 1password user email: " user_email
      read -s "Enter secret key: " secret_key
    fi
    op account add --address agilebit.1password.com --email ${user_mail} --secrete-key ${secret_key}
  fi

  source <(curl -s ${REMOTE_SCRIPT})

  # finally remove the intiate-flag
  rm -f ${HOME}/.initiate
fi