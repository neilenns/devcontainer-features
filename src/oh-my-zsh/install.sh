#!/usr/bin/env bash
set -e

source functions.sh

SET_LOCALE=${SETLOCALE:-true}
SET_DEFAULT_USER_TO_REMOTE_USER=${SETDEFAULTUSERTOREMOTEUSER:-true}
STRIP_WORKSPACES_FROM_PROMPT=${STRIPWORKSPACESFROMPROMPT:-false}

env >> ~/env.txt

check_and_install ca-certificates

# check if zsh is installed
if which zsh; then
  echo "zsh is already installed"
else
  echo "Installing zsh"
  check_and_install zsh
fi

# set zsh as default shell for the remote user
chsh -s "$(which zsh)" "${_REMOTE_USER}"

check_and_install curl git

if [ "${_REMOTE_USER}" = "root" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
  USER_LOCATION="/root"
else
  #install OhMyZsh as the $_REMOTE_USER
  su - "${_REMOTE_USER}" -c "sh -c $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
  USER_LOCATION="/home/${_REMOTE_USER}"
fi

#install and set locales
if [ "${SET_LOCALE}" = "true" ]; then
  check_and_install locales
  echo "${DESIREDLOCALE}" >>/etc/locale.gen
  locale-gen
fi

ZSH_RC_FILE="${USER_LOCATION}/.zshrc"

if ! [ -f "${ZSH_RC_FILE}" ]; then
  touch "${ZSH_RC_FILE}"
fi

# set the theme
upsert_config_option "^ZSH_THEME=.*$" "ZSH_THEME=\"${THEME}\"" "${ZSH_RC_FILE}"

# set the default user to the container remote user if SETDEFAULTUSERTOREMOTEUSER is true.
if [ "${SET_DEFAULT_USER_TO_REMOTE_USER}" = "true" ]; then
  upsert_config_option "^DEFAULT_USER=.*$" "DEFAULT_USER=\"${_REMOTE_USER}\"" "${ZSH_RC_FILE}"
fi

# configure the plugins
upsert_config_option "^plugins=\\(.*\\)$" "plugins=(${PLUGINS})" "${ZSH_RC_FILE}"

# Add the custom prompt_dir function that strips /workspaces from the prompt.
if [ "${STRIPWORKSPACESFROMPROMPT}" = "true" ]; then
  cat prompt_dir.txt >> "${ZSH_RC_FILE}"
fi

clean_package_cache

echo "Done!"